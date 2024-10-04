SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema zenith
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema zenith
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zenith` DEFAULT CHARACTER SET utf8 ;
USE `zenith` ;

-- -----------------------------------------------------
-- Table `zenith`.`School`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`School` (
  `idSchool` INT NOT NULL,
  `nameSchool` VARCHAR(45) NOT NULL,
  `adressSchool` VARCHAR(45) NOT NULL,
  `phoneSchool` VARCHAR(45) NOT NULL,
  `emailSchool` VARCHAR(45) NOT NULL,
  `typeSchool` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idSchool`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`User` (
  `idUser` INT NOT NULL,
  `nameUser` VARCHAR(15) NOT NULL,
  `surnamesUser` VARCHAR(45) NOT NULL,
  `emailUser` VARCHAR(45) NOT NULL,
  `passwordUser` VARCHAR(30) NOT NULL,
  `rolUser` VARCHAR(13) NOT NULL,
  `statusUser` BINARY NOT NULL,
  `dateUserCreated` TIMESTAMP NOT NULL,
  `lastLoginUser` TIMESTAMP NOT NULL,
  `idSchoolFK` INT NOT NULL,
  PRIMARY KEY (`idUser`),
  INDEX `idSchoolFK_idx` (`idSchoolFK` ASC),
  CONSTRAINT `idSchoolFK`
    FOREIGN KEY (`idSchoolFK`)
    REFERENCES `zenith`.`School` (`idSchool`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `zenith`.`Grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`Grade` (
  `idGrade` INT NOT NULL,
  `nameGrade` VARCHAR(45) NOT NULL,
  `idSchoolFK` INT NOT NULL,
  PRIMARY KEY (`idGrade`),
  INDEX `idSchoolGradeFK_idx` (`idSchoolFK` ASC),
  CONSTRAINT `idSchoolGradeFK`
    FOREIGN KEY (`idSchoolFK`)
    REFERENCES `zenith`.`School` (`idSchool`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`Teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`Teacher` (
  `idUser` INT NOT NULL,
  `degree` VARCHAR(45) NOT NULL,
  INDEX `fk_Teacher_User1_idx` (`idUser` ASC),
  PRIMARY KEY (`idUser`),
  CONSTRAINT `fk_Teacher_User1`
    FOREIGN KEY (`idUser`)
    REFERENCES `zenith`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`Classe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`Classe` (
  `idClasses` INT NOT NULL,
  `seccionClasse` VARCHAR(1) NOT NULL,
  `idGradeFK` INT NOT NULL,
  `Teacher_idUser` INT NOT NULL,
  PRIMARY KEY (`idClasses`),
  INDEX `idGradeFK_idx` (`idGradeFK` ASC),
  INDEX `fk_Classe_Teacher1_idx` (`Teacher_idUser` ASC),
  CONSTRAINT `idGradeFK`
    FOREIGN KEY (`idGradeFK`)
    REFERENCES `zenith`.`Grade` (`idGrade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Classe_Teacher1`
    FOREIGN KEY (`Teacher_idUser`)
    REFERENCES `zenith`.`Teacher` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`Student` (
  `idUser` INT NOT NULL,
  `dniStudent` VARCHAR(10) NULL,
  `phoneStudent` INT(10) NULL,
  `dateRegistrationStudent` DATE NOT NULL,
  `birthdayStudent` DATE NOT NULL,
  `adressStudent` VARCHAR(45) NOT NULL,
  `idClasseFK` INT NOT NULL,
  `socialNumber` VARCHAR(14) NOT NULL,
  INDEX `idClasseFK_idx` (`idClasseFK` ASC),
  INDEX `fk_Student_User1_idx` (`idUser` ASC),
  PRIMARY KEY (`idUser`),
  CONSTRAINT `idClasseFK`
    FOREIGN KEY (`idClasseFK`)
    REFERENCES `zenith`.`Classe` (`idClasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_User1`
    FOREIGN KEY (`idUser`)
    REFERENCES `zenith`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`Employee` (
  `idUser` INT NOT NULL,
  `position_employee` VARCHAR(45) NOT NULL,
  INDEX `fk_Employee_User1_idx` (`idUser` ASC),
  PRIMARY KEY (`idUser`),
  CONSTRAINT `fk_Employee_User1`
    FOREIGN KEY (`idUser`)
    REFERENCES `zenith`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`BankAccounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`BankAccounts` (
  `idBankAccounts` INT NOT NULL,
  `idUsersFK` INT NOT NULL,
  `accountHolder` VARCHAR(45) NOT NULL,
  `numAccount` INT NOT NULL,
  `bank` VARCHAR(45) NOT NULL,
  `typeAccount` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBankAccounts`),
  INDEX `idUserFK_idx` (`idUsersFK` ASC),
  CONSTRAINT `idUserFK`
    FOREIGN KEY (`idUsersFK`)
    REFERENCES `zenith`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`Payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`Payments` (
  `idPayments` INT NOT NULL,
  `idSchoolFK` INT NOT NULL,
  `idBankAccounts` INT NOT NULL,
  `datePayment` DATE NOT NULL,
  `amountPayment` INT NOT NULL,
  `conceptPayment` VARCHAR(45) NOT NULL,
  `statePayment` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idPayments`),
  INDEX `idSchoolPaymentsFK_idx` (`idSchoolFK` ASC),
  INDEX `idBankAccountFK_idx` (`idBankAccounts` ASC),
  CONSTRAINT `idSchoolPaymentsFK`
    FOREIGN KEY (`idSchoolFK`)
    REFERENCES `zenith`.`School` (`idSchool`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idBankAccountFK`
    FOREIGN KEY (`idBankAccounts`)
    REFERENCES `zenith`.`BankAccounts` (`idBankAccounts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`PaymentHistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`PaymentHistory` (
  `idPaymentHistory` INT NOT NULL,
  `idPaymentsFK` INT NOT NULL,
  `updateDate` DATE NOT NULL,
  `previousState` VARCHAR(45) NOT NULL,
  `currentState` VARCHAR(45) NOT NULL,
  `comments` VARCHAR(45) NOT NULL,
  `idSchoolFK` INT NOT NULL,
  PRIMARY KEY (`idPaymentHistory`),
  INDEX `idPaymentsFK_idx` (`idPaymentsFK` ASC),
  INDEX `idSchoolPaymentHistoryFK_idx` (`idSchoolFK` ASC),
  CONSTRAINT `idPaymentsFK`
    FOREIGN KEY (`idPaymentsFK`)
    REFERENCES `zenith`.`Payments` (`idPayments`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idSchoolPaymentHistoryFK`
    FOREIGN KEY (`idSchoolFK`)
    REFERENCES `zenith`.`School` (`idSchool`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`ContractHistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`ContractHistory` (
  `idContractHistory` INT NOT NULL,
  `salary` INT NOT NULL,
  `workingHours` INT(2) NOT NULL,
  `contractStatus` VARCHAR(15) NOT NULL,
  `comments` VARCHAR(45) NOT NULL,
  `endDate` DATE NOT NULL,
  `contractDate` DATE NOT NULL,
  `idSchoolFK` INT NOT NULL,
  `Employee_idUser` INT NOT NULL,
  `hoursWorked` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idContractHistory`),
  INDEX `idSchoolContractHistoryFK_idx` (`idSchoolFK` ASC),
  INDEX `fk_ContractHistory_Employee1_idx` (`Employee_idUser` ASC),
  CONSTRAINT `idSchoolFKContractHistory`
    FOREIGN KEY (`idSchoolFK`)
    REFERENCES `zenith`.`School` (`idSchool`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ContractHistory_Employee1`
    FOREIGN KEY (`Employee_idUser`)
    REFERENCES `zenith`.`Employee` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`Subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`Subject` (
  `idSubject` INT NOT NULL,
  `nameSubject` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `idSchoolFK` INT NOT NULL,
  PRIMARY KEY (`idSubject`),
  INDEX `idSchoolSubjectFK_idx` (`idSchoolFK` ASC),
  CONSTRAINT `idSchoolSubjectFK`
    FOREIGN KEY (`idSchoolFK`)
    REFERENCES `zenith`.`School` (`idSchool`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`Schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`Schedule` (
  `idSchedule` INT NOT NULL,
  `idClassesFK` INT NOT NULL,
  `weekday` VARCHAR(10) NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  PRIMARY KEY (`idSchedule`),
  INDEX `idClassesFK_idx` (`idClassesFK` ASC),
  CONSTRAINT `idClassesFK`
    FOREIGN KEY (`idClassesFK`)
    REFERENCES `zenith`.`Classe` (`idClasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`AssistanceStudent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`AssistanceStudent` (
  `idAssistanceStudent` INT NOT NULL,
  `dateAttendance` DATE NOT NULL,
  `status` VARCHAR(8) NOT NULL,
  `Student_idUser` INT NOT NULL,
  `Subject_idSubject` INT NOT NULL,
  PRIMARY KEY (`idAssistanceStudent`),
  INDEX `fk_AssistanceStudent_Student1_idx` (`Student_idUser` ASC),
  INDEX `fk_AssistanceStudent_Subject1_idx` (`Subject_idSubject` ASC),
  CONSTRAINT `fk_AssistanceStudent_Student1`
    FOREIGN KEY (`Student_idUser`)
    REFERENCES `zenith`.`Student` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AssistanceStudent_Subject1`
    FOREIGN KEY (`Subject_idSubject`)
    REFERENCES `zenith`.`Subject` (`idSubject`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`EvaluationsStudents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`EvaluationsStudents` (
  `idEvaluationsStudents` INT NOT NULL,
  `idSubjectsFK` INT NOT NULL,
  `noteEvaluation` DECIMAL NOT NULL,
  `comment` VARCHAR(45) NOT NULL,
  `evaluationDate` DATE NOT NULL,
  `typeEvaluation` VARCHAR(45) NOT NULL,
  `Student_idUser` INT NOT NULL,
  PRIMARY KEY (`idEvaluationsStudents`),
  INDEX `idSubjectsFK_idx` (`idSubjectsFK` ASC),
  INDEX `fk_EvaluationsStudents_Student1_idx` (`Student_idUser` ASC),
  CONSTRAINT `idSubjectsFK`
    FOREIGN KEY (`idSubjectsFK`)
    REFERENCES `zenith`.`Subject` (`idSubject`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EvaluationsStudents_Student1`
    FOREIGN KEY (`Student_idUser`)
    REFERENCES `zenith`.`Student` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`EventsSchool`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`EventsSchool` (
  `idEventsSchool` INT NOT NULL,
  `nameEvent` VARCHAR(45) NOT NULL,
  `eventDescription` VARCHAR(45) NOT NULL,
  `dateEvent` DATETIME NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `idSchoolFK` INT NOT NULL,
  PRIMARY KEY (`idEventsSchool`),
  INDEX `idSchoolEventsSchoolFK_idx` (`idSchoolFK` ASC),
  CONSTRAINT `idSchoolEventsSchoolFK`
    FOREIGN KEY (`idSchoolFK`)
    REFERENCES `zenith`.`School` (`idSchool`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`LegalGuardian`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`LegalGuardian` (
  `idLegalGuardian` INT NOT NULL,
  `studentRelationship` VARCHAR(45) NOT NULL,
  `adressLegal` VARCHAR(45) NOT NULL,
  `phoneLegal` INT NOT NULL,
  `dniLegal` VARCHAR(15) NOT NULL,
  `Student_idUser` INT NOT NULL,
  PRIMARY KEY (`idLegalGuardian`),
  INDEX `fk_LegalGuardian_Student1_idx` (`Student_idUser` ASC),
  CONSTRAINT `fk_LegalGuardian_Student1`
    FOREIGN KEY (`Student_idUser`)
    REFERENCES `zenith`.`Student` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`ClassAssignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`ClassAssignment` (
  `idClassAssignment` INT NOT NULL,
  `idClasseFK` INT NOT NULL,
  `idSubjectFK` INT NOT NULL,
  `timeClass` TIME NOT NULL,
  `Teacher_idUser` INT NOT NULL,
  PRIMARY KEY (`idClassAssignment`, `Teacher_idUser`),
  INDEX `idClasseClassAssignmenFK_idx` (`idClasseFK` ASC),
  INDEX `idSubjectClassAssignmenFK_idx` (`idSubjectFK` ASC),
  INDEX `fk_ClassAssignment_Teacher1_idx` (`Teacher_idUser` ASC),
  CONSTRAINT `idClasseClassAssignmenFK`
    FOREIGN KEY (`idClasseFK`)
    REFERENCES `zenith`.`Classe` (`idClasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idSubjectClassAssignmenFK`
    FOREIGN KEY (`idSubjectFK`)
    REFERENCES `zenith`.`Subject` (`idSubject`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ClassAssignment_Teacher1`
    FOREIGN KEY (`Teacher_idUser`)
    REFERENCES `zenith`.`Teacher` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`ExtraActivities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`ExtraActivities` (
  `idExtraActivities` INT NOT NULL,
  `nameActivity` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `weekday` VARCHAR(45) NOT NULL,
  `timeActivity` TIME NOT NULL,
  `idSchoolFK` INT NOT NULL,
  `Employee_idUser` INT NOT NULL,
  PRIMARY KEY (`idExtraActivities`),
  INDEX `idSchoolExtraActivitiesFK_idx` (`idSchoolFK` ASC),
  INDEX `fk_ExtraActivities_Employee1_idx` (`Employee_idUser` ASC),
  CONSTRAINT `idSchoolExtraActivitiesFK`
    FOREIGN KEY (`idSchoolFK`)
    REFERENCES `zenith`.`School` (`idSchool`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ExtraActivities_Employee1`
    FOREIGN KEY (`Employee_idUser`)
    REFERENCES `zenith`.`Employee` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`Scholarchip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`Scholarchip` (
  `idScholarchip` INT NOT NULL,
  `typeScholarchip` VARCHAR(45) NOT NULL,
  `amount` DECIMAL NULL,
  `description` VARCHAR(45) NULL,
  `idSchoolFK` INT NOT NULL,
  PRIMARY KEY (`idScholarchip`),
  INDEX `idSchoolScholarchipFK_idx` (`idSchoolFK` ASC),
  CONSTRAINT `idSchoolScholarchipFK`
    FOREIGN KEY (`idSchoolFK`)
    REFERENCES `zenith`.`School` (`idSchool`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`Subsidies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`Subsidies` (
  `idSubsidies` INT NOT NULL,
  `typeSubsidies` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSubsidies`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`ExtraActivities_has_Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`ExtraActivities_has_Student` (
  `ExtraActivities_idExtraActivities` INT NOT NULL,
  `Student_idUser` INT NOT NULL,
  PRIMARY KEY (`ExtraActivities_idExtraActivities`, `Student_idUser`),
  INDEX `fk_ExtraActivities_has_Student_Student1_idx` (`Student_idUser` ASC),
  INDEX `fk_ExtraActivities_has_Student_ExtraActivities1_idx` (`ExtraActivities_idExtraActivities` ASC),
  CONSTRAINT `fk_ExtraActivities_has_Student_ExtraActivities1`
    FOREIGN KEY (`ExtraActivities_idExtraActivities`)
    REFERENCES `zenith`.`ExtraActivities` (`idExtraActivities`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ExtraActivities_has_Student_Student1`
    FOREIGN KEY (`Student_idUser`)
    REFERENCES `zenith`.`Student` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`Student_has_Scholarchip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`Student_has_Scholarchip` (
  `Student_idUser` INT NOT NULL,
  `Scholarchip_idScholarchip` INT NOT NULL,
  `statusBeca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Student_idUser`, `Scholarchip_idScholarchip`),
  INDEX `fk_Student_has_Scholarchip_Scholarchip1_idx` (`Scholarchip_idScholarchip` ASC),
  INDEX `fk_Student_has_Scholarchip_Student1_idx` (`Student_idUser` ASC),
  CONSTRAINT `fk_Student_has_Scholarchip_Student1`
    FOREIGN KEY (`Student_idUser`)
    REFERENCES `zenith`.`Student` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_has_Scholarchip_Scholarchip1`
    FOREIGN KEY (`Scholarchip_idScholarchip`)
    REFERENCES `zenith`.`Scholarchip` (`idScholarchip`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`User_has_EventsSchool`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`User_has_EventsSchool` (
  `User_idUser` INT NOT NULL,
  `EventsSchool_idEventsSchool` INT NOT NULL,
  PRIMARY KEY (`User_idUser`, `EventsSchool_idEventsSchool`),
  INDEX `fk_User_has_EventsSchool_EventsSchool1_idx` (`EventsSchool_idEventsSchool` ASC),
  INDEX `fk_User_has_EventsSchool_User1_idx` (`User_idUser` ASC),
  CONSTRAINT `fk_User_has_EventsSchool_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `zenith`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_EventsSchool_EventsSchool1`
    FOREIGN KEY (`EventsSchool_idEventsSchool`)
    REFERENCES `zenith`.`EventsSchool` (`idEventsSchool`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`Subsidies_has_User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`Subsidies_has_User` (
  `Subsidies_idSubsidies` INT NOT NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`Subsidies_idSubsidies`, `User_idUser`),
  INDEX `fk_Subsidies_has_User_User1_idx` (`User_idUser` ASC),
  INDEX `fk_Subsidies_has_User_Subsidies1_idx` (`Subsidies_idSubsidies` ASC),
  CONSTRAINT `fk_Subsidies_has_User_Subsidies1`
    FOREIGN KEY (`Subsidies_idSubsidies`)
    REFERENCES `zenith`.`Subsidies` (`idSubsidies`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subsidies_has_User_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `zenith`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zenith`.`Messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zenith`.`Messages` (
  `idIssuerFK` INT NOT NULL,
  `idReceiverFK` INT NOT NULL,
  `content` VARCHAR(45) NOT NULL,
  `sendDate` VARCHAR(45) NOT NULL,
  `School_idSchool` INT NOT NULL,
  PRIMARY KEY (`idIssuerFK`, `idReceiverFK`, `School_idSchool`),
  INDEX `fk_User_has_User_User2_idx` (`idReceiverFK` ASC),
  INDEX `fk_User_has_User_User1_idx` (`idIssuerFK` ASC),
  INDEX `fk_Messages_School1_idx` (`School_idSchool` ASC),
  CONSTRAINT `fk_User_has_User_User1`
    FOREIGN KEY (`idIssuerFK`)
    REFERENCES `zenith`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_User_User2`
    FOREIGN KEY (`idReceiverFK`)
    REFERENCES `zenith`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Messages_School1`
    FOREIGN KEY (`School_idSchool`)
    REFERENCES `zenith`.`School` (`idSchool`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;