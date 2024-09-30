DELIMITER $$

DROP FUNCTION IF EXISTS contar_servicio_por_sede $$

CREATE FUNCTION contar_servicio_por_sede(id_sede INT) -- Toma el id de la sede a consultar
RETURNS INT
READS SQL DATA -- Leer la base de datos sin modificarla
BEGIN
    DECLARE total_servicio INT; -- Declarar la variable que almacenará el numero de servicios prestados por la sede a consultar

    SELECT COUNT(*) INTO total_servicio -- Contar los registros que cumplen la condicion y almacenar el numero en ´total servicio´
    FROM servicio_cementerio
    WHERE sede_funeraria_id_sede_funeraria = id_sede;

    RETURN total_servicio;
END $$

DELIMITER ;

SELECT contar_servicio_por_sede(1) AS total_servicio;
