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
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `user_id` BIGINT NOT NULL,
  `coins` INT NULL DEFAULT 0,
  `exp` INT NULL DEFAULT 0,
  `lvl` INT NULL DEFAULT 0,
  `server_name` VARCHAR(256) NULL,
  `user_name` VARCHAR(256) NOT NULL,
  `questions` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`questions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`questions` (
  `question_id` INT NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(256) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL,
  PRIMARY KEY (`question_id`),
  FULLTEXT INDEX `text` (`text`) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`answers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`answers` (
  `answer_id` INT NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(256) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL,
  PRIMARY KEY (`answer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`conn_quest_ans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`conn_quest_ans` (
  `question_id` INT NOT NULL,
  `answer_id` INT NOT NULL,
  `user_id` BIGINT NULL,
  `type` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`question_id`, `answer_id`),
  INDEX `fk_conn_quest_ans_answers1_idx` (`answer_id` ASC) VISIBLE,
  INDEX `fk_conn_quest_ans_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_conn_quest_ans_questions`
    FOREIGN KEY (`question_id`)
    REFERENCES `mydb`.`questions` (`question_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conn_quest_ans_answers1`
    FOREIGN KEY (`answer_id`)
    REFERENCES `mydb`.`answers` (`answer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conn_quest_ans_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`blackjack`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`blackjack` (
  `user_id` BIGINT NOT NULL,
  `state` JSON NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_blackjack_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
