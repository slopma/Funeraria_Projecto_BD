-- Selecciona la base de datos `gestion_funeraria` para trabajar con ella.
USE gestion_funeraria;

-- Cambia el delimitador (símbolo que indica el final de una instrucción) temporalmente de ';' a '$$' 
-- para que el sistema sepa que el bloque completo de código pertenece a un procedimiento.
DELIMITER $$

-- Comienza la creación de un procedimiento almacenado llamado `insertar_cliente`.
-- Este procedimiento permitirá agregar nuevos registros en la tabla `cliente`.
CREATE PROCEDURE insertar_cliente (

    -- Define el primer parámetro de entrada llamado `p_nombre` que recibirá un texto de hasta 50 caracteres.
    IN p_nombre VARCHAR(50),

    -- Define el segundo parámetro de entrada llamado `p_apellido`, también un texto de hasta 50 caracteres.
    IN p_apellido VARCHAR(50),

    -- Define el tercer parámetro de entrada llamado `p_fecha_fallecimiento` que recibirá una fecha.
    IN p_fecha_fallecimiento DATE,

    -- Define el cuarto parámetro llamado `p_tipo_cliente`, que será un texto de hasta 20 caracteres.
    IN p_tipo_cliente VARCHAR(20),

    -- Define el quinto parámetro llamado `p_funeraria_id` que es un número entero 
    -- y se usará para asociar el cliente con una funeraria existente.
    IN p_funeraria_id INT
)

-- Comienza el bloque principal del procedimiento, que contiene las instrucciones a ejecutar.
BEGIN

    -- Inserta los valores proporcionados en la tabla `cliente` de la base de datos `gestion_funeraria`.
    -- Cada parámetro se asigna a su respectiva columna en la tabla.
    INSERT INTO gestion_funeraria.cliente (nombre, apellido, fecha_fallecimiento, tipo_cliente, funeraria_id_funeraria)
    
    -- Los valores insertados serán los parámetros que recibe el procedimiento: nombre, apellido, 
    -- fecha de fallecimiento, tipo de cliente, y el ID de la funeraria.
    VALUES (p_nombre, p_apellido, p_fecha_fallecimiento, p_tipo_cliente, p_funeraria_id);

-- Termina el bloque del procedimiento.
END $$

-- Vuelve a cambiar el delimitador a su valor original (;), ya que hemos terminado de definir el procedimiento.
DELIMITER ;

-- Llama (ejecuta) el procedimiento `insertar_cliente`, proporcionando valores específicos:
-- 'Nombre' (nombre del cliente), 'Apellido' (apellido del cliente), '2023-11-22' (fecha de fallecimiento), 
-- 'TITULAR' (tipo de cliente), y '1' (el ID de la funeraria).
CALL insertar_cliente('Nombre', 'Apellido', '2023-11-22', 'TITULAR', 1);
