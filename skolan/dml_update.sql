--
-- Update larare.
-- By necu20 for course databas.
-- 2021-01-15
--

USE skolan;

UPDATE larare
    SET
        lon = 30000
    WHERE
        akronym IN ('gyl', 'ala');

-- Test: 305000 | 8
SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;

SELECT akronym, avdelning, fornamn, kon, lon, kompetens
  FROM larare
 ORDER BY lon DESC;
