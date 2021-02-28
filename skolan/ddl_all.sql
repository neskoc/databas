--
-- file: ddl_all.sql
-- Joina tabell.
-- By necu20 for course databas.
-- 2021-02-07
--

SET NAMES 'utf8';

-- ALTER TABLE larare_pre CONVERT TO CHARSET utf8 COLLATE utf8_swedish_ci;

DROP TABLE IF EXISTS kurstillfalle;
DROP TABLE IF EXISTS kurs;

DROP TABLE IF EXISTS larare;
DROP TABLE IF EXISTS larare_pre;

--
-- Create table: larare
--
CREATE TABLE larare
(
    akronym CHAR(3),
    avdelning CHAR(4),
    fornamn VARCHAR(20),
    efternamn VARCHAR(20),
    kon CHAR(1),
    lon INT,
    fodd DATE,
    kompetens INT NOT NULL DEFAULT 1,

    PRIMARY KEY (akronym)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

--
-- Make copy of table larare
--
CREATE TABLE larare_pre LIKE larare;

CREATE TABLE kurs
(
    kod CHAR(6) PRIMARY KEY NOT NULL,
    namn VARCHAR(40),
    poang FLOAT,
    niva CHAR(3)
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

--
-- Create table: kurstillfalle
--
CREATE TABLE kurstillfalle
(
    id INT AUTO_INCREMENT NOT NULL,
    kurskod CHAR(6) NOT NULL,
    kursansvarig CHAR(3) NOT NULL,
    lasperiod INT NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (kurskod) REFERENCES kurs(kod),
    FOREIGN KEY (kursansvarig) REFERENCES larare(akronym)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

DROP VIEW IF EXISTS skolan.v_larare;
CREATE VIEW v_larare
AS
SELECT
    *,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS Ålder 
FROM larare;
SELECT * FROM v_larare;

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

DROP VIEW IF EXISTS skolan.v_planering;
CREATE VIEW v_planering
AS
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
    JOIN larare AS l
        ON l.akronym = kt.kursansvarig;

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