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
-- Table `Dcoded`.`Keyblade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`Keyblade` (
  `K_id` INT NOT NULL AUTO_INCREMENT,
  `K_name` VARCHAR(45) NOT NULL,
  `Kdescr` VARCHAR(300) NULL,
  PRIMARY KEY (`K_id`),
  UNIQUE INDEX `K_id_UNIQUE` (`K_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dcoded`.`Ability`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`Ability` (
  `Ab_id` INT NOT NULL AUTO_INCREMENT,
  `Ab_name` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(300) NULL,
  PRIMARY KEY (`Ab_id`, `Ab_name`),
  UNIQUE INDEX `Ab_id_UNIQUE` (`Ab_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dcoded`.`Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`Items` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `item_name` VARCHAR(30) NOT NULL,
  `item_descr` VARCHAR(300) NULL,
  PRIMARY KEY (`item_id`, `item_name`),
  UNIQUE INDEX `item_id_UNIQUE` (`item_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dcoded`.`Magic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`Magic` (
  `spell_id` INT NOT NULL AUTO_INCREMENT,
  `spell_name` VARCHAR(45) NOT NULL,
  `spell_descr` VARCHAR(300) NULL,
  PRIMARY KEY (`spell_id`, `spell_name`),
  UNIQUE INDEX `spell_id_UNIQUE` (`spell_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dcoded`.`World`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dcoded`.`World` (
  `world_id` INT NOT NULL AUTO_INCREMENT,
  `world_name` VARCHAR(45) NOT NULL,
  `battle_lvl` INT NOT NULL,
  `world_award` INT NULL,
  `User_notes` VARCHAR(999) NULL,
  PRIMARY KEY (`world_id`, `world_name`),
  UNIQUE INDEX `world_id_UNIQUE` (`world_id` ASC),
  INDEX `award_idx` (`world_award` ASC),
  CONSTRAINT `award`
    FOREIGN KEY (`world_award`)
    REFERENCES `Dcoded`.`Ability` (`Ab_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `award2`
    FOREIGN KEY (`world_award`)
    REFERENCES `Dcoded`.`Items` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `award3`
    FOREIGN KEY (`world_award`)
    REFERENCES `Dcoded`.`Keyblade` (`K_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `award4`
    FOREIGN KEY (`world_award`)
    REFERENCES `Dcoded`.`Magic` (`spell_id`)
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
  INDEX `equip_idx` (`Equip_key` ASC),
  INDEX `in_idx` (`world` ASC),
  INDEX `set_idx` (`sh_cross` ASC),
  INDEX `set2_idx` (`sh_circle` ASC),
  INDEX `set3_idx` (`sh_square` ASC),
  INDEX `set4_idx` (`sh_tri` ASC),
  CONSTRAINT `equip`
    FOREIGN KEY (`Equip_key`)
    REFERENCES `Dcoded`.`Keyblade` (`K_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `in`
    FOREIGN KEY (`world`)
    REFERENCES `Dcoded`.`World` (`world_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `set`
    FOREIGN KEY (`sh_cross`)
    REFERENCES `Dcoded`.`Magic` (`spell_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `set2`
    FOREIGN KEY (`sh_circle`)
    REFERENCES `Dcoded`.`Magic` (`spell_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `set3`
    FOREIGN KEY (`sh_square`)
    REFERENCES `Dcoded`.`Magic` (`spell_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `set4`
    FOREIGN KEY (`sh_tri`)
    REFERENCES `Dcoded`.`Magic` (`spell_id`)
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
  INDEX `inside_idx` (`item` ASC),
  INDEX `within_idx` (`r_location` ASC),
  CONSTRAINT `inside`
    FOREIGN KEY (`item`)
    REFERENCES `Dcoded`.`Items` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
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
  INDEX `awards_idx` (`Award` ASC),
  CONSTRAINT `awards`
    FOREIGN KEY (`Award`)
    REFERENCES `Dcoded`.`Ability` (`Ab_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `rewards`
    FOREIGN KEY (`Award`)
    REFERENCES `Dcoded`.`Keyblade` (`K_id`)
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
  INDEX `eq_idx` (`ab_id` ASC),
  INDEX `to_idx` (`menu_id` ASC),
  CONSTRAINT `eq`
    FOREIGN KEY (`ab_id`)
    REFERENCES `Dcoded`.`Ability` (`Ab_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `to`
    FOREIGN KEY (`menu_id`)
    REFERENCES `Dcoded`.`Menu` (`menu_id`)
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
  INDEX `equip_idx` (`item_id` ASC),
  INDEX `equip_idx1` (`menu_id` ASC),
  CONSTRAINT `stock`
    FOREIGN KEY (`item_id`)
    REFERENCES `Dcoded`.`Items` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `for`
    FOREIGN KEY (`menu_id`)
    REFERENCES `Dcoded`.`Menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
