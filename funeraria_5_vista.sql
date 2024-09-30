CREATE VIEW vista_servicios_funerarios AS
-- Crea una vista llamada 'vista_servicios_funerarios'
SELECT
    c.id_cliente, -- Selecciona el ID del cliente
    c.nombre AS nombre_cliente, -- Selecciona y renombra el campo 'nombre' del cliente como 'nombre_cliente'
    c.apellido AS apellido_cliente, -- Selecciona y renombra 'apellido' como 'apellido_cliente'
    c.tipo_cliente, -- Selecciona el tipo de cliente
    ea.fecha_fallecimiento, -- Selecciona la fecha de fallecimiento del expediente de autopsia
    sc.tipo_servicio, -- Selecciona el tipo de servicio del cementerio
    sc.fecha_inicio, -- Selecciona la fecha de inicio del servicio del cementerio
    sc.hora_inicio, -- Selecciona la hora de inicio del servicio
    sc.hora_fin, -- Selecciona la hora de fin del servicio
    DATE(DATE_ADD(sc.fecha_inicio, INTERVAL 2 HOUR)) AS fecha_fin -- Calcula la fecha de fin como dos horas después de la fecha de inicio
FROM
    gestion_funeraria.cliente c 
JOIN
    gestion_funeraria.expediente_autopsia ea ON c.id_cliente = ea.cliente_id_cliente
    -- Realiza un JOIN con la tabla 'expediente_autopsia' para obtener la fecha de fallecimiento, emparejando por el ID de cliente
LEFT JOIN
    gestion_funeraria.servicio_cementerio sc ON c.id_cliente = sc.cliente_id_cliente
    -- Realiza un LEFT JOIN con 'servicio_cementerio' para incluir servicios (si existen), incluso si no hay un servicio asociado para ese cliente
WHERE
    sc.fecha_inicio >= DATE_ADD(ea.fecha_fallecimiento, INTERVAL 3 DAY)
    -- Filtra para incluir servicios de cementerio que empiezan al menos 3 días después de la fecha de fallecimiento
    OR (sc.fecha_inicio >= DATE_ADD(ea.fecha_fallecimiento, INTERVAL 5 YEAR) AND sc.tipo_servicio = 'Osario')
ORDER BY
    c.id_cliente, sc.fecha_inicio;
    -- Ordena el resultado por el ID del cliente y luego por la fecha de inicio del servicio


CREATE VIEW vista_clientes_por_sede AS 
-- Crea una vista llamada 'vista_clientes_por_sede'
SELECT 
    c.id_cliente, -- Selecciona el ID del cliente
    c.nombre AS nombre_cliente, -- Renombra 'nombre' como 'nombre_cliente'
    c.apellido AS apellido_cliente, -- Renombra 'apellido' como 'apellido_cliente'
    c.tipo_cliente, -- Selecciona el tipo de cliente
    c.estado_cliente, -- Selecciona el estado del cliente 
    sf.sede AS nombre_sede  -- Selecciona y renombra 'sede' de la tabla 'sede_funeraria' como 'nombre_sede'
FROM 
    gestion_funeraria.cliente c 
JOIN 
    gestion_funeraria.sede_funeraria sf ON c.sede_funeraria_id_sede_funeraria = sf.id_sede_funeraria
    -- Realiza un JOIN con 'sede_funeraria' emparejando por el ID de sede, para asociar cada cliente con su sede
ORDER BY 
    sf.sede, c.apellido, c.nombre;
    -- Ordena el resultado por el nombre de la sede, luego por el apellido del cliente, y finalmente por su nombre

SELECT * FROM vista_clientes_por_sede;
-- Consulta que devuelve todos los registros de la vista 'vista_clientes_por_sede'

SELECT * FROM vista_servicios_funerarios;
-- Consulta que devuelve todos los registros de la vista 'vista_servicios_funerarios'

