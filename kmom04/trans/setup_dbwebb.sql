--
-- file: setup_dbwebb.sql
-- Skapa databas dbwebb.
-- By necu20 for course databas.
-- 2021-02-014
--

SET NAMES 'utf8';

CREATE DATABASE IF NOT EXISTS dbwebb;
USE dbwebb;

CREATE USER IF NOT EXISTS 'user'@'%'
    IDENTIFIED BY 'pass';

CREATE USER IF NOT EXISTS 'user'@'localhost'
    IDENTIFIED BY 'pass';

-- Grant the user all privilegies on the database.
GRANT ALL PRIVILEGES
    ON dbwebb.*
    TO 'user'@'%';

-- Grant the user all privilegies on the database.
GRANT ALL PRIVILEGES
    ON dbwebb.*
    TO 'user'@'localhost';

FLUSH PRIVILEGES;

-- Visa vad en användare kan göra mot vilken databas.
SHOW GRANTS FOR 'user'@'%';
SHOW GRANTS FOR 'user'@'localhost';