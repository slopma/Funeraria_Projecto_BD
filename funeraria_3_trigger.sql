DELIMITER //
SET SQL_SAFE_UPDATES = 0;
CREATE TRIGGER trg_asignar_hueco
AFTER INSERT ON expediente_autopsia
FOR EACH ROW
BEGIN
    DECLARE fecha_fallecimiento DATE;

    -- Obtener la fecha de fallecimiento del cliente recién insertado
    SET fecha_fallecimiento = NEW.fecha_fallecimiento;

    -- Verificar si la fecha de fallecimiento es mayor a 5 años
    IF fecha_fallecimiento <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR) THEN
        -- Llamar al procedimiento para asignar huecos de osarios
        CALL proc_asignar_hueco_osario();
    ELSE
        -- Llamar al procedimiento para asignar huecos de tumbas
        CALL proc_asignar_hueco_tumba();
    END IF;

END //
SET SQL_SAFE_UPDATES = 1;
DELIMITER ;

DELIMITER //
SET SQL_SAFE_UPDATES = 0;
CREATE TRIGGER trg_actualizar_fallecimiento
AFTER UPDATE ON expediente_autopsia
FOR EACH ROW
BEGIN
    -- Llamar al procedimiento solo si la fecha de fallecimiento ha cambiado
    IF OLD.fecha_fallecimiento <> NEW.fecha_fallecimiento THEN
        CALL proc_actualizar_fallecimiento_cliente(NEW.cliente_id_cliente);
    END IF;
END //
SET SQL_SAFE_UPDATES = 1;
DELIMITER ;

DELIMITER //
SET SQL_SAFE_UPDATES = 0;
CREATE TRIGGER trg_log_hueco
AFTER UPDATE ON gestion_funeraria.hueco
FOR EACH ROW
BEGIN
    -- Insertar un registro en la tabla log_huecos
    INSERT INTO log_hueco (hueco_id, cliente_id, funeraria_id, antiguo_estado, nuevo_estado, fecha)
    VALUES (
        NEW.id_hueco,                          -- ID del hueco modificado
        (SELECT h.cliente_id_cliente           -- Obtener el ID del cliente
         FROM gestion_funeraria.hueco h
         WHERE h.id_hueco = NEW.id_hueco),    -- Usar el ID del hueco
        (SELECT c.sede_funeraria_id_sede_funeraria       -- Obtener el ID de la funeraria
         FROM gestion_funeraria.cliente c
         JOIN gestion_funeraria.hueco h ON c.id_cliente = h.cliente_id_cliente
         WHERE h.id_hueco = NEW.id_hueco),     -- Usar el ID del hueco
        OLD.estado_hueco,                      -- Antiguo estado del hueco
        NEW.estado_hueco,                      -- Nuevo estado del hueco
        CURRENT_TIMESTAMP                      -- Fecha del cambio
    );
END //
SET SQL_SAFE_UPDATES = 1;
DELIMITER ;

DELIMITER $$
SET SQL_SAFE_UPDATES = 0;
CREATE TRIGGER verificar_cliente_funeraria
BEFORE INSERT ON expediente_autopsia
FOR EACH ROW
BEGIN
    DECLARE sede_funeraria_cliente INT;
    
    -- Obtener la sede funeraria asociada al cliente
    SELECT sede_funeraria_id_sede_funeraria INTO sede_funeraria_cliente
    FROM cliente
    WHERE id_cliente = NEW.cliente_id_cliente;
    
    -- Verificar que coincidan las sedes funerarias
    IF sede_funeraria_cliente != NEW.sede_funeraria_id_sede_funeraria THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente no pertenece a la sede funeraria indicada';
    END IF;
END $$
SET SQL_SAFE_UPDATES = 1;
DELIMITER ;


DELIMITER //
SET SQL_SAFE_UPDATES = 0;
CREATE TRIGGER despues_actualizar_hueco
AFTER UPDATE ON hueco
FOR EACH ROW
BEGIN
    DECLARE fecha_fallecimiento DATE;
    DECLARE ultimo_servicio TIME; 
    DECLARE servicios_dia INT DEFAULT 0;
    DECLARE nueva_hora_inicio TIME;

    -- Buscar la fecha de fallecimiento del cliente usando JOIN
    SELECT ea.fecha_fallecimiento 
    INTO fecha_fallecimiento
    FROM expediente_autopsia ea
    JOIN cliente c ON ea.cliente_id_cliente = c.id_cliente
    WHERE c.id_cliente = NEW.cliente_id_cliente
    LIMIT 1;

    -- Verifica si el estado ha cambiado a "Ocupado"
    IF NEW.estado_hueco = 'Ocupado' AND OLD.estado_hueco <> 'Ocupado' THEN
        -- Contar cuántos servicios ya hay programados para esa fecha y tipo
        SELECT COUNT(*) INTO servicios_dia
        FROM servicio_cementerio
        WHERE fecha_inicio = DATE_ADD(fecha_fallecimiento, INTERVAL 3 DAY)
          AND tipo_servicio = CASE
                WHEN NEW.tipo_hueco = 'Tumba' THEN 'Entierro'
                WHEN NEW.tipo_hueco = 'Osario' THEN 'Cremación'
            END;

        -- Obtener la hora de fin del último servicio programado
        SELECT COALESCE(MAX(hora_fin), '07:00:00') INTO ultimo_servicio
        FROM servicio_cementerio
        WHERE fecha_inicio = DATE_ADD(fecha_fallecimiento, INTERVAL 3 DAY)
          AND tipo_servicio = CASE
                WHEN NEW.tipo_hueco = 'Tumba' THEN 'Entierro'
                WHEN NEW.tipo_hueco = 'Osario' THEN 'Cremación'
            END;

        -- Si no hay servicios programados, establecer una hora predeterminada
        IF ultimo_servicio IS NULL THEN
            SET ultimo_servicio = '07:00:00';
        END IF;

        -- Sumar 1 segundo a la hora final del último servicio para el nuevo inicio
        IF servicios_dia < 3 THEN
            SET ultimo_servicio = ADDTIME(ultimo_servicio, '00:00:00'); -- Un segundo después del último servicio
        ELSE
            -- Si ya hay 3 o más servicios, usar la misma hora de inicio que el último servicio
            SET ultimo_servicio = ADDTIME(ultimo_servicio, '00:00:00'); -- Puede ajustarse si se necesita algún tiempo adicional
        END IF;

        -- Inserta el nuevo servicio cementerio
        INSERT INTO servicio_cementerio (
            cliente_id_cliente,
            sede_funeraria_id_sede_funeraria,
            tipo_servicio,
            fecha_inicio,
            hora_inicio,
            fecha_fin,
            hora_fin
        ) VALUES (
            NEW.cliente_id_cliente,
            NEW.sede_funeraria_id_sede_funeraria,
            CASE
                WHEN NEW.tipo_hueco = 'Tumba' THEN 'Entierro'
                WHEN NEW.tipo_hueco = 'Osario' THEN 'Cremación'
            END,
            DATE_ADD(fecha_fallecimiento, INTERVAL 3 DAY), -- Sumar 3 días a la fecha de fallecimiento
            ultimo_servicio, -- Hora de inicio ajustada
            DATE_ADD(fecha_fallecimiento, INTERVAL 3 DAY), -- Fecha de fin igual a la de inicio
            ADDTIME(ultimo_servicio, '02:00:00') -- Hora de fin, 2 horas después de la hora de inicio
        );

        -- Ajustar las horas de inicio de los siguientes tres registros si hay más de tres
        SELECT hora_fin INTO nueva_hora_inicio
        FROM (
            SELECT hora_fin
            FROM servicio_cementerio
            WHERE fecha_inicio = DATE_ADD(fecha_fallecimiento, INTERVAL 3 DAY)
              AND tipo_servicio = CASE
                    WHEN NEW.tipo_hueco = 'Tumba' THEN 'Entierro'
                    WHEN NEW.tipo_hueco = 'Osario' THEN 'Cremación'
                END
            ORDER BY hora_inicio DESC
            LIMIT 3
        ) AS subquery
        ORDER BY hora_fin DESC
        LIMIT 1; -- Obtener solo la última hora de fin

        -- Si hay más de tres registros, ajustar el siguiente grupo de tres
        IF servicios_dia >= 3 THEN
            UPDATE servicio_cementerio
            SET hora_inicio = nueva_hora_inicio
            WHERE fecha_inicio = DATE_ADD(fecha_fallecimiento, INTERVAL 3 DAY)
              AND tipo_servicio = CASE
                    WHEN NEW.tipo_hueco = 'Tumba' THEN 'Entierro'
                    WHEN NEW.tipo_hueco = 'Osario' THEN 'Cremación'
                END
              AND hora_inicio > nueva_hora_inicio
            LIMIT 3; -- Cambiar solo los siguientes tres registros
        END IF;

    END IF;
END//
SET SQL_SAFE_UPDATES = 1;
DELIMITER ;


