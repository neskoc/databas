--
-- file: dml_join.sql
-- Joina tabell.
-- By necu20 for course databas.
-- 2021-01-30
--

USE skolan;

SELECT "Rapport från lönerevisionen" AS '';

SELECT "Skapa rapporten som visar resultatet enligt nedan." AS '';
SELECT
    ny.akronym,
    ny.fornamn,
    ny.efternamn,
    gammal.lon AS pre,
    ny.lon AS nu,
    (ny.lon - gammal.lon) AS diff,
    ROUND(100 * (ny.lon - gammal.lon) / gammal.lon, 2) AS proc,
    IF (1.03 * ny.lon >= gammal.lon, "ok", "nok") AS mini,
    gammal.kompetens AS prekomp,
    ny.kompetens AS nukomp,
    (ny.kompetens - gammal.kompetens) AS diffkomp
FROM larare AS ny
    JOIN larare_pre AS gammal
        ON ny.akronym = gammal.akronym
ORDER BY akronym
;

SELECT "2. Spara rapporten som en vy v_lonerevision." AS '';
DROP VIEW IF EXISTS skolan.v_lonerevision;
CREATE VIEW v_lonerevision
AS
SELECT
    ny.fornamn,
    ny.efternamn,
    gammal.lon AS pre,
    ny.lon AS nu,
    (ny.lon - gammal.lon) AS diff,
    ROUND(100 * (ny.lon - gammal.lon) / gammal.lon, 2) AS proc,
    IF (1.03 * ny.lon >= gammal.lon, "ok", "nok") AS mini,
    gammal.kompetens AS prekomp,
    ny.kompetens AS nukomp,
    (ny.kompetens - gammal.kompetens) AS diffkomp,
    ny.akronym
FROM larare AS ny
    JOIN larare_pre AS gammal
        ON ny.akronym = gammal.akronym
ORDER BY akronym
;


SELECT
    akronym, fornamn, efternamn, pre, nu, diff, proc, mini
FROM v_lonerevision
    ORDER BY proc DESC
;

SELECT
    akronym, fornamn, efternamn, prekomp, nukomp, diffkomp
FROM v_lonerevision
    ORDER BY nukomp DESC, diffkomp DESC
;