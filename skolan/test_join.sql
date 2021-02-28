SELECT "2. Spara rapporten som en vy v_lonerevision." AS '';
DROP VIEW IF EXISTS skolan.v_lonerevision;
CREATE VIEW v_lonerevision
AS
SELECT
    ny.akronym,
    ny.fornamn,
    ny.efternamn,
    gammal.lon AS pre,
    ny.lon AS nu,
    (ny.lon - gammal.lon) AS diff,
    ROUND(100 * (ny.lon - gammal.lon) / gammal.lon, 2) AS proc,
    IF (100 * (ny.lon - gammal.lon) / gammal.lon > 3, "ok", "nok") AS mini,
    gammal.kompetens AS prekomp,
    ny.kompetens AS nukomp,
    (ny.kompetens - gammal.kompetens) AS diffkomp
FROM larare AS ny
    JOIN larare_pre AS gammal
        USING (akronym)
;

SELECT
    akronym, fornamn, efternamn, pre, nu, diff, proc, mini
FROM v_lonerevision
    ORDER BY proc DESC
;