--
-- Update table larare.
-- By necu20 for course databas.
-- 2021-01-15
--

USE skolan;

-- Add column to table
-- Uppgift 1
ALTER TABLE larare ADD COLUMN kompetens INT;
-- Uppgift 2
ALTER TABLE larare DROP COLUMN kompetens;
-- Uppgift 3
ALTER TABLE larare ADD COLUMN kompetens INT NOT NULL DEFAULT 1;

SHOW COLUMNS FROM larare;
