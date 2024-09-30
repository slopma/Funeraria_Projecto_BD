CREATE VIEW vista_servicios_funerarios AS
SELECT
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.apellido AS apellido_cliente,
    c.tipo_cliente,
    ea.fecha_fallecimiento,
    sc.tipo_servicio,
    sc.fecha_inicio,
    sc.hora_inicio,
    sc.hora_fin,
    DATE(DATE_ADD(sc.fecha_inicio, INTERVAL 2 HOUR)) AS fecha_fin -- Fecha fin, 2 horas después de la hora de inicio
FROM
    gestion_funeraria.cliente c
JOIN
    gestion_funeraria.expediente_autopsia ea ON c.id_cliente = ea.cliente_id_cliente
LEFT JOIN
    gestion_funeraria.servicio_cementerio sc ON c.id_cliente = sc.cliente_id_cliente
WHERE
    sc.fecha_inicio >= DATE_ADD(ea.fecha_fallecimiento, INTERVAL 3 DAY) -- Tumbas asignadas 3 días después de la fecha de fallecimiento
    OR (sc.fecha_inicio >= DATE_ADD(ea.fecha_fallecimiento, INTERVAL 5 YEAR) AND sc.tipo_servicio = 'Osario') -- Osarios después de 5 años
ORDER BY
    c.id_cliente, sc.fecha_inicio;



CREATE VIEW vista_clientes_por_sede AS 
SELECT 
    c.id_cliente, 
    c.nombre AS nombre_cliente, 
    c.apellido AS apellido_cliente, 
    c.tipo_cliente, 
    c.estado_cliente, 
    sf.sede AS nombre_sede  
FROM 
    gestion_funeraria.cliente c 
JOIN 
    gestion_funeraria.sede_funeraria sf ON c.sede_funeraria_id_sede_funeraria = sf.id_sede_funeraria 
ORDER BY 
    sf.sede, c.apellido, c.nombre;



SELECT * FROM vista_clientes_por_sede;

SELECT * FROM vista_servicios_funerarios;
