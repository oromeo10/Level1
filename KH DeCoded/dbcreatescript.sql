-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Dcoded
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Dcoded
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Dcoded` DEFAULT CHARACTER SET utf8 ;
USE `Dcoded` ;

-- -----------------------------------------------------
-- Table `Dcoded`.`World`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`World` (
  `world_id` INT NOT NULL AUTO_INCREMENT,
  `world_name` VARCHAR(45) NOT NULL,
  `battle_lvl` INT NOT NULL,
  `world_award` VARCHAR(45) NULL,
  `User_notes` VARCHAR(999) NULL,
  PRIMARY KEY (`world_id`, `world_name`),
  UNIQUE INDEX `world_id_UNIQUE` (`world_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dcoded`.`Rtype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`Rtype` (
  `type_id` INT(3) NOT NULL,
  `type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`type_id`),
  UNIQUE INDEX `type_id_UNIQUE` (`type_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dcoded`.`Resource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`Resource` (
  `res_id` INT NOT NULL AUTO_INCREMENT,
  `res_name` VARCHAR(45) NOT NULL,
  `res_descr` VARCHAR(300) NULL,
  `res_type` INT(3) NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE INDEX `res_id_UNIQUE` (`res_id` ASC),
  INDEX `is_type_idx` (`res_type` ASC),
  CONSTRAINT `is_type`
    FOREIGN KEY (`res_type`)
    REFERENCES `Dcoded`.`Rtype` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dcoded`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`Menu` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `menu_name` VARCHAR(45) NOT NULL,
  `Equip_key` INT NOT NULL,
  `User_notes` VARCHAR(999) NULL,
  `world` INT NOT NULL,
  `sh_cross` INT NULL,
  `sh_circle` INT NULL,
  `sh_square` INT NULL,
  `sh_tri` INT NULL,
  UNIQUE INDEX `menu_id_UNIQUE` (`menu_id` ASC),
  PRIMARY KEY (`menu_id`, `menu_name`, `world`),
  INDEX `in_idx` (`world` ASC),
  INDEX `shcut_idx` (`sh_cross` ASC),
  INDEX `short_idx` (`sh_circle` ASC),
  INDEX `cut_idx` (`sh_square` ASC),
  INDEX `shortcut_idx` (`sh_tri` ASC),
  INDEX `key_idx` (`Equip_key` ASC),
  CONSTRAINT `in`
    FOREIGN KEY (`world`)
    REFERENCES `Dcoded`.`World` (`world_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `short`
    FOREIGN KEY (`sh_cross`)
    REFERENCES `Dcoded`.`Resource` (`res_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `short2`
    FOREIGN KEY (`sh_circle`)
    REFERENCES `Dcoded`.`Resource` (`res_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `short3`
    FOREIGN KEY (`sh_square`)
    REFERENCES `Dcoded`.`Resource` (`res_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `short4`
    FOREIGN KEY (`sh_tri`)
    REFERENCES `Dcoded`.`Resource` (`res_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `key`
    FOREIGN KEY (`Equip_key`)
    REFERENCES `Dcoded`.`Resource` (`res_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dcoded`.`Room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`Room` (
  `r_id` INT NOT NULL AUTO_INCREMENT,
  `r_name` VARCHAR(45) NOT NULL,
  `w_id` INT NOT NULL,
  UNIQUE INDEX `r_id_UNIQUE` (`r_id` ASC),
  PRIMARY KEY (`r_id`, `w_id`),
  INDEX `makeup_idx` (`w_id` ASC),
  CONSTRAINT `makeup`
    FOREIGN KEY (`w_id`)
    REFERENCES `Dcoded`.`World` (`world_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dcoded`.`Chest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`Chest` (
  `chest_id` INT NOT NULL AUTO_INCREMENT,
  `r_location` INT NOT NULL,
  `item` INT NOT NULL,
  PRIMARY KEY (`chest_id`),
  UNIQUE INDEX `chest_id_UNIQUE` (`chest_id` ASC),
  INDEX `within_idx` (`r_location` ASC),
  CONSTRAINT `within`
    FOREIGN KEY (`r_location`)
    REFERENCES `Dcoded`.`Room` (`r_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dcoded`.`battle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`battle` (
  `B_id` INT NOT NULL AUTO_INCREMENT,
  `Battle_name` VARCHAR(45) NOT NULL,
  `Award` INT NOT NULL,
  `User_notes` VARCHAR(999) NULL,
  PRIMARY KEY (`B_id`, `Award`),
  UNIQUE INDEX `B_id_UNIQUE` (`B_id` ASC),
  CONSTRAINT `awards`
    FOREIGN KEY (`B_id`)
    REFERENCES `Dcoded`.`Resource` (`res_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dcoded`.`Equip_ab`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`Equip_ab` (
  `cust_abid` INT NOT NULL AUTO_INCREMENT,
  `ab_id` INT NOT NULL,
  `menu_id` INT NOT NULL,
  PRIMARY KEY (`cust_abid`, `menu_id`),
  UNIQUE INDEX `cust_id_UNIQUE` (`cust_abid` ASC),
  INDEX `to_idx` (`menu_id` ASC),
  INDEX `eq2_idx` (`ab_id` ASC),
  CONSTRAINT `to`
    FOREIGN KEY (`menu_id`)
    REFERENCES `Dcoded`.`Menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `eq2`
    FOREIGN KEY (`ab_id`)
    REFERENCES `Dcoded`.`Resource` (`res_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dcoded`.`Equip_it`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`Equip_it` (
  `Equip_itid` INT NOT NULL AUTO_INCREMENT,
  `item_id` INT NOT NULL,
  `menu_id` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`Equip_itid`, `menu_id`),
  UNIQUE INDEX `Equip_itid_UNIQUE` (`Equip_itid` ASC),
  INDEX `equip_idx1` (`menu_id` ASC),
  INDEX `eq_idx` (`item_id` ASC),
  CONSTRAINT `for`
    FOREIGN KEY (`menu_id`)
    REFERENCES `Dcoded`.`Menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `eq`
    FOREIGN KEY (`item_id`)
    REFERENCES `Dcoded`.`Resource` (`res_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
