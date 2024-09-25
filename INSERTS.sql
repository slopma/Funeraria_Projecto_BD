INSERT INTO gestion_funeraria.autopsiologo (nombre, apellido) VALUES
('Juan', 'Pérez'),
('María', 'Rodríguez'),
('Carlos', 'González'); 

INSERT INTO gestion_funeraria.funeraria (nombre, direccion) VALUES
('Poblado', 'Carrera 44 #18 56'),
('Laureles', 'Carrera 81 #37 100'),
('Belén', 'Calle 32f #63b 385');

INSERT INTO gestion_funeraria.cliente (nombre, apellido, fecha_fallecimiento, tipo_cliente, funeraria_id_funeraria) VALUES
('Ana', 'García', NULL, 'TITULAR', 1),
('Pedro', 'Martínez', NULL, 'TITULAR', 2),
('Laura', 'López', '2023-11-22', 'BENEFICIARIO', 3);
-- ... (agrega más registros aquí)

INSERT INTO gestion_funeraria.expediente_autopsia (es_autopsiado, conclusiones, fecha_autopsia, cliente_id_cliente, autopsiologo_id_autopsiologo) VALUES
('NO', NULL, NULL, 1, NULL),
('NO', NULL, NULL, 2, NULL),
('SI', 'Suicidio', '2023-11-23', 3, 3);
-- ... (agrega más registros aquí)

INSERT INTO gestion_funeraria.hueco (funeraria_id_funeraria, tipo_hueco, ocupado, ubicacion, medidas, cliente_id_cliente) VALUES
( 1, 'Tumba', 'NO', 'Sección A, Fila 1', '2.5x3 metros', 1),
( 2, 'Osario', 'NO', 'Sección B, Fila 2', '2.5x3 metros', 2),
( 3, 'Tumba', 'SI', 'Sección c, Fila 3', '2.5x3 metros', 3);
-- ... (agrega más registros aquí)

INSERT INTO gestion_funeraria.servicio_cementerio (tipo_servicio, tiempo_inicio, fecha_inicio, fin_inicio, cliente_id_cliente, funeraria_id_funeraria) VALUES
('Entierro', NULL, NULL, NULL, 1, 1),
('Cremación', NULL, NULL, NULL, 2, 2),
('Entierro', '2024-03-03 09:00:00', '2024-03-03', '2024-03-03 11:00:00', 3, 3);
-- ... (agrega más registros aquí)