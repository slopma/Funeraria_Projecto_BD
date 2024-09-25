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
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`autopsiologo` (
  `id_autopsiologo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_autopsiologo`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestion_funeraria`.`funeraria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`funeraria` (
  `id_funeraria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_funeraria`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestion_funeraria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `fecha_fallecimiento` DATE NULL DEFAULT NULL,
  `tipo_cliente` VARCHAR(20) NOT NULL,
  `funeraria_id_funeraria` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_cliente_funeraria1_idx` (`funeraria_id_funeraria` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_funeraria1`
    FOREIGN KEY (`funeraria_id_funeraria`)
    REFERENCES `gestion_funeraria`.`funeraria` (`id_funeraria`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestion_funeraria`.`expediente_autopsia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`expediente_autopsia` (
  `id_expediente` INT NOT NULL AUTO_INCREMENT,
  `es_autopsiado` CHAR(2) NOT NULL,
  `conclusiones` VARCHAR(500) NULL DEFAULT NULL,
  `fecha_autopsia` DATE NULL DEFAULT NULL,
  `cliente_id_cliente` INT NOT NULL,
  `autopsiologo_id_autopsiologo` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_expediente`),
  INDEX `fk_expediente_autopsia_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  INDEX `fk_expediente_autopsia_autopsiologo1_idx` (`autopsiologo_id_autopsiologo` ASC) VISIBLE,
  CONSTRAINT `fk_expediente_autopsia_autopsiologo1`
    FOREIGN KEY (`autopsiologo_id_autopsiologo`)
    REFERENCES `gestion_funeraria`.`autopsiologo` (`id_autopsiologo`),
  CONSTRAINT `fk_expediente_autopsia_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `gestion_funeraria`.`cliente` (`id_cliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestion_funeraria`.`hueco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`hueco` (
  `id_hueco` INT NOT NULL AUTO_INCREMENT,
  `funeraria_id_funeraria` INT NOT NULL,
  `tipo_hueco` VARCHAR(20) NULL DEFAULT NULL,
  `ocupado` CHAR(2) NOT NULL,
  `ubicacion` VARCHAR(100) NULL DEFAULT NULL,
  `medidas` VARCHAR(50) NULL DEFAULT NULL,
  `cliente_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_hueco`),
  UNIQUE INDEX `uq_hueco_tipo_ubicacion` (`tipo_hueco` ASC, `ubicacion` ASC) VISIBLE,
  INDEX `fk_hueco_funeraria1_idx` (`funeraria_id_funeraria` ASC) VISIBLE,
  INDEX `fk_hueco_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_hueco_funeraria1`
    FOREIGN KEY (`funeraria_id_funeraria`)
    REFERENCES `gestion_funeraria`.`funeraria` (`id_funeraria`),
  CONSTRAINT `fk_hueco_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `gestion_funeraria`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestion_funeraria`.`servicio_cementerio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestion_funeraria`.`servicio_cementerio` (
  `id_servicio` INT NOT NULL AUTO_INCREMENT,
  `tipo_servicio` VARCHAR(50) NULL DEFAULT NULL,
  `tiempo_inicio` DATETIME NULL DEFAULT NULL,
  `fecha_inicio` DATETIME NULL DEFAULT NULL,
  `fin_inicio` DATETIME NULL DEFAULT NULL,
  `cliente_id_cliente` INT NOT NULL,
  `funeraria_id_funeraria` INT NOT NULL,
  PRIMARY KEY (`id_servicio`),
  INDEX `fk_servicio_cementerio_cliente1_idx` (`cliente_id_cliente` ASC) VISIBLE,
  INDEX `fk_servicio_cementerio_funeraria1_idx` (`funeraria_id_funeraria` ASC) VISIBLE,
  CONSTRAINT `fk_servicio_cementerio_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `gestion_funeraria`.`cliente` (`id_cliente`),
  CONSTRAINT `fk_servicio_cementerio_funeraria1`
    FOREIGN KEY (`funeraria_id_funeraria`)
    REFERENCES `gestion_funeraria`.`funeraria` (`id_funeraria`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
