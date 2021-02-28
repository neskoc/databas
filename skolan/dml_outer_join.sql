--
-- file: dml_outer_join.sql
-- Outer join, rader som inte matchar.
-- By necu20 for course databas.
-- 2021-02-07
--

USE skolan;

SELECT "Lärare som inte undervisar" AS '';

SELECT DISTINCT
    akronym AS Akronym,
    CONCAT(fornamn, " ", efternamn) AS Namn
FROM v_planering
ORDER BY akronym
;

SELECT "Icke-matchande rader med OUTER JOIN" AS '';
--
-- Outer join, inkludera lärare utan undervisning
--
SELECT DISTINCT
    l.akronym AS Akronym,
    CONCAT(l.fornamn, " ", l.efternamn) AS Namn,
    l.avdelning AS Avdelning,
    kt.kurskod AS Kurskod
FROM larare AS l
    LEFT OUTER JOIN kurstillfalle AS kt
        ON l.akronym = kt.kursansvarig
;

SELECT DISTINCT
    l.akronym AS Akronym,
    CONCAT(l.fornamn, " ", l.efternamn) AS Namn,
    l.avdelning AS Avdelning,
    kt.kurskod AS Kurskod
FROM larare AS l
    RIGHT OUTER JOIN kurstillfalle AS kt
        ON l.akronym = kt.kursansvarig
;

SELECT "Kurser utan kurstillfällen" AS '';

SELECT DISTINCT
    k.kod AS Kurskod,
    k.namn AS Kursnamn,
    kt.lasperiod AS Läsperiod
FROM kurs AS k
    LEFT OUTER JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
HAVING Läsperiod IS NULL
;