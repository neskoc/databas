--
-- file: dml_dbwebb.sql
-- Lägg data i tabeller.
-- By necu20 for course databas.
-- 2021-02-014
--

SET NAMES 'utf8';
USE dbwebb;

--
-- Move the money, within a transaction
--
START TRANSACTION;

UPDATE account
SET
    balance = balance + 1.5
WHERE
    id = "2222";

UPDATE account
SET
    balance = balance - 1.5
WHERE
    id = "1111";

COMMIT;

SELECT * FROM account;
