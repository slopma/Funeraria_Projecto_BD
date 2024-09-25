USE gestion_funeraria;
DELIMITER $$

CREATE FUNCTION calcular_tiempo_muerto(fecha_fallecimiento DATE)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE años INT;
    DECLARE meses INT;
    DECLARE días INT;
    DECLARE resultado VARCHAR(100);

    -- Calcular la diferencia en años, meses y días
    SET años = YEAR(CURDATE()) - YEAR(fecha_fallecimiento);
    SET meses = MONTH(CURDATE()) - MONTH(fecha_fallecimiento);
    SET días = DAY(CURDATE()) - DAY(fecha_fallecimiento);

    -- Ajustar los meses y días si es necesario
    IF días < 0 THEN
        SET días = días + DAY(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL meses MONTH)));
        SET meses = meses - 1;
    END IF;

    IF meses < 0 THEN
        SET meses = meses + 12;
        SET años = años - 1;
    END IF;

    -- Determinar el formato del resultado
    IF años > 0 THEN
        SET resultado = CONCAT(años, ' año(s)');
    ELSEIF meses > 0 THEN
        SET resultado = CONCAT(meses, ' mes(es)');
    ELSE
        SET resultado = CONCAT(días, ' día(s)');
    END IF;

    RETURN resultado;
END $$

DELIMITER ;

USE gestion_funeraria;

SELECT calcular_tiempo_muerto(fecha_fallecimiento) AS tiempo_muerto
FROM gestion_funeraria.cliente
WHERE id_cliente = 3;  -- Cambia el ID por el cliente que desees consultar