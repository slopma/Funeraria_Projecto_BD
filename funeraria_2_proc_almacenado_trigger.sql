-- Primero, asegurémonos de que hay funerarias en la tabla sede_funeraria
SELECT * FROM gestion_funeraria.sede_funeraria;

-- Ahora vamos a insertar los osarios y tumbas
DELIMITER $$

CREATE PROCEDURE proc_crear_hueco()
BEGIN
  DECLARE fid INT;
  DECLARE seq INT;  

  -- Iterar sobre cada funeraria (ID 1 a 3)
  SET fid = 1;

  WHILE fid <= 3 DO

    -- Insertar 100 osarios
    SET seq = 1;
    WHILE seq <= 100 DO
      INSERT INTO gestion_funeraria.hueco (cliente_id_cliente, sede_funeraria_id_sede_funeraria, tipo_hueco, estado_hueco, ubicacion, medida)
      VALUES (NULL, fid, 'Tumba', 'Disponible', CONCAT('Osario ', fid, '-', seq), '1x1x1'); -- Medida específica para osarios
      SET seq = seq + 1;
    END WHILE;

    -- Insertar 100 tumbas
    SET seq = 1;
    WHILE seq <= 100 DO
      INSERT INTO gestion_funeraria.hueco (cliente_id_cliente, sede_funeraria_id_sede_funeraria, tipo_hueco, estado_hueco, ubicacion, medida)
      VALUES (NULL, fid, 'Osario', 'Disponible', CONCAT('Tumba ', fid, '-', seq), '2x1x2'); -- Medida específica para tumbas
      SET seq = seq + 1;
    END WHILE;

    SET fid = fid + 1; -- Pasar a la siguiente funeraria
  END WHILE;
END$$

DELIMITER ;

CALL proc_crear_hueco();


DELIMITER //

CREATE PROCEDURE proc_actualizar_fallecimiento_cliente(IN cliente_id INT)
BEGIN
    DECLARE fecha_fallecimiento DATE;
    DECLARE funeraria_id INT;

    -- Paso 1: Obtener la fecha de fallecimiento y la funeraria del cliente
    SELECT ea.fecha_fallecimiento, c.sede_funeraria_id_sede_funeraria
    INTO fecha_fallecimiento, funeraria_id
    FROM gestion_funeraria.expediente_autopsia ea
    JOIN gestion_funeraria.cliente c ON ea.cliente_id_cliente = c.id_cliente
    WHERE ea.cliente_id_cliente = cliente_id;

    -- Paso 2: Verificar si la fecha de fallecimiento es mayor a 5 años
    IF fecha_fallecimiento <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR) THEN
        -- Paso 3: Liberar la tumba del cliente
        UPDATE gestion_funeraria.hueco h
        SET h.cliente_id_cliente = NULL,
            h.estado_hueco = 'Disponible'
        WHERE h.cliente_id_cliente = cliente_id;

        -- Paso 4: Asignar un osario disponible al cliente
        UPDATE gestion_funeraria.hueco h
        JOIN (
            SELECT id_hueco
            FROM gestion_funeraria.hueco
            WHERE tipo_hueco = 'Osario'
            AND estado_hueco = 'Disponible'
            AND sede_funeraria_id_sede_funeraria = funeraria_id
            LIMIT 1  -- Asignar solo un osario
        ) AS osario ON 1 = 1
        SET h.cliente_id_cliente = cliente_id,
            h.estado_hueco = 'Ocupado'
        WHERE h.id_hueco = osario.id_hueco;

    END IF;

END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE proc_asignar_hueco_osario()
BEGIN
    -- Paso 1: Eliminar la tabla temporal si ya existe
    DROP TEMPORARY TABLE IF EXISTS cliente_elegible;

    -- Crear una tabla temporal para almacenar los IDs de los clientes elegibles, asegurando que pertenezcan a la funeraria correcta
    CREATE TEMPORARY TABLE cliente_elegible AS
    SELECT c.id_cliente,
           c.sede_funeraria_id_sede_funeraria,  -- Aseguramos que cada cliente tenga la funeraria correcta
           ROW_NUMBER() OVER (PARTITION BY c.sede_funeraria_id_sede_funeraria ORDER BY c.id_cliente) AS row_num
    FROM gestion_funeraria.cliente c
    JOIN gestion_funeraria.expediente_autopsia ea
      ON c.id_cliente = ea.cliente_id_cliente
    WHERE ea.fecha_fallecimiento <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
    AND c.id_cliente NOT IN (
      SELECT h2.cliente_id_cliente
      FROM gestion_funeraria.hueco h2
      WHERE h2.cliente_id_cliente = c.id_cliente
    );

    -- Paso 2: Crear una tabla temporal para los huecos disponibles por funeraria
    DROP TEMPORARY TABLE IF EXISTS hueco_disponible;

    CREATE TEMPORARY TABLE hueco_disponible AS
    SELECT h.id_hueco,
           h.sede_funeraria_id_sede_funeraria,
           ROW_NUMBER() OVER (PARTITION BY h.sede_funeraria_id_sede_funeraria ORDER BY h.id_hueco) AS row_num
    FROM gestion_funeraria.hueco h
    WHERE h.estado_hueco = 'Disponible'
    AND h.tipo_hueco = 'Osario'
    ORDER BY h.id_hueco;

    -- Paso 3: Asignar los clientes a los huecos disponibles en la misma funeraria
    UPDATE gestion_funeraria.hueco h
    JOIN hueco_disponible hd ON h.id_hueco = hd.id_hueco
    JOIN cliente_elegible ce ON hd.row_num = ce.row_num
    AND hd.sede_funeraria_id_sede_funeraria = ce.sede_funeraria_id_sede_funeraria  -- Aseguramos que coincidan las funerarias
    SET h.cliente_id_cliente = ce.id_cliente,
        h.estado_hueco = 'Ocupado';

    -- Paso 4: Eliminar las tablas temporales
    DROP TEMPORARY TABLE IF EXISTS cliente_elegible;
    DROP TEMPORARY TABLE IF EXISTS hueco_disponible;
    
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE proc_asignar_hueco_tumba()
BEGIN
    -- Paso 1: Eliminar la tabla temporal si ya existe
    DROP TEMPORARY TABLE IF EXISTS cliente_elegible;

    -- Crear una tabla temporal para almacenar los IDs de los clientes elegibles, asegurando que pertenezcan a la funeraria correcta
    CREATE TEMPORARY TABLE cliente_elegible AS
    SELECT c.id_cliente,
           c.sede_funeraria_id_sede_funeraria,  -- Aseguramos que cada cliente tenga la funeraria correcta
           ROW_NUMBER() OVER (PARTITION BY c.sede_funeraria_id_sede_funeraria ORDER BY c.id_cliente) AS row_num
    FROM gestion_funeraria.cliente c
    JOIN gestion_funeraria.expediente_autopsia ea
      ON c.id_cliente = ea.cliente_id_cliente
    WHERE ea.fecha_fallecimiento >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
    AND c.id_cliente NOT IN (
      SELECT h2.cliente_id_cliente
      FROM gestion_funeraria.hueco h2
      WHERE h2.cliente_id_cliente = c.id_cliente
    );

    -- Paso 2: Crear una tabla temporal para los huecos disponibles por funeraria
    DROP TEMPORARY TABLE IF EXISTS hueco_disponible;

    CREATE TEMPORARY TABLE hueco_disponible AS
    SELECT h.id_hueco,
           h.sede_funeraria_id_sede_funeraria,
           ROW_NUMBER() OVER (PARTITION BY h.sede_funeraria_id_sede_funeraria ORDER BY h.id_hueco) AS row_num
    FROM gestion_funeraria.hueco h
    WHERE h.estado_hueco = 'Disponible'
    AND h.tipo_hueco = 'Tumba'
    ORDER BY h.id_hueco;

    -- Paso 3: Asignar los clientes a los huecos disponibles en la misma funeraria
    UPDATE gestion_funeraria.hueco h
    JOIN hueco_disponible hd ON h.id_hueco = hd.id_hueco
    JOIN cliente_elegible ce ON hd.row_num = ce.row_num
    AND hd.sede_funeraria_id_sede_funeraria = ce.sede_funeraria_id_sede_funeraria  -- Aseguramos que coincidan las funerarias
    SET h.cliente_id_cliente = ce.id_cliente,
        h.estado_hueco = 'Ocupado';

    -- Paso 4: Eliminar las tablas temporales
    DROP TEMPORARY TABLE IF EXISTS cliente_elegible;
    DROP TEMPORARY TABLE IF EXISTS hueco_disponible;
    
END //

DELIMITER ;




