--
-- file: dml_join2.sql
-- Joina tabeller.
-- By necu20 for course databas.
-- 2021-02-07
--

USE skolan;

SELECT "Joina med WHERE" AS '';

SELECT "SELECT både kurs och kurstillfalle." AS '';

--
-- A crossjoin
--
SELECT * FROM kurs, kurstillfalle;
--
-- Join using WHERE, use alias AS to shorten the statement
--
SELECT *
FROM kurs AS k, kurstillfalle AS kt
WHERE k.kod = kt.kurskod;


SELECT "Joina med JOIN..ON" AS '';
--
-- Join using JOIN..ON
--
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod;

SELECT "Joina med JOIN..ON" AS '';

DROP VIEW IF EXISTS skolan.v_planering;
CREATE VIEW v_planering
AS
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
    JOIN larare AS l
        ON l.akronym = kt.kursansvarig;

SELECT * FROM v_planering;

SELECT "Rapporter" AS '';

SELECT "Lärares arbetsbelastning" AS '';

SELECT
    akronym AS Akronym,
    CONCAT(fornamn, " ", efternamn) AS Namn,
    COUNT(kod) AS Tillfallen
FROM v_planering
    GROUP BY akronym
    ORDER BY Tillfallen DESC, akronym
;

SELECT "Kursansvariges ålder" AS '';

DROP VIEW IF EXISTS skolan.v_tre_aldsta_larare;
CREATE VIEW v_tre_aldsta_larare
AS
SELECT
    akronym,
--  ROUND(DATEDIFF(CURDATE(), fodd) / 365) AS `Ålder`
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS `Ålder`
FROM v_planering AS vp
    GROUP BY Ålder
    ORDER BY fodd ASC
    LIMIT 3
;

SELECT
    CONCAT(vp.namn, " (", vp.kurskod, ")") AS Kursnamn,
    CONCAT(vp.fornamn, " ", vp.efternamn, " (", vp.akronym, ")") AS Larare,
    ROUND(DATEDIFF(CURDATE(), vp.fodd) / 365) AS `Ålder`
FROM v_planering AS vp
    JOIN v_tre_aldsta_larare AS tal
        ON vp.akronym = tal.akronym
ORDER BY vp.fodd ASC, Kursnamn
;