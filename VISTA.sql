CREATE VIEW vista_informacion_cliente AS
SELECT 
    c.nombre AS nombre_cliente,
    c.apellido AS apellido_cliente,
    c.fecha_fallecimiento,
    c.tipo_cliente,
    f.nombre AS nombre_funeraria,
    s.tipo_servicio,
    DATE(s.fecha_inicio) AS fecha_servicio 
FROM 
    cliente c
JOIN 
    funeraria f ON c.funeraria_id_funeraria = f.id_funeraria
JOIN 
    servicio_cementerio s ON c.id_cliente = s.cliente_id_cliente;


SELECT * FROM vista_informacion_cliente;
