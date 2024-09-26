-- Aquí encuentras:
-- 1. Consulta a funcion por tiempo que lleva muerto el usuario
-- 2. Creacion de usuario con el procedimeinto almacenado para activar el trigger
-- 3. la vista de las personas fallecidas

USE gestion_funeraria;



-- ---------------------------------------------
-- Consulta de Funcion 
-- -----------------------------------
SELECT 
    c.id_cliente,  -- Selecciona el identificador único del cliente
    c.nombre,  -- Selecciona la columna donde se guarda el nombre del cliente
    c.apellido, -- Selecciona la columna donde se guarda el apellido del cliente
    c.fecha_fallecimiento,  -- Selecciona la fecha en la que falleció el cliente
    f.nombre AS nombre_funeraria,  -- Selecciona el nombre de la funeraria asociada al cliente y lo nombra "nombre_funeraria"
    calcular_tiempo_muerto(c.fecha_fallecimiento) AS tiempo_muerto  -- Llama a una función que calcula cuánto tiempo ha pasado desde el fallecimiento, y lo nombra "tiempo_muerto"
FROM 
    cliente c  -- Especifica que los datos provienen de la tabla llamada "cliente"
JOIN 
    funeraria f ON c.funeraria_id_funeraria = f.id_funeraria  -- Relaciona la tabla "cliente" con la tabla "funeraria" usando el identificador de la funeraria
WHERE 
    c.id_cliente = 3;  -- Filtra para obtener solo el cliente con el identificador número 3
    
    
    
-- ---------------------------------------------
-- Consulta PROC_ALMACENADO
-- -----------------------------------
-- Llama (ejecuta) el procedimiento `insertar_cliente`, proporcionando valores específicos:
-- 'Nombre' (nombre del cliente), 'Apellido' (apellido del cliente), '2023-11-22' (fecha de fallecimiento), 
-- 'TITULAR' (tipo de cliente), y '1' (el ID de la funeraria).
CALL insertar_cliente('Nombre', 'Apellido', NULL, 'TITULAR', 1);



-- ---------------------------------------------
-- Consulta de vista
-- -----------------------------------
-- Selecciona todos los registros (filas) de la vista `vista_informacion_cliente`.
-- Esto mostrará los datos que hemos seleccionado y unido desde las tablas `cliente`, `funeraria`, y `servicio_cementerio`.
SELECT * FROM vista_informacion_cliente;


