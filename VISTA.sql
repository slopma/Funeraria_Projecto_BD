-- Crea una vista llamada `vista_informacion_cliente`.
-- Una vista es como una tabla virtual que muestra datos de otras tablas sin tener que almacenarlos de nuevo.
CREATE VIEW vista_informacion_cliente AS

-- Selecciona las columnas que se mostrarán en la vista.
SELECT 

    -- Selecciona la columna `nombre` de la tabla `cliente` y la renombra como `nombre_cliente` en la vista.
    c.nombre AS nombre_cliente,

    -- Selecciona la columna `apellido` de la tabla `cliente` y la renombra como `apellido_cliente`.
    c.apellido AS apellido_cliente,

    -- Selecciona la columna `fecha_fallecimiento` de la tabla `cliente` tal como está.
    c.fecha_fallecimiento,

    -- Selecciona la columna `tipo_cliente` de la tabla `cliente` tal como está.
    c.tipo_cliente,

    -- Selecciona la columna `nombre` de la tabla `funeraria` y la renombra como `nombre_funeraria`.
    f.nombre AS nombre_funeraria,

    -- Selecciona la columna `tipo_servicio` de la tabla `servicio_cementerio` tal como está.
    s.tipo_servicio,

    -- Selecciona la columna `fecha_inicio` de la tabla `servicio_cementerio`, pero solo la parte de la fecha (sin hora),
    -- y la renombra como `fecha_servicio`.
    DATE(s.fecha_inicio) AS fecha_servicio 

-- Especifica las tablas de las que se obtendrán los datos para la vista. Comienza con la tabla `cliente`, que se renombra como `c`.
FROM 
    cliente c

-- Realiza una unión (JOIN) entre la tabla `cliente` y la tabla `funeraria`.
-- Se vinculan ambas tablas usando la columna `funeraria_id_funeraria` de `cliente`, que debe coincidir con la columna `id_funeraria` de `funeraria`.
JOIN 
    funeraria f ON c.funeraria_id_funeraria = f.id_funeraria

-- Realiza otra unión (JOIN) entre la tabla `cliente` y la tabla `servicio_cementerio`.
-- Esta vez se vinculan ambas tablas usando la columna `id_cliente` de `cliente`, que debe coincidir con la columna `cliente_id_cliente` de `servicio_cementerio`.
JOIN 
    servicio_cementerio s ON c.id_cliente = s.cliente_id_cliente;

-- Selecciona todos los registros (filas) de la vista `vista_informacion_cliente`.
-- Esto mostrará los datos que hemos seleccionado y unido desde las tablas `cliente`, `funeraria`, y `servicio_cementerio`.
SELECT * FROM vista_informacion_cliente;
