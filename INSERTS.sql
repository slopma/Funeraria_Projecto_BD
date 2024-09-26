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
('Laura', 'López', '2023-11-22', 'BENEFICIARIO', 3),
('Sofía', 'Flores', NULL, 'TITULAR', 2),
('Isabel', 'Mayorga', NULL, 'BENEFICIARIO', 2),
('Luis Angel', 'Nerio', NULL, 'TITULAR', 1),
('Carlos', 'Hernández', NULL, 'TITULAR', 3),
('María', 'Jiménez', '2023-06-15', 'BENEFICIARIO', 1),
('Andrés', 'Pérez', NULL, 'TITULAR', 1),
('Claudia', 'González', '2023-07-10', 'BENEFICIARIO', 2),
('Daniel', 'Ruiz', NULL, 'TITULAR', 3),
('Patricia', 'Rodríguez', NULL, 'TITULAR', 1),
('Fernando', 'Santos', '2022-12-02', 'BENEFICIARIO', 3),
('Marta', 'Ramírez', NULL, 'TITULAR', 2),
('José', 'Guzmán', NULL, 'TITULAR', 1),
('Gloria', 'Castillo', '2021-10-18', 'BENEFICIARIO', 2),
('Ricardo', 'Romero', NULL, 'TITULAR', 3),
('Susana', 'Mendoza', NULL, 'TITULAR', 2),
('Alejandro', 'Salinas', '2023-03-25', 'BENEFICIARIO', 1),
('Rosa', 'Vargas', NULL, 'TITULAR', 3),
('Miguel', 'Ortega', NULL, 'TITULAR', 1),
('Elena', 'Morales', '2022-11-05', 'BENEFICIARIO', 2),
('Jorge', 'Silva', NULL, 'TITULAR', 2),
('Verónica', 'Luna', NULL, 'TITULAR', 3),
('Raúl', 'Márquez', '2020-04-15', 'BENEFICIARIO', 1);
-- 

INSERT INTO gestion_funeraria.expediente_autopsia (es_autopsiado, conclusiones, fecha_autopsia, cliente_id_cliente, autopsiologo_id_autopsiologo) VALUES
('NO', NULL, NULL, 1, NULL),
('NO', NULL, NULL, 2, NULL),
('SI', 'Suicidio', '2023-11-23', 3, 3),
('NO', NULL, NULL, 4, NULL),
('SI', 'Accidente automovilístico', '2023-05-15', 5, 2),
('NO', NULL, NULL, 6, NULL),
('SI', 'Infarto', '2022-08-22', 7, 1),
('SI', 'Muerte natural', '2021-07-11', 8, 3),
('NO', NULL, NULL, 9, NULL),
('SI', 'Causa desconocida', '2023-09-09', 10, 1),
('NO', NULL, NULL, 11, NULL),
('SI', 'Ahorcamiento', '2022-10-25', 12, 2),
('SI', 'Drogas', '2022-11-12', 13, 3),
('NO', NULL, NULL, 14, NULL),
('NO', NULL, NULL, 15, NULL),
('SI', 'Ahogamiento', '2023-03-03', 16, 1),
('NO', NULL, NULL, 17, NULL),
('SI', 'Accidente de trabajo', '2023-06-17', 18, 2),
('SI', 'Fallecimiento repentino', '2023-04-04', 19, 1),
('NO', NULL, NULL, 20, NULL),
('SI', 'Asfixia', '2021-02-20', 21, 3),
('NO', NULL, NULL, 22, NULL),
('SI', 'Muerte súbita', '2022-09-15', 23, 2),
('NO', NULL, NULL, 24, NULL),
('SI', 'Herida por arma blanca', '2023-08-08', 25, 1);


INSERT INTO gestion_funeraria.hueco (funeraria_id_funeraria, tipo_hueco, ocupado, ubicacion, medidas, cliente_id_cliente) VALUES
(1, 'Tumba', 'NO', 'Sección A, Fila 1', '2.5x3 metros', 1),
(2, 'Osario', 'NO', 'Sección B, Fila 2', '2.5x3 metros', 2),
(3, 'Tumba', 'SI', 'Sección C, Fila 3', '2.5x3 metros', 3),
(1, 'Nicho', 'NO', 'Sección D, Fila 4', '1.5x2 metros', 4),
(2, 'Tumba', 'SI', 'Sección A, Fila 5', '2.5x3 metros', 5),
(3, 'Osario', 'NO', 'Sección B, Fila 6', '2.5x3 metros', 6),
(1, 'Nicho', 'SI', 'Sección C, Fila 7', '1.5x2 metros', 7),
(2, 'Tumba', 'SI', 'Sección D, Fila 8', '2.5x3 metros', 8),
(3, 'Osario', 'NO', 'Sección A, Fila 9', '2.5x3 metros', 9),
(1, 'Nicho', 'NO', 'Sección B, Fila 10', '1.5x2 metros', 10),
(2, 'Tumba', 'SI', 'Sección C, Fila 11', '2.5x3 metros', 11),
(3, 'Osario', 'NO', 'Sección D, Fila 12', '2.5x3 metros', 12),
(1, 'Tumba', 'SI', 'Sección A, Fila 13', '2.5x3 metros', 13),
(2, 'Nicho', 'NO', 'Sección B, Fila 14', '1.5x2 metros', 14),
(3, 'Tumba', 'SI', 'Sección C, Fila 15', '2.5x3 metros', 15),
(1, 'Osario', 'NO', 'Sección D, Fila 16', '2.5x3 metros', 16),
(2, 'Tumba', 'SI', 'Sección A, Fila 17', '2.5x3 metros', 17),
(3, 'Nicho', 'NO', 'Sección B, Fila 18', '1.5x2 metros', 18),
(1, 'Osario', 'SI', 'Sección C, Fila 19', '2.5x3 metros', 19),
(2, 'Tumba', 'NO', 'Sección D, Fila 20', '2.5x3 metros', 20),
(3, 'Nicho', 'SI', 'Sección A, Fila 21', '1.5x2 metros', 21),
(1, 'Osario', 'NO', 'Sección B, Fila 22', '2.5x3 metros', 22),
(2, 'Tumba', 'SI', 'Sección C, Fila 23', '2.5x3 metros', 23),
(3, 'Nicho', 'NO', 'Sección D, Fila 24', '1.5x2 metros', 24),
(1, 'Tumba', 'SI', 'Sección A, Fila 25', '2.5x3 metros', 25);


INSERT INTO gestion_funeraria.servicio_cementerio (tipo_servicio, tiempo_inicio, fecha_inicio, fin_inicio, cliente_id_cliente, funeraria_id_funeraria) VALUES
('Entierro', NULL, NULL, NULL, 1, 1),
('Cremación', NULL, NULL, NULL, 2, 2),
('Entierro', '2024-03-03 09:00:00', '2024-03-03', '2024-03-03 11:00:00', 3, 3),
('Cremación', '2024-01-15 10:00:00', '2024-01-15', '2024-01-15 12:00:00', 4, 1),
('Entierro', '2024-02-20 09:30:00', '2024-02-20', '2024-02-20 10:30:00', 5, 2),
('Entierro', NULL, NULL, NULL, 6, 3),
('Cremación', '2023-12-01 14:00:00', '2023-12-01', '2023-12-01 15:30:00', 7, 1),
('Entierro', NULL, NULL, NULL, 8, 2),
('Cremación', '2024-05-10 11:00:00', '2024-05-10', '2024-05-10 13:00:00', 9, 3),
('Entierro', '2024-04-25 10:30:00', '2024-04-25', '2024-04-25 12:00:00', 10, 1),
('Cremación', NULL, NULL, NULL, 11, 2),
('Entierro', NULL, NULL, NULL, 12, 3),
('Cremación', '2023-11-20 15:00:00', '2023-11-20', '2023-11-20 16:30:00', 13, 1),
('Entierro', '2023-10-05 09:00:00', '2023-10-05', '2023-10-05 11:00:00', 14, 2),
('Cremación', NULL, NULL, NULL, 15, 3),
('Entierro', '2023-09-15 14:30:00', '2023-09-15', '2023-09-15 16:00:00', 16, 1),
('Cremación', NULL, NULL, NULL, 17, 2),
('Entierro', NULL, NULL, NULL, 18, 3),
('Cremación', '2024-06-01 11:30:00', '2024-06-01', '2024-06-01 13:00:00', 19, 1),
('Entierro', '2023-08-30 10:00:00', '2023-08-30', '2023-08-30 12:00:00', 20, 2),
('Cremación', NULL, NULL, NULL, 21, 3),
('Entierro', NULL, NULL, NULL, 22, 1),
('Cremación', '2024-07-15 13:00:00', '2024-07-15', '2024-07-15 15:00:00', 23, 2),
('Entierro', '2023-09-10 09:00:00', '2023-09-10', '2023-09-10 10:30:00', 24, 3),
('Cremación', NULL, NULL, NULL, 25, 1);