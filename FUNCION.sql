-- Usar la base de datos llamada gestion_funeraria
USE gestion_funeraria; 
DELIMITER $$  -- Cambiar el delimitador para poder crear la función

-- Crear una función llamada calcular_tiempo_muerto que recibe una fecha
CREATE FUNCTION calcular_tiempo_muerto(fecha_fallecimiento DATE)
RETURNS VARCHAR(100)  -- La función devolverá un texto con un máximo de 100 caracteres
DETERMINISTIC  -- Indica que la función siempre devolverá el mismo resultado para los mismos valores de entrada
BEGIN
    -- Declarar variables para almacenar años, meses y días
    DECLARE años INT;  
    DECLARE meses INT;  
    DECLARE días INT;  
    DECLARE resultado VARCHAR(100);  -- Variable para almacenar el resultado final

    -- Calcular la diferencia en años entre la fecha actual y la fecha de fallecimiento
    SET años = YEAR(CURDATE()) - YEAR(fecha_fallecimiento);  
    -- Calcular la diferencia en meses
    SET meses = MONTH(CURDATE()) - MONTH(fecha_fallecimiento);  
    -- Calcular la diferencia en días
    SET días = DAY(CURDATE()) - DAY(fecha_fallecimiento);  

    -- Ajustar los días y meses si es necesario
    IF días < 0 THEN  -- Si los días son negativos
        -- Sumar los días del mes anterior al total de días
        SET días = días + DAY(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL meses MONTH)));  
        -- Disminuir un mes
        SET meses = meses - 1;  
    END IF;

    -- Ajustar los meses si son negativos
    IF meses < 0 THEN  -- Si los meses son negativos
        -- Sumar 12 meses al total de meses
        SET meses = meses + 12;  
        -- Disminuir un año
        SET años = años - 1;  
    END IF;

    -- Determinar cómo mostrar el resultado
    IF años > 0 THEN  -- Si hay años
        SET resultado = CONCAT(años, ' año(s)');  -- Crear la cadena con el número de años
    ELSEIF meses > 0 THEN  -- Si hay meses
        SET resultado = CONCAT(meses, ' mes(es)');  -- Crear la cadena con el número de meses
    ELSE  -- Si no hay años ni meses
        SET resultado = CONCAT(días, ' día(s)');  -- Crear la cadena con el número de días
    END IF;

    RETURN resultado;  -- Devolver el resultado final
END $$  -- Fin de la función

DELIMITER ;  -- Volver al delimitador original

-- Usar la base de datos gestion_funeraria nuevamente
USE gestion_funeraria;

-- Hacer una consulta para calcular el tiempo muerto de un cliente específico
SELECT calcular_tiempo_muerto(fecha_fallecimiento) AS tiempo_muerto
FROM gestion_funeraria.cliente  -- De la tabla cliente
WHERE id_cliente = 3;  -- Cambia el ID por el cliente que desees consultar
