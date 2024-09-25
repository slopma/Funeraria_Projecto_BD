DELIMITER $$

CREATE TRIGGER after_cliente_insert
AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
    -- Insertar una nueva orden cuando se inserta un cliente
    INSERT INTO hueco(funeraria_id_funeraria, tipo_hueco, ocupado, ubicacion, medidas, cliente_id_cliente)
    VALUES (1, NULL, 'SI', NULL, NULL, NEW.id_cliente);
END $$

DELIMITER ;
INSERT INTO gestion_funeraria.cliente (nombre, apellido, fecha_fallecimiento, tipo_cliente, funeraria_id_funeraria) VALUES
('Saol', 'Márquez', '2010-04-15', 'BENEFICIARIO', 1);