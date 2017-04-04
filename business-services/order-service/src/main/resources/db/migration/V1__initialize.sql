CREATE DATABASE IF NOT EXISTS `SCHEMA_ORDER`;
USE `SCHEMA_ORDER`;

DROP TABLE IF EXISTS `ORDER`;
CREATE TABLE `ORDER` (
  `ID`            CHAR(36)    NOT NULL,
  `USER_ID`       CHAR(36)    NOT NULL,
  `STATUS`        VARCHAR(20) NOT NULL,
  `TOTAL_AMOUNT`  DECIMAL(10, 0)       DEFAULT NULL,
  `REWARD_POINTS` DECIMAL(10, 0)       DEFAULT NULL,
  `CONSIGNEE`     VARCHAR(45)          DEFAULT NULL,
  `ADDRESS`       VARCHAR(100)         DEFAULT NULL,
  `PHONE_NUMBER`  VARCHAR(20)          DEFAULT NULL,
  `VERSION`       BIGINT(20)           DEFAULT NULL,
  `CREATED_TIME`  TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_TIME` TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ORDER_ID_UINDEX` (`ID`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS `ITEM`;
CREATE TABLE `ITEM` (
  `ID`         CHAR(36) NOT NULL,
  `PRODUCT_ID` CHAR(36) NOT NULL,
  `ORDER_ID`   CHAR(36) NOT NULL,
  `QUANTITY`   INT(10)  NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ITEM_ID_UINDEX` (`ID`),
  KEY `ITEM_ORDER_ID_FK` (`ORDER_ID`),
  CONSTRAINT `ITEM_ORDER_ID_FK` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDER` (`ID`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS `CANCEL_RESERVATION_EVENT`;
CREATE TABLE `CANCEL_RESERVATION_EVENT` (
  `ID`            CHAR(36)    NOT NULL,
  `ORIGIN_ID`     CHAR(36)             DEFAULT NULL,
  `ORDER_ID`      CHAR(36)    NOT NULL,
  `STATUS`        VARCHAR(20) NOT NULL,
  `CREATED_TIME`  TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_TIME` TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CANCEL_RESERVATION_EVENT_ID_UINDEX` (`ID`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS `ARRANGE_SHIPMENT_EVENT`;
CREATE TABLE `ARRANGE_SHIPMENT_EVENT` (
  `ID`            CHAR(36)    NOT NULL,
  `ORIGIN_ID`     CHAR(36)             DEFAULT NULL,
  `ORDER_ID`      CHAR(36)    NOT NULL,
  `CONSIGNEE`     VARCHAR(45)          DEFAULT NULL,
  `ADDRESS`       VARCHAR(100)         DEFAULT NULL,
  `PHONE_NUMBER`  VARCHAR(20)          DEFAULT NULL,
  `STATUS`        VARCHAR(20) NOT NULL,
  `CREATED_TIME`  TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_TIME` TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ARRANGE_SHIPMENT_EVENT_ID_UINDEX` (`ID`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS `WAITING_FOR_PAYMENT_EVENT`;
CREATE TABLE `WAITING_FOR_PAYMENT_EVENT` (
  `ID`            CHAR(36)       NOT NULL,
  `ORIGIN_ID`     CHAR(36)                DEFAULT NULL,
  `USER_ID`       CHAR(36)       NOT NULL,
  `ORDER_ID`      CHAR(36)       NOT NULL,
  `AMOUNT`        DECIMAL(10, 0) NOT NULL,
  `STATUS`        VARCHAR(20)    NOT NULL,
  `CREATED_TIME`  TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_TIME` TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `WAITING_FOR_PAYMENT_EVENT_ID_UINDEX` (`ID`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS `PAYMENT_SUCCEEDED_EVENT`;
CREATE TABLE `PAYMENT_SUCCEEDED_EVENT` (
  `ID`            CHAR(36)    NOT NULL,
  `ORIGIN_ID`     CHAR(36)             DEFAULT NULL,
  `ORDER_ID`      CHAR(36)    NOT NULL,
  `STATUS`        VARCHAR(20) NOT NULL,
  `CREATED_TIME`  TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MODIFIED_TIME` TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PAYMENT_SUCCEEDED_EVENT_ID_UINDEX` (`ID`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;