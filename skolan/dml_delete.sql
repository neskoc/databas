--
-- Delete from database skolan.
-- By necu20 for course databas.
-- 2021-01-15
--

USE skolan;

--
-- Delete rows from table
--
-- Uppgift 1
DELETE FROM larare WHERE fornamn = 'Hagrid';
-- Uppgift 2
DELETE FROM larare WHERE lon IS NOT NULL LIMIT 2;
-- Uppgift 3
DELETE FROM larare WHERE avdelning = 'DIPT';
-- Uppgift 4
DELETE FROM larare LIMIT 2;
