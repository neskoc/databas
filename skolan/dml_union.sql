--
-- file: dml_union.sql
-- UNION och slå samman tabeller.
-- By necu20 for course databas.
-- 2021-01-30
--

USE skolan;

SELECT "Visa alla rader med UNION" AS '';
--
-- UNION
--
SELECT
    *,
    'after' AS origin FROM larare
UNION
SELECT
    *,
    'before' AS origin FROM larare_pre
ORDER BY akronym
;

-- -------------------------------

SELECT
    lon.origin,
    akronym,
    fornamn,
    efternamn,
    kon,
    kompetens,
    lon
FROM
(
    SELECT
        *,
        'after' AS origin FROM larare
    UNION
    SELECT
        *,
        'before' AS origin FROM larare_pre
    ORDER BY akronym
) AS lon
WHERE
    akronym IN ('ala', 'dum')
ORDER BY akronym, origin
;
