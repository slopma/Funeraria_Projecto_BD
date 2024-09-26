-- Aquí encuentras:
-- 1. El trigger
-- 2. El procedimento almacenado
-- 3. La función
-- 4. La vista

-- Selecciona la base de datos `gestion_funeraria` para trabajar con ella.
USE gestion_funeraria;

-- ----------------------------
-- TRIGGER
-- -----------------------------
-- Cambia el delimitador temporalmente de ';' a '$$' para indicar que el bloque de código completo es parte de un trigger (disparador).
DELIMITER $$

-- Crea un trigger (disparador) llamado `after_cliente_insert`.
-- Este trigger se ejecutará automáticamente después de que se inserte un nuevo registro en la tabla `cliente`.
CREATE TRIGGER after_cliente_insert

-- Especifica que el trigger se activará después de que ocurra una inserción (AFTER INSERT) en la tabla `cliente`.
AFTER INSERT ON cliente

-- Este trigger se ejecutará para cada fila nueva que se inserte (FOR EACH ROW).
FOR EACH ROW

-- Comienza el bloque de código que se ejecutará cuando el trigger se active.
BEGIN

    -- Inserta un nuevo registro en la tabla `hueco` cada vez que se inserta un cliente.
    -- Se insertan valores en varias columnas de la tabla `hueco`. 
    -- '1' es el ID de la funeraria, y 'SI' indica que el hueco está ocupado.
    -- Los demás valores, como el tipo de hueco, la ubicación y las medidas, se dejan como NULL (sin valor).
    -- `NEW.id_cliente` se refiere al ID del cliente recién insertado y lo asigna a la columna `cliente_id_cliente` de la tabla `hueco`.
    INSERT INTO hueco(funeraria_id_funeraria, tipo_hueco, ocupado, ubicacion, medidas, cliente_id_cliente)
    VALUES (1, NULL, 'NO', NULL, NULL, NEW.id_cliente);

-- Finaliza el bloque de código del trigger.
END $$

-- Vuelve a cambiar el delimitador a su valor original ';' ya que hemos terminado de definir el trigger.
DELIMITER ;



-- ----------------------------
-- PROC_ALMACENADO
-- -----------------------------
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



-- ----------------------------
-- FUNCION
-- -----------------------------
-- Cambia temporalmente el delimitador de las instrucciones SQL de ';' a '$$' 
-- para que el sistema sepa que las instrucciones dentro del bloque pertenecen a una función.
DELIMITER $$

-- Crea una función llamada `calcular_tiempo_muerto`, que calculará el tiempo transcurrido
-- desde la fecha de fallecimiento de una persona. La función devuelve un texto de hasta 100 caracteres.
CREATE FUNCTION calcular_tiempo_muerto(fecha_fallecimiento DATE)
RETURNS VARCHAR(100)
-- Declara que el resultado de la función es "determinístico", es decir, siempre devuelve el mismo valor
-- para la misma entrada (fecha de fallecimiento).
DETERMINISTIC

-- Comienza el bloque principal de la función, que contiene las instrucciones a ejecutar.
BEGIN

    -- Declara una variable llamada `años` que se usará para almacenar los años transcurridos.
    DECLARE años INT;

    -- Declara una variable llamada `meses` que se usará para almacenar los meses transcurridos.
    DECLARE meses INT;

    -- Declara una variable llamada `días` que se usará para almacenar los días transcurridos.
    DECLARE días INT;

    -- Declara una variable llamada `resultado` que se usará para almacenar el resultado final
    -- del cálculo, que será un texto.
    DECLARE resultado VARCHAR(100);

    -- Calcula la diferencia en años entre la fecha actual (CURDATE()) y la fecha de fallecimiento proporcionada.
    SET años = YEAR(CURDATE()) - YEAR(fecha_fallecimiento);

    -- Calcula la diferencia en meses entre la fecha actual y la fecha de fallecimiento.
    SET meses = MONTH(CURDATE()) - MONTH(fecha_fallecimiento);

    -- Calcula la diferencia en días entre la fecha actual y la fecha de fallecimiento.
    SET días = DAY(CURDATE()) - DAY(fecha_fallecimiento);

    -- Si los días son negativos (es decir, si la fecha actual está antes en el mes que la fecha de fallecimiento),
    -- se ajustan los días sumando los días del último mes completo y restando un mes.
    IF días < 0 THEN
        -- Calcula los días restantes del mes anterior y ajusta los días.
        SET días = días + DAY(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL meses MONTH)));
        -- Resta un mes ya que los días se ajustaron.
        SET meses = meses - 1;
    END IF;

    -- Si los meses son negativos (es decir, si la fecha actual está antes en el año que la fecha de fallecimiento),
    -- se ajustan los meses sumando 12 (un año completo) y restando un año.
    IF meses < 0 THEN
        -- Ajusta los meses sumando 12.
        SET meses = meses + 12;
        -- Resta un año ya que los meses se ajustaron.
        SET años = años - 1;
    END IF;

    -- Si han pasado más de un año, se muestra el resultado en años.
    IF años > 0 THEN
        SET resultado = CONCAT(años, ' año(s)');

    -- Si han pasado más de un mes, pero menos de un año, se muestra el resultado en meses.
    ELSEIF meses > 0 THEN
        SET resultado = CONCAT(meses, ' mes(es)');

    -- Si han pasado menos de un mes, se muestra el resultado en días.
    ELSE
        SET resultado = CONCAT(días, ' día(s)');
    END IF;

    -- Devuelve el texto final con el tiempo transcurrido (en años, meses o días).
    RETURN resultado;
END $$

-- Vuelve a cambiar el delimitador a su valor original ';' ya que hemos terminado de definir la función.
DELIMITER ;



-- ----------------------------
-- VISTA
-- -----------------------------
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
