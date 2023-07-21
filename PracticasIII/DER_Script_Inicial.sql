-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Personas` (
  `DNI` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Apellido` VARCHAR(45) NULL,
  `Fechanacimiento` DATETIME NULL,
  `Telefono` VARCHAR(25) NOT NULL,
  `Email` VARCHAR(45) NULL,
  `Domicilio` VARCHAR(45) NULL,
  PRIMARY KEY (`DNI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estado` (
  `Id_Estado` INT NOT NULL AUTO_INCREMENT,
  `Descripcion_Estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Estado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Plan` (
  `idPlan` INT NOT NULL AUTO_INCREMENT,
  `Carrera` VARCHAR(45) NOT NULL,
  `Estado_Id_Estado` INT NOT NULL,
  PRIMARY KEY (`idPlan`),
  INDEX `fk_Plan_Estado1_idx` (`Estado_Id_Estado` ASC) VISIBLE,
  CONSTRAINT `fk_Plan_Estado`
    FOREIGN KEY (`Estado_Id_Estado`)
    REFERENCES `mydb`.`Estado` (`Id_Estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rol` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `Id_Usuario` INT NOT NULL AUTO_INCREMENT,
  `Legajo` INT NOT NULL,
  `User` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NULL,
  `Libromatriz` INT NULL,
  `Id_Plan` INT NOT NULL,
  `Estado_Usuario` INT NOT NULL,
  `Rol_id_rol` INT NOT NULL,
  `Personas_DNI` INT NOT NULL,
  PRIMARY KEY (`Id_Usuario`, `Legajo`),
  INDEX `fk_plan` (`Id_Plan` ASC) VISIBLE,
  INDEX `fk_Usuario_Personas` (`Personas_DNI` ASC) VISIBLE,
  INDEX `fk_Usuario_Rol` (`Rol_id_rol` ASC) INVISIBLE,
  UNIQUE INDEX `legajo_UNIQUE` (`Legajo` ASC) INVISIBLE,
  INDEX `fk_Usuario_Estado_usuario1_idx` (`Estado_Usuario` ASC) VISIBLE,
  CONSTRAINT `fk_plan`
    FOREIGN KEY (`Id_Plan`)
    REFERENCES `mydb`.`Plan` (`idPlan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Estado_usuario1`
    FOREIGN KEY (`Estado_Usuario`)
    REFERENCES `mydb`.`Estado` (`Id_Estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Personas`
    FOREIGN KEY (`Personas_DNI`)
    REFERENCES `mydb`.`Personas` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Rol`
    FOREIGN KEY (`Rol_id_rol`)
    REFERENCES `mydb`.`Rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Materias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Materias` (
  `idMaterias` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NULL,
  `Estado` INT NULL,
  `Es_Promocional` TINYINT NOT NULL,
  PRIMARY KEY (`idMaterias`),
  INDEX `fk_Id_Estado_Materia_idx` (`Estado` ASC) INVISIBLE,
  CONSTRAINT `fk_Id_Estado_Materia`
    FOREIGN KEY (`Estado`)
    REFERENCES `mydb`.`Estado` (`Id_Estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Detalle_Plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Detalle_Plan` (
  `Id_Detalle_Plan` INT NOT NULL AUTO_INCREMENT,
  `Id_Materia` INT NULL,
  `Id_Plan` INT NOT NULL,
  PRIMARY KEY (`Id_Detalle_Plan`),
  INDEX `fk_detalleplanmateria` (`Id_Materia` ASC) VISIBLE,
  INDEX `fk_Detalle_Plan_Plan1_idx` (`Id_Plan` ASC) VISIBLE,
  CONSTRAINT `fk_Id_Materia`
    FOREIGN KEY (`Id_Materia`)
    REFERENCES `mydb`.`Materias` (`idMaterias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalle_Plan_Plan1`
    FOREIGN KEY (`Id_Plan`)
    REFERENCES `mydb`.`Plan` (`idPlan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DetalleCursada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DetalleCursada` (
  `idCursada` INT NOT NULL AUTO_INCREMENT,
  `idLegajo` INT NOT NULL,
  `idMateria` INT NOT NULL,
  `Primer_Parcial` INT NULL,
  `Recuperatio_Parcial_1` INT NULL,
  `Primer_TP` INT NULL,
  `Recuperatio_TP_1` INT NULL,
  `Segundo_Parcial` INT NULL,
  `Recuperatio_Parcial_2` INT NULL,
  `Segundo_TP` INT NULL,
  `Recuperatio_TP_2` INT NULL,
  `Promedio` INT NULL,
  `Id_Estado` INT NOT NULL,
  `Anio` INT NOT NULL,
  PRIMARY KEY (`idCursada`),
  INDEX `fk_detallecursadausuario_idx` (`idLegajo` ASC) VISIBLE,
  INDEX `fk_detallecursadamaterias_idx` (`idMateria` ASC) VISIBLE,
  CONSTRAINT `fk_detallecursadausuario`
    FOREIGN KEY (`idLegajo`)
    REFERENCES `mydb`.`Usuario` (`Legajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detallecursadamaterias`
    FOREIGN KEY (`idMateria`)
    REFERENCES `mydb`.`Materias` (`idMaterias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fechas_Finales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fechas_Finales` (
  `Id_Fecha_Final` INT NOT NULL AUTO_INCREMENT,
  `Id_Materia` INT NOT NULL,
  `Fecha` DATETIME NOT NULL,
  `Id_Estado` INT NOT NULL,
  PRIMARY KEY (`Id_Fecha_Final`),
  INDEX `fk_Fechas_Finales_Estado1_idx` (`Id_Estado` ASC) VISIBLE,
  CONSTRAINT `fk_Fechas_Finales_Estado1`
    FOREIGN KEY (`Id_Estado`)
    REFERENCES `mydb`.`Estado` (`Id_Estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Acta Volante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Acta Volante` (
  `Id_Acta_Volante` INT NOT NULL AUTO_INCREMENT,
  `Id_Materia_` INT NOT NULL,
  `Id_Fecha_Final` INT NOT NULL,
  `Fecha_Final` DATETIME NOT NULL,
  `Id_Usuario` INT NULL,
  `Folio` VARCHAR(20) NULL,
  `Nota` INT NULL DEFAULT 0,
  PRIMARY KEY (`Id_Acta_Volante`),
  INDEX `fk_Materias_has_Fechas_Finales_Fechas_Finales1_idx` (`Id_Fecha_Final` ASC) VISIBLE,
  INDEX `fk_Materias_has_Fechas_Finales_Materias1_idx` (`Id_Materia_` ASC) INVISIBLE,
  CONSTRAINT `fk_Id_Materia_Acta_Volante`
    FOREIGN KEY (`Id_Materia_`)
    REFERENCES `mydb`.`Materias` (`idMaterias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fecha`
    FOREIGN KEY (`Id_Fecha_Final`)
    REFERENCES `mydb`.`Fechas_Finales` (`Id_Fecha_Final`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
