USE gestion_funeraria;
DELIMITER $$

CREATE PROCEDURE insertar_cliente (
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_fecha_fallecimiento DATE,
    IN p_tipo_cliente VARCHAR(20),
    IN p_funeraria_id INT
)
BEGIN
    INSERT INTO gestion_funeraria.cliente (nombre, apellido, fecha_fallecimiento, tipo_cliente, funeraria_id_funeraria)
    VALUES (p_nombre, p_apellido, p_fecha_fallecimiento, p_tipo_cliente, p_funeraria_id);
END $$

DELIMITER ;
