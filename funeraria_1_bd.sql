-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP SCHEMA `gestion_funeraria`;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema gestion_funeraria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema gestion_funeraria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gestion_funeraria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `gestion_funeraria` ;

-- -----------------------------------------------------
-- Table `gestion_funeraria`.`autopsiologo`
-- -----------------------------------------------------
-- Tabla maestra
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`autopsiologo` (
  `id_autopsiologo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_autopsiologo`),
  UNIQUE INDEX `nombre` (`nombre` ASC, `apellido` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestion_funeraria`.`sede_funeraria`
-- -----------------------------------------------------
-- Tabla maestra
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`sede_funeraria` (
  `id_sede_funeraria` INT NOT NULL AUTO_INCREMENT,
  `sede` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_sede_funeraria`),
  UNIQUE INDEX `sede` (`sede` ASC, `direccion` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestion_funeraria`.`cliente`
-- -----------------------------------------------------
-- Tabla maestra
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `sede_funeraria_id_sede_funeraria` INT NOT NULL,
  `estado_cliente` VARCHAR(10) NOT NULL CHECK (estado_cliente IN ('Activo', 'Inactivo')),
  `tipo_cliente` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `tipo_documento` VARCHAR(50) NOT NULL,
  `numero_documento` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `numero_documento` (`numero_documento` ASC, `tipo_documento` ASC) VISIBLE,
  INDEX `fk_cliente_sede_funeraria1_idx` (`sede_funeraria_id_sede_funeraria` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_sede_funeraria1`
    FOREIGN KEY (`sede_funeraria_id_sede_funeraria`)
    REFERENCES `gestion_funeraria`.`sede_funeraria` (`id_sede_funeraria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestion_funeraria`.`expediente_autopsia`
-- -----------------------------------------------------
-- Tabla transaccional
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`expediente_autopsia` (
  `id_expediente_autopsia` INT NOT NULL AUTO_INCREMENT,
  `cliente_id_cliente` INT NOT NULL,
  `autopsiologo_id_autopsiologo` INT NOT NULL,
  `sede_funeraria_id_sede_funeraria` INT NOT NULL,
  `fecha_fallecimiento` DATE NOT NULL,
  `es_autopsiado` CHAR(2) NOT NULL CHECK (es_autopsiado IN ('Si', 'No')),
  `fecha_autopsia` DATE NULL DEFAULT NULL,
  `causa_muerte` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`id_expediente_autopsia`),
  INDEX `fk_expediente_autopsia_autopsiologo1_idx` (`autopsiologo_id_autopsiologo` ASC) VISIBLE,
  INDEX `fk_expediente_autopsia_sede_funeraria1_idx` (`sede_funeraria_id_sede_funeraria` ASC) VISIBLE,
  INDEX `fk_expediente_autopsia_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_expediente_autopsia_autopsiologo1`
    FOREIGN KEY (`autopsiologo_id_autopsiologo`)
    REFERENCES `gestion_funeraria`.`autopsiologo` (`id_autopsiologo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_expediente_autopsia_sede_funeraria1`
    FOREIGN KEY (`sede_funeraria_id_sede_funeraria`)
    REFERENCES `gestion_funeraria`.`sede_funeraria` (`id_sede_funeraria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_expediente_autopsia_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `gestion_funeraria`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    
    CONSTRAINT `chk_fecha_autopsia`
    CHECK (
        (es_autopsiado = 'SI' AND fecha_autopsia IS NOT NULL) OR
        (es_autopsiado != 'SI')
    )

    
    )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestion_funeraria`.`hueco`
-- -----------------------------------------------------
-- Tabla transaccional
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`hueco` (
  `id_hueco` INT NOT NULL AUTO_INCREMENT,
  `sede_funeraria_id_sede_funeraria` INT NOT NULL,
  `cliente_id_cliente` INT NULL,
  `tipo_hueco` VARCHAR(20) NOT NULL CHECK (tipo_hueco IN ('Tumba', 'Osario')),
  `estado_hueco` CHAR(30) NOT NULL CHECK (estado_hueco IN ('Disponible', 'Ocupado')),
  `ubicacion` VARCHAR(100) NOT NULL,
  `medida` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_hueco`),
  UNIQUE INDEX `uq_hueco_tipo_ubicacion` (`tipo_hueco` ASC, `ubicacion` ASC) VISIBLE,
  INDEX `fk_hueco_sede_funeraria1_idx` (`sede_funeraria_id_sede_funeraria` ASC) VISIBLE,
  INDEX `fk_hueco_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_hueco_sede_funeraria1`
    FOREIGN KEY (`sede_funeraria_id_sede_funeraria`)
    REFERENCES `gestion_funeraria`.`sede_funeraria` (`id_sede_funeraria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hueco_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `gestion_funeraria`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestion_funeraria`.`log_hueco`
-- -----------------------------------------------------
-- Tabla transaccional
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`log_hueco` (
  `id_log_hueco` INT NOT NULL AUTO_INCREMENT,
  `hueco_id` INT NULL DEFAULT NULL,
  `cliente_id` INT NULL DEFAULT NULL,
  `funeraria_id` INT NULL DEFAULT NULL,
  `antiguo_estado` VARCHAR(20) NULL DEFAULT NULL,
  `nuevo_estado` VARCHAR(20) NULL DEFAULT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_log_hueco`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestion_funeraria`.`servicio_cementerio`
-- -----------------------------------------------------
-- Tabla transaccional
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`servicio_cementerio` (
  `id_servicio_cementerio` INT NOT NULL AUTO_INCREMENT,
  `cliente_id_cliente` INT NOT NULL,
  `sede_funeraria_id_sede_funeraria` INT NOT NULL,
  `tipo_servicio` VARCHAR(50) NULL DEFAULT NULL,
  `hora_inicio` TIME NULL DEFAULT NULL,
  `fecha_inicio` DATE NULL DEFAULT NULL,
  `fecha_fin` DATE NULL DEFAULT NULL,
  `hora_fin` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_servicio_cementerio`),
  INDEX `fk_servicio_cementerio_sede_funeraria1_idx` (`sede_funeraria_id_sede_funeraria` ASC) VISIBLE,
  INDEX `fk_servicio_cementerio_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_servicio_cementerio_sede_funeraria1`
    FOREIGN KEY (`sede_funeraria_id_sede_funeraria`)
    REFERENCES `gestion_funeraria`.`sede_funeraria` (`id_sede_funeraria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicio_cementerio_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `gestion_funeraria`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

INSERT INTO gestion_funeraria.autopsiologo (nombre, apellido) VALUES
('Juan', 'Pérez'),
('María', 'Rodríguez'),
('Carlos', 'González'); 


INSERT INTO gestion_funeraria.sede_funeraria (sede, direccion) VALUES
('Poblado', 'Carrera 44 #18 56'),
('Laureles', 'Carrera 81 #37 100'),
('Belén', 'Calle 32f #63b 385');


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
