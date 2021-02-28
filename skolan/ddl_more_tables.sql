--
-- file: dml_join.sql
-- Joina tabell.
-- By necu20 for course databas.
-- 2021-01-30
--

USE skolan;
SET NAMES 'utf8';

--
-- Update table larare and larare_pre to use same charset
-- and collation.
--
ALTER TABLE larare CONVERT TO CHARSET utf8 COLLATE utf8_swedish_ci;
ALTER TABLE larare_pre CONVERT TO CHARSET utf8 COLLATE utf8_swedish_ci;

DROP TABLE IF EXISTS kurstillfalle;
DROP TABLE IF EXISTS kurs;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;

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

--
-- Ange vilket sätt som tabeller skall lagras på + teckenkodning
--
CREATE TABLE t1 (i INT) ENGINE MYISAM  CHARSET utf8 COLLATE utf8_swedish_ci;
CREATE TABLE t2 (
    i INT
)
ENGINE INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- Visa SQL-koden för CREATE TABLE
SHOW CREATE TABLE kurs; -- lägg till \g i mysql cli för att visa rad för rad
SHOW CREATE TABLE kurstillfalle;