INSERT INTO gestion_funeraria.cliente 
(id_cliente, sede_funeraria_id_sede_funeraria, estado_cliente, tipo_cliente, nombre, apellido, tipo_documento, numero_documento)
VALUES
(1, 1, 'Activo', 'TITULAR', 'Ana', 'García', 'CC', 1012345678),
(2, 2, 'Inactivo', 'BENEFICIARIO', 'Pedro', 'Martínez', 'CC', 1012345679),
(3, 3, 'Activo', 'BENEFICIARIO', 'Laura', 'López', 'CC', 1012345680),
(4, 1, 'Inactivo', 'TITULAR', 'Sofia', 'Hernandez', 'CC', 1012345681),
(5, 2, 'Activo', 'BENEFICIARIO', 'Luis', 'Sol', 'CC', 1012345682),
(6, 3, 'Inactivo', 'BENEFICIARIO', 'Sara', 'Hurtado', 'CC', 1012345683),
(7, 1, 'Activo', 'TITULAR', 'Claudia', 'Luna', 'CC', 1012345684),
(8, 2, 'Inactivo', 'BENEFICIARIO', 'Alberto', 'Pulgarin', 'CC', 1012345685),
(9, 3, 'Activo', 'BENEFICIARIO', 'Marta', 'Castrillon', 'CC', 1012345686),
(10, 1, 'Inactivo', 'TITULAR', 'Samuel', 'Jaramillo', 'CC', 1012345687),
(11, 2, 'Activo', 'TITULAR', 'María', 'González', 'CC', 1012345688),
(12, 3, 'Inactivo', 'BENEFICIARIO', 'Mateo', 'Mendoza', 'CC', 1012345689),
(13, 1, 'Activo', 'BENEFICIARIO', 'Valentina', 'Salazar', 'CC', 1012345690),
(14, 2, 'Inactivo', 'TITULAR', 'Diego', 'Rivera', 'CC', 1012345691),
(15, 3, 'Activo', 'BENEFICIARIO', 'Camila', 'Acosta', 'CC', 1012345692),
(16, 1, 'Inactivo', 'BENEFICIARIO', 'Lucas', 'Soto', 'CC', 1012345693),
(17, 2, 'Activo', 'TITULAR', 'Laura', 'Olivares', 'CC', 1012345694),
(18, 3, 'Inactivo', 'BENEFICIARIO', 'David', 'Peña', 'CC', 1012345695),
(19, 1, 'Activo', 'BENEFICIARIO', 'Daniel', 'Contreras', 'CC', 1012345696),
(20, 2, 'Inactivo', 'TITULAR', 'Nicolás', 'Ramos', 'CC', 1012345697),
(21, 3, 'Activo', 'TITULAR', 'Emiliano', 'Castro', 'CC', 1012345698),
(22, 1, 'Inactivo', 'BENEFICIARIO', 'Carla', 'Gómez', 'CC', 1012345699),
(23, 2, 'Activo', 'BENEFICIARIO', 'Martín', 'Ayala', 'CC', 1012345700),
(24, 3, 'Inactivo', 'TITULAR', 'Juan Pablo', 'Navarro', 'CC', 1012345701),
(25, 1, 'Activo', 'BENEFICIARIO', 'Dora', 'Montes', 'CC', 1012345702);


INSERT INTO gestion_funeraria.servicio_cementerio 
(id_servicio_cementerio, sede_funeraria_id_sede_funeraria, cliente_id_cliente, tipo_servicio, hora_inicio, fecha_inicio, fecha_fin, hora_fin)
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
(cliente_id_cliente, sede_funeraria_id_sede_funeraria, autopsiologo_id_autopsiologo, fecha_fallecimiento, es_autopsiado, fecha_autopsia, causa_muerte)
VALUES
(2, 2, 2, '2010-10-31', 'SI', '2010-11-01', 'Enfermedad Pulmonar Obstructiva Crónica'),
(4, 1, 1, '2020-02-14', 'SI', '2020-02-15', 'Meningitis'),
(6, 3, 3, '2021-05-26', 'SI', '2021-05-27', 'Feminicidio'),
(8, 2, 2, '2022-03-10', 'SI', '2022-03-11', 'Herida por arma blanca'),
(10, 1, 1, '2014-05-19', 'SI', '2014-05-20', 'Asfixia'),
(12, 3, 3, '2017-09-02', 'SI', '2017-09-03', 'Accidente de tránsito'),
(14, 2, 2, '2023-08-07', 'SI', '2023-08-08', 'Suicidio'),
(16, 1, 1, '2022-07-20', 'SI', '2022-07-21', 'Intoxicación por monóxido de carbono'),
(18, 3, 3, '2019-12-30', 'SI', '2019-12-31', 'Ahogamiento'),
(20, 2, 2, '2015-12-18', 'SI', '2015-12-19', 'Sepsis'),
(22, 1, 1, '2023-01-12', 'SI', '2023-01-13', 'Cáncer de Mama'),
(24, 3, 3, '2012-04-25', 'SI', '2012-04-26', 'Accidente Cerebrovascular');
