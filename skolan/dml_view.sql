--
-- file: dml_view.sql
-- Vyer.
-- By necu20 for course databas.
-- 2021-01-30
--

USE skolan;

SELECT "Vy med Larare.* och Ålder" AS '';

SELECT "1. Skapa en vy “v_larare” som innehåller samtliga kolumner från tabellen Lärare inklusive en ny kolumn med lärarens ålder." AS '';
DROP VIEW IF EXISTS skolan.v_larare;
CREATE VIEW v_larare
AS
SELECT
    *,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS Ålder 
FROM larare;
SELECT * FROM v_larare;

SELECT "2. Gör en SELECT-sats mot vyn som beräknar medelåldern på respektive avdelning. Visa avdelningens namn och medelålder sorterad på medelåldern." AS '';
SELECT
    avdelning,
    ROUND(AVG(Ålder)) AS Snittålder
FROM v_larare
    GROUP BY avdelning
    ORDER BY Snittålder
;
