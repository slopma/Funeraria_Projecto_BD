INSERT INTO gestion_funeraria.autopsiologo (nombre, apellido) VALUES
('Juan', 'Pérez'),
('María', 'Rodríguez'),
('Carlos', 'González'); 


INSERT INTO gestion_funeraria.funeraria (nombre, direccion) VALUES
('Poblado', 'Carrera 44 #18 56'),
('Laureles', 'Carrera 81 #37 100'),
('Belén', 'Calle 32f #63b 385');


INSERT INTO gestion_funeraria.cliente 
(id_cliente, funeraria_id_funeraria, estado_cliente, tipo_cliente, nombre, apellido, tipo_documento, numero_documento)
VALUES
(1, 1, 'VIVO', 'TITULAR', 'Ana', 'García', 'CC', 1012345678),
(2, 2, 'MUERTO', 'BENEFICIARIO', 'Pedro', 'Martínez', 'CC', 1012345679),
(3, 3, 'VIVO', 'BENEFICIARIO', 'Laura', 'López', 'CC', 1012345680),
(4, 1, 'MUERTO', 'TITULAR', 'Sofia', 'Hernandez', 'CC', 1012345681),
(5, 2, 'VIVO', 'BENEFICIARIO', 'Luis', 'Sol', 'CC', 1012345682),
(6, 3, 'MUERTO', 'BENEFICIARIO', 'Sara', 'Hurtado', 'CC', 1012345683),
(7, 1, 'VIVO', 'TITULAR', 'Claudia', 'Luna', 'CC', 1012345684),
(8, 2, 'MUERTO', 'BENEFICIARIO', 'Alberto', 'Pulgarin', 'CC', 1012345685),
(9, 3, 'VIVO', 'BENEFICIARIO', 'Marta', 'Castrillon', 'CC', 1012345686),
(10, 1, 'MUERTO', 'TITULAR', 'Samuel', 'Jaramillo', 'CC', 1012345687),
(11, 2, 'VIVO', 'TITULAR', 'María', 'González', 'CC', 1012345688),
(12, 3, 'MUERTO', 'BENEFICIARIO', 'Mateo', 'Mendoza', 'CC', 1012345689),
(13, 1, 'VIVO', 'BENEFICIARIO', 'Valentina', 'Salazar', 'CC', 1012345690),
(14, 2, 'MUERTO', 'TITULAR', 'Diego', 'Rivera', 'CC', 1012345691),
(15, 3, 'VIVO', 'BENEFICIARIO', 'Camila', 'Acosta', 'CC', 1012345692),
(16, 1, 'MUERTO', 'BENEFICIARIO', 'Lucas', 'Soto', 'CC', 1012345693),
(17, 2, 'VIVO', 'TITULAR', 'Laura', 'Olivares', 'CC', 1012345694),
(18, 3, 'MUERTO', 'BENEFICIARIO', 'David', 'Peña', 'CC', 1012345695),
(19, 1, 'VIVO', 'BENEFICIARIO', 'Daniel', 'Contreras', 'CC', 1012345696),
(20, 2, 'MUERTO', 'TITULAR', 'Nicolás', 'Ramos', 'CC', 1012345697),
(21, 3, 'VIVO', 'TITULAR', 'Emiliano', 'Castro', 'CC', 1012345698),
(22, 1, 'MUERTO', 'BENEFICIARIO', 'Carla', 'Gómez', 'CC', 1012345699),
(23, 2, 'VIVO', 'BENEFICIARIO', 'Martín', 'Ayala', 'CC', 1012345700),
(24, 3, 'MUERTO', 'TITULAR', 'Juan Pablo', 'Navarro', 'CC', 1012345701),
(25, 1, 'VIVO', 'BENEFICIARIO', 'Dora', 'Montes', 'CC', 1012345702);

INSERT INTO gestion_funeraria.hueco 
(id_hueco, cliente_id_cliente, sede_funeraria_id_funeraria, tipo_hueco, estado_hueco, ubicacion, medidas)
VALUES
(1, 1, 1, NULL, 'DISPONIBLE', 'Sección A, Fila 1', '2.5x3 metros'),
(2, 2, 2, 'TUMBA', 'OCUPADO', 'Sección A, Fila 2', '2.5x3 metros'),
(3, 3, 3, NULL, 'DISPONIBLE', 'Sección A, Fila 3', '2.5x3 metros'),
(4, 4, 1, 'OSARIO', 'OCUPADO', 'Sección B, Fila 4', '0.5x0.5 metros'),
(5, 5, 2, NULL, 'DISPONIBLE', 'Sección B, Fila 5', '2.5x3 metros'),
(6, 6, 3, 'TUMBA', 'OCUPADO', 'Sección B, Fila 6', '2.5x3 metros'),
(7, 7, 1, NULL, 'DISPONIBLE', 'Sección C, Fila 7', '2.5x3 metros'),
(8, 8, 2, 'OSARIO', 'OCUPADO', 'Sección C, Fila 8', '0.5x0.5 metros'),
(9, 9, 3, NULL, 'DISPONIBLE', 'Sección C, Fila 9', '2.5x3 metros'),
(10, 10, 1, 'TUMBA', 'OCUPADO', 'Sección D, Fila 10', '2.5x3 metros'),
(11, 11, 2, NULL, 'DISPONIBLE', 'Sección A, Fila 4', NULL),
(12, 12, 3, 'OSARIO', 'OCUPADO', 'Sección A, Fila 5', '0.5x0.5 metros'),
(13, 13, 1, NULL, 'DISPONIBLE', 'Sección A, Fila 6', NULL),
(14, 14, 2, 'TUMBA', 'OCUPADO', 'Sección B, Fila 7', '2.5x3 metros'),
(15, 15, 3, NULL, 'DISPONIBLE', 'Sección B, Fila 8', NULL),
(16, 16, 1, 'OSARIO', 'OCUPADO', 'Sección B, Fila 9', '0.5x0.5 metros'),
(17, 17, 2, NULL, 'DISPONIBLE', 'Sección C, Fila 10', NULL),
(18, 18, 3, 'TUMBA', 'OCUPADO', 'Sección C, Fila 11', '2.5x3 metros'),
(19, 19, 1, NULL, 'DISPONIBLE', 'Sección C, Fila 12', NULL),
(20, 20, 2, 'OSARIO', 'OCUPADO', 'Sección D, Fila 11', '0.5x0.5 metros'),
(21, 21, 3, NULL, 'DISPONIBLE', 'Sección A, Fila 7', NULL),
(22, 22, 1, 'TUMBA', 'OCUPADO', 'Sección A, Fila 8', '2.5x3 metros'),
(23, 23, 2, NULL, 'DISPONIBLE', 'Sección A, Fila 9', NULL),
(24, 24, 3, 'OSARIO', 'OCUPADO', 'Sección B, Fila 10', '0.5x0.5 metros'),
(25, 25, 1, NULL, 'DISPONIBLE', 'Sección A, Fila 4', NULL);


INSERT INTO gestion_funeraria.servicio_cementerio 
(id_servicio, funeraria_id_funeraria, cliente_id_cliente, tipo_servicio, hora_inicio, fecha_inicio, fecha_fin, hora_fin)
VALUES
(1, 2, 2, 'Entierro', '14:00:00', '2010-11-02', '2010-11-02', '17:00:00'),
(2, 1, 4, 'Cremación', '15:00:00', '2020-02-16', '2020-02-16', '18:00:00'),
(3, 3, 6, 'Entierro', '14:00:00', '2021-05-28', '2021-05-28', '17:00:00'),
(4, 2, 8, 'Cremación', '15:00:00', '2022-03-12', '2022-03-12', '18:00:00'),
(5, 1, 10, 'Entierro', '14:00:00', '2014-05-21', '2014-05-21', '17:00:00'),
(6, 3, 12, 'Cremación', '14:00:00', '2017-09-04', '2017-09-04', '17:00:00'),
(7, 2, 14, 'Entierro', '15:00:00', '2023-08-09', '2023-08-09', '18:00:00'),
(8, 1, 16, 'Cremación', '14:00:00', '2022-07-22', '2022-07-22', '17:00:00'),
(9, 3, 18, 'Entierro', '15:00:00', '2020-01-01', '2020-01-01', '18:00:00'),
(10, 2, 20, 'Cremación', '14:00:00', '2015-12-20', '2015-12-20', '17:00:00'),
(12, 3, 24, 'Cremación', '15:00:00', '2012-04-27', '2012-04-27', '18:00:00');


INSERT INTO gestion_funeraria.expediente_autopsia 
(cliente_id_cliente, sede_funeraria_id_funeraria, autopsiologo_id_autopsiologo, fecha_fallecimiento, es_autopsiado, fecha_autopsia, causa_muerte)
VALUES
(1, 1, 1, NULL, 'NO', NULL, NULL),
(2, 2, 2, '2010-10-31', 'SI', '2010-11-01', 'Enfermedad Pulmonar Obstructiva Crónica'),
(3, 3, 3, NULL, 'NO', NULL, NULL),
(4, 1, 1, '2020-02-14', 'SI', '2020-02-15', 'Meningitis'),
(5, 2, 2, NULL, 'NO', NULL, NULL),
(6, 3, 3, '2021-05-26', 'SI', '2021-05-27', 'Feminicidio'),
(7, 1, 1, NULL, 'NO', NULL, NULL),
(8, 2, 2, '2022-03-10', 'SI', '2022-03-11', 'Herida por arma blanca'),
(9, 3, 3, NULL, 'NO', NULL, NULL),
(10, 1, 1, '2014-05-19', 'SI', '2014-05-20', 'Asfixia'),
(11, 2, 2, NULL, 'NO', NULL, NULL),
(12, 3, 3, '2017-09-02', 'SI', '2017-09-03', 'Accidente de tránsito'),
(13, 1, 1, NULL, 'NO', NULL, NULL),
(14, 2, 2, '2023-08-07', 'SI', '2023-08-08', 'Suicidio'),
(15, 3, 3, NULL, 'NO', NULL, NULL),
(16, 1, 1, '2022-07-20', 'SI', '2022-07-21', 'Intoxicación por monóxido de carbono'),
(17, 2, 2, NULL, 'NO', NULL, NULL),
(18, 3, 3, '2019-12-30', 'SI', '2019-12-31', 'Ahogamiento'),
(19, 1, 1, NULL, 'NO', NULL, NULL),
(20, 2, 2, '2015-12-18', 'SI', '2015-12-19', 'Sepsis'),
(21, 3, 3, NULL, 'NO', NULL, NULL),
(22, 1, 1, '2023-01-12', 'SI', '2023-01-13', 'Cáncer de Mama'),
(23, 2, 2, NULL, 'NO', NULL, NULL),
(24, 3, 3, '2012-04-25', 'SI', '2012-04-26', 'Accidente Cerebrovascular'),
(25, 1, 1, NULL, 'NO', NULL, NULL);

