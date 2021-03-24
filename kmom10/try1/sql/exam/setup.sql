--
-- file: setup.sql
-- Skapa databas exam.
-- By necu20 for course databas kmom04.
-- 2021-03-24
--

SET NAMES 'utf8';

CREATE DATABASE IF NOT EXISTS exam;
USE exam;

CREATE USER IF NOT EXISTS 'user'@'%'
    IDENTIFIED BY 'pass';

CREATE USER IF NOT EXISTS 'user'@'localhost'
    IDENTIFIED BY 'pass';

-- Grant the user all privilegies on the database.
GRANT ALL PRIVILEGES
    ON exam.*
    TO 'user'@'%';

-- Grant the user all privilegies on the database.
GRANT ALL PRIVILEGES
    ON exam.*
    TO 'user'@'localhost';

FLUSH PRIVILEGES;

-- Visa vad en användare kan göra mot vilken databas.
SHOW GRANTS FOR 'user'@'%';
SHOW GRANTS FOR 'user'@'localhost';
