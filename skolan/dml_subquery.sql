--
-- file: dml_subquery.sql
-- Subquery, en fråga i fråga.
-- By necu20 for course databas.
-- 2021-02-07
--

USE skolan;

SELECT "Subquery, en fråga i fråga" AS '';

SELECT "Struktur på subquery." AS '';

SELECT (SELECT 'moped') AS 'Fordon';

SELECT
    akronym 
FROM larare
WHERE
    avdelning = 'DIDD'
;

SELECT
    *
FROM kurstillfalle
WHERE
    kursansvarig IN (
        SELECT
            akronym 
        FROM larare
        WHERE
            avdelning = 'DIDD'
    )
;

SELECT "Struktur på subquery." AS '';

(
    SELECT akronym, avdelning FROM larare WHERE avdelning = 'DIDD'
)
UNION
(
    SELECT akronym, avdelning FROM larare WHERE avdelning = 'DIPT'
)
;

SELECT "Uppgift subquery." AS '';

SELECT
    akronym,
    fornamn,
    efternamn,
    Ålder
FROM v_larare
    WHERE
        Ålder = ( SELECT MAX(Ålder) FROM v_larare )
;
