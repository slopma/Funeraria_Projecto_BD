-- Selecciona la base de datos `gestion_funeraria` para trabajar con ella.
USE gestion_funeraria;

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
