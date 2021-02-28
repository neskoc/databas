--
-- file: setup.sql
-- Skapa databas eshop.
-- By necu20 for course databas kmom04.
-- 2021-02-016
--

SET NAMES 'utf8';

CREATE DATABASE IF NOT EXISTS eshop;
USE eshop;

CREATE USER IF NOT EXISTS 'user'@'%'
    IDENTIFIED BY 'pass';

CREATE USER IF NOT EXISTS 'user'@'localhost'
    IDENTIFIED BY 'pass';

-- Grant the user all privilegies on the database.
GRANT ALL PRIVILEGES
    ON eshop.*
    TO 'user'@'%';

-- Grant the user all privilegies on the database.
GRANT ALL PRIVILEGES
    ON eshop.*
    TO 'user'@'localhost';

FLUSH PRIVILEGES;

-- Visa vad en användare kan göra mot vilken databas.
SHOW GRANTS FOR 'user'@'%';
SHOW GRANTS FOR 'user'@'localhost';
