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
