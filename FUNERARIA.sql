-- Desactiva temporalmente las verificaciones únicas (UNIQUE_CHECKS).
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;

-- Desactiva temporalmente las verificaciones de claves foráneas (FOREIGN_KEY_CHECKS).
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

-- Cambia temporalmente el modo SQL a uno más estricto para mejorar la calidad de los datos.
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Elimina el esquema (base de datos) llamado `gestion_funeraria` si existe.
DROP SCHEMA `gestion_funeraria`;

-- Este es un comentario que indica que se va a trabajar con un esquema (base de datos) llamado `mydb`.
-- -----------------------------------------------------
-- Indica que el siguiente bloque de código pertenece al esquema `gestion_funeraria`.
-- -----------------------------------------------------

-- Crea el esquema `gestion_funeraria` si no existe, con un conjunto de caracteres específico (utf8mb4).
CREATE SCHEMA IF NOT EXISTS `gestion_funeraria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- Selecciona el esquema `gestion_funeraria` para trabajar con él.
USE `gestion_funeraria`;

-- Comienza la creación de la tabla `autopsiologo` dentro del esquema `gestion_funeraria`.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`autopsiologo` (
  
  -- Define una columna `id_autopsiologo` que será un número entero, no nulo, y aumentará automáticamente con cada nuevo registro.
  `id_autopsiologo` INT NOT NULL AUTO_INCREMENT,
  
  -- Define una columna `nombre` que será texto con un máximo de 50 caracteres y no puede estar vacía (NOT NULL).
  `nombre` VARCHAR(50) NOT NULL,
  
  -- Define una columna `apellido`, similar a la columna `nombre`.
  `apellido` VARCHAR(50) NOT NULL,

  -- Establece la clave primaria (PRIMARY KEY) de la tabla como la columna `id_autopsiologo`.
  PRIMARY KEY (`id_autopsiologo`))
  
-- Define el motor de almacenamiento (InnoDB) que se usará para esta tabla.
ENGINE = InnoDB

-- Establece que el conteo automático de registros comience desde 1.
AUTO_INCREMENT = 1

-- Define el conjunto de caracteres y la colación (ordenación) para los textos en la tabla.
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- Comienza la creación de la tabla `funeraria`.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`funeraria` (
  
  -- Define una columna `id_funeraria`, similar a la columna `id_autopsiologo`.
  `id_funeraria` INT NOT NULL AUTO_INCREMENT,

  -- Define una columna `nombre` con un máximo de 100 caracteres, no nula.
  `nombre` VARCHAR(100) NOT NULL,

  -- Define una columna `direccion`, también con un máximo de 100 caracteres y no nula.
  `direccion` VARCHAR(100) NOT NULL,

  -- Establece la clave primaria de la tabla como `id_funeraria`.
  PRIMARY KEY (`id_funeraria`))
  
-- Usa el motor InnoDB y los mismos ajustes de caracteres y colación.
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- Comienza la creación de la tabla `cliente`.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`cliente` (
  
  -- Define una columna `id_cliente` similar a las otras columnas con AUTO_INCREMENT.
  `id_cliente` INT NOT NULL AUTO_INCREMENT,

  -- Define columnas `nombre` y `apellido` para el cliente, ambas de 50 caracteres y no nulas.
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,

  -- Define una columna opcional `fecha_fallecimiento`, donde se almacenará una fecha o se dejará vacía si no se tiene.
  `fecha_fallecimiento` DATE NULL DEFAULT NULL,

  -- Define una columna `tipo_cliente` que indica qué tipo de cliente es, con un máximo de 20 caracteres, no nula.
  `tipo_cliente` VARCHAR(20) NOT NULL,

  -- Define una columna `funeraria_id_funeraria` que se relacionará con la tabla `funeraria` para indicar a qué funeraria pertenece el cliente.
  `funeraria_id_funeraria` INT NOT NULL,

  -- Establece la clave primaria en la columna `id_cliente`.
  PRIMARY KEY (`id_cliente`),

  -- Crea un índice en la columna `funeraria_id_funeraria` para mejorar las consultas que usen esta columna.
  INDEX `fk_cliente_funeraria1_idx` (`funeraria_id_funeraria` ASC) VISIBLE,

  -- Define una restricción de clave foránea que conecta `funeraria_id_funeraria` con la columna `id_funeraria` de la tabla `funeraria`.
  CONSTRAINT `fk_cliente_funeraria1`
    FOREIGN KEY (`funeraria_id_funeraria`)
    REFERENCES `gestion_funeraria`.`funeraria` (`id_funeraria`))
  
-- Usa el motor InnoDB y los mismos ajustes de caracteres y colación.
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



-- Comienza la creación de la tabla `expediente_autopsia` dentro del esquema `gestion_funeraria`.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`expediente_autopsia` (

  -- Define una columna `id_expediente` que será un número entero, no nulo, y que se incrementa automáticamente con cada nuevo registro.
  `id_expediente` INT NOT NULL AUTO_INCREMENT,

  -- Define una columna `es_autopsiado` que guardará un valor de 2 caracteres, indicando si el cliente fue autopsiado (ej. "SI" o "NO").
  `es_autopsiado` CHAR(2) NOT NULL,

  -- Define una columna `conclusiones`, que almacenará un texto de hasta 500 caracteres sobre los resultados de la autopsia. Es opcional y puede quedar vacía.
  `conclusiones` VARCHAR(500) NULL DEFAULT NULL,

  -- Define una columna `fecha_autopsia`, que almacenará la fecha de la autopsia. Es opcional.
  `fecha_autopsia` DATE NULL DEFAULT NULL,

  -- Define una columna `cliente_id_cliente`, que será un número entero no nulo y que se usará para relacionar el expediente de autopsia con un cliente.
  `cliente_id_cliente` INT NOT NULL,

  -- Define una columna `autopsiologo_id_autopsiologo`, que es opcional y sirve para relacionar el expediente con un autopsiólogo.
  `autopsiologo_id_autopsiologo` INT NULL DEFAULT NULL,

  -- Establece la clave primaria como `id_expediente`.
  PRIMARY KEY (`id_expediente`),

  -- Crea un índice en la columna `cliente_id_cliente` para hacer más rápidas las consultas que involucren esta columna.
  INDEX `fk_expediente_autopsia_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,

  -- Crea un índice en la columna `autopsiologo_id_autopsiologo` para mejorar las consultas relacionadas con autopsiólogos.
  INDEX `fk_expediente_autopsia_autopsiologo1_idx` (`autopsiologo_id_autopsiologo` ASC) VISIBLE,

  -- Establece una clave foránea que relaciona la columna `autopsiologo_id_autopsiologo` con la columna `id_autopsiologo` en la tabla `autopsiologo`.
  CONSTRAINT `fk_expediente_autopsia_autopsiologo1`
    FOREIGN KEY (`autopsiologo_id_autopsiologo`)
    REFERENCES `gestion_funeraria`.`autopsiologo` (`id_autopsiologo`),

  -- Establece una clave foránea que relaciona `cliente_id_cliente` con la columna `id_cliente` en la tabla `cliente`.
  CONSTRAINT `fk_expediente_autopsia_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `gestion_funeraria`.`cliente` (`id_cliente`))
    
-- Usa el motor InnoDB, con las mismas configuraciones de caracteres y colación que las tablas anteriores.
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- Comienza la creación de la tabla `hueco`.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`hueco` (
  
  -- Define una columna `id_hueco` que será un número entero no nulo y que aumentará automáticamente.
  `id_hueco` INT NOT NULL AUTO_INCREMENT,

  -- Define una columna `funeraria_id_funeraria` para relacionar el hueco con una funeraria específica.
  `funeraria_id_funeraria` INT NOT NULL,

  -- Define una columna `tipo_hueco` que almacena el tipo de hueco, como nicho o fosa. Es opcional.
  `tipo_hueco` VARCHAR(20) NULL DEFAULT NULL,

  -- Define una columna `ocupado`, que indica si el hueco está ocupado o no, usando 2 caracteres (ej. "SI" o "NO").
  `ocupado` CHAR(2) NOT NULL,

  -- Define una columna `ubicacion` para almacenar la ubicación del hueco, opcionalmente con hasta 100 caracteres.
  `ubicacion` VARCHAR(100) NULL DEFAULT NULL,

  -- Define una columna `medidas` que almacena las dimensiones del hueco. Es opcional.
  `medidas` VARCHAR(50) NULL DEFAULT NULL,

  -- Define una columna `cliente_id_cliente` para relacionar el hueco con un cliente específico.
  `cliente_id_cliente` INT NOT NULL,

  -- Establece la clave primaria como `id_hueco`.
  PRIMARY KEY (`id_hueco`),

  -- Crea un índice único combinando las columnas `tipo_hueco` y `ubicacion`, para asegurar que no haya duplicados en esa combinación.
  UNIQUE INDEX `uq_hueco_tipo_ubicacion` (`tipo_hueco` ASC, `ubicacion` ASC) VISIBLE,

  -- Crea un índice en la columna `funeraria_id_funeraria` para mejorar las consultas relacionadas con funerarias.
  INDEX `fk_hueco_funeraria1_idx` (`funeraria_id_funeraria` ASC) VISIBLE,

  -- Crea un índice en la columna `cliente_id_cliente` para optimizar las consultas relacionadas con clientes.
  INDEX `fk_hueco_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,

  -- Establece una clave foránea que relaciona la columna `funeraria_id_funeraria` con la columna `id_funeraria` en la tabla `funeraria`.
  CONSTRAINT `fk_hueco_funeraria1`
    FOREIGN KEY (`funeraria_id_funeraria`)
    REFERENCES `gestion_funeraria`.`funeraria` (`id_funeraria`),

  -- Establece una clave foránea que relaciona la columna `cliente_id_cliente` con la columna `id_cliente` en la tabla `cliente`. 
  CONSTRAINT `fk_hueco_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `gestion_funeraria`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    
-- Usa el motor InnoDB y los mismos ajustes de caracteres y colación.
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- Comienza la creación de la tabla `servicio_cementerio`.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`servicio_cementerio` (

  -- Define una columna `id_servicio` que será un número entero no nulo con incremento automático.
  `id_servicio` INT NOT NULL AUTO_INCREMENT,

  -- Define una columna `tipo_servicio` para almacenar el tipo de servicio ofrecido por el cementerio, opcional y de hasta 50 caracteres.
  `tipo_servicio` VARCHAR(50) NULL DEFAULT NULL,

  -- Define una columna `tiempo_inicio`, que almacenará la fecha y hora de inicio del servicio. Es opcional.
  `tiempo_inicio` DATETIME NULL DEFAULT NULL,

  -- Define una columna `fecha_inicio` que almacena la fecha y hora de inicio del servicio. También es opcional.
  `fecha_inicio` DATETIME NULL DEFAULT NULL,

  -- Define una columna `fin_inicio` para almacenar la fecha y hora de finalización del servicio. Es opcional.
  `fin_inicio` DATETIME NULL DEFAULT NULL,

  -- Define una columna `cliente_id_cliente` para relacionar el servicio con un cliente específico.
  `cliente_id_cliente` INT NOT NULL,

  -- Define una columna `funeraria_id_funeraria` para relacionar el servicio con una funeraria específica.
  `funeraria_id_funeraria` INT NOT NULL,

  -- Establece la clave primaria como `id_servicio`.
  PRIMARY KEY (`id_servicio`),

  -- Crea un índice en la columna `cliente_id_cliente` para mejorar las consultas relacionadas con clientes.
  INDEX `fk_servicio_cementerio_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,

  -- Crea un índice en la columna `funeraria_id_funeraria` para mejorar las consultas relacionadas con funerarias.
  INDEX `fk_servicio_cementerio_funeraria1_idx` (`funeraria_id_funeraria` ASC) VISIBLE,

  -- Establece una clave foránea que relaciona la columna `cliente_id_cliente` con la columna `id_cliente` en la tabla `cliente`.
  CONSTRAINT `fk_servicio_cementerio_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `gestion_funeraria`.`cliente` (`id_cliente`),

  -- Establece una clave foránea que relaciona la columna `funeraria_id_funeraria` con la columna `id_funeraria` en la tabla `funeraria`.
  CONSTRAINT `fk_servicio_cementerio_funeraria1`
    FOREIGN KEY (`funeraria_id_funeraria`)
    REFERENCES `gestion_funeraria`.`funeraria` (`id_funeraria`))
    
-- Usa el motor InnoDB con las configuraciones de caracteres y colación ya establecidas.
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


