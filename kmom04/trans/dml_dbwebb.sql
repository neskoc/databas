--
-- file: dml_dbwebb.sql
-- Lägg data i tabeller.
-- By necu20 for course databas.
-- 2021-02-014
--

SET NAMES 'utf8';
USE dbwebb;

DELETE FROM account;
INSERT INTO account
VALUES
    ("1111", "Adam", 10.0),
    ("2222", "Eva", 7.0)
;

SELECT * FROM account;
