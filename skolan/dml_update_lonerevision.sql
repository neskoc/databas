--
-- Update_2 larare.
-- By necu20 for course databas.
-- 2021-01-15
--

USE skolan;

SELECT
    SUM(lon) AS "Lönesumma",
    SUM(kompetens) AS Kompetens
FROM larare;


-- Del 1

-- Uppgift 1
SELECT SUM(lon) AS 'Lönesumma', (0.064 * SUM(lon)) AS 'Pott för löneökning' FROM larare;


-- Del 2

-- Uppgift 1
UPDATE larare
    SET
        lon = 85000, kompetens = 7
    WHERE
        fornamn = "Albus";
-- Uppgift 2
UPDATE larare
    SET
        lon = lon + 4000
    WHERE
        fornamn = "Minerva";
-- Uppgift 3
UPDATE larare
    SET
        lon = lon + 2000, kompetens = 3
    WHERE
        fornamn = "Argus";
-- Uppgift 4
UPDATE larare
    SET
        lon = lon - 3000
    WHERE
        fornamn IN ("Gyllenroy", "Alastor");
-- Uppgift 5
UPDATE larare
    SET
        lon = lon * 1.02
    WHERE
        avdelning = "DIDD";
-- Uppgift 6
UPDATE larare
    SET
        lon = lon * 1.03
    WHERE
        kon = "K" AND
        lon < "40000";
-- Uppgift 7
UPDATE larare
    SET
        lon = lon + 5000, kompetens = kompetens + 1
    WHERE
        fornamn IN ("Minerva", "Hagrid") OR
        efternamn = "Snape";
-- Uppgift 8
UPDATE larare
    SET
        lon = lon * 1.022
    WHERE
        fornamn NOT IN ("Albus", "Minerva", "Hagrid") AND
        efternamn <> "Snape";


-- Del 3

-- Uppgift 1
SELECT
    SUM(lon) AS "Ny lönesumma"
FROM larare;
-- Uppgift 2
SELECT
    100 * (SUM(lon) / 305000 - 1) AS "Procentuell ökning"
FROM larare;
-- Uppgift 3
SELECT
    SUM(kompetens) AS Kompetens
FROM larare;

-- Uppgift 1, 2 och 3
SELECT
    SUM(lon) AS "Ny lönesumma",
    100 * (SUM(lon) / 305000 - 1) AS "Procentuell ökning",
    SUM(kompetens) AS "Ny total kompetens"
FROM larare;

SELECT akronym, avdelning, fornamn, kon, lon, kompetens
FROM larare
ORDER BY lon DESC;

SELECT
    SUM(lon) AS Lönesummaa,
    SUM(kompetens) AS Kompetens 
FROM larare;
