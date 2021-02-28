--
-- file: ddl_dbwebb.sql
-- Skapa tabeller för dbwebb.
-- By necu20 for course databas.
-- 2021-02-014
--

SET NAMES 'utf8';
USE dbwebb;

DROP TABLE IF EXISTS account;
CREATE TABLE account
(
    `id` CHAR(4) PRIMARY KEY,
    `name` VARCHAR(8),
    `balance` DECIMAL(4, 2)
);
