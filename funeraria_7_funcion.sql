DELIMITER $$

DROP FUNCTION IF EXISTS contar_servicios_por_sede $$

CREATE FUNCTION contar_servicios_por_sede(id_sede INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total_servicios INT;

    SELECT COUNT(*) INTO total_servicios
    FROM servicio_cementerio
    WHERE sede_funeraria_id_sede_funeraria = id_sede;

    RETURN total_servicios;
END $$

DELIMITER ;

SELECT contar_servicios_por_sede(1) AS total_servicios;
