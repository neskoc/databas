--
-- Create scheme for database skolan.
-- By necu20 for course databas.
-- 2021-01-15
--

USE skolan;

--
-- Create table: larare
--
DROP TABLE IF EXISTS larare;
CREATE TABLE larare
(
    akronym CHAR(3),
    avdelning CHAR(4),
    fornamn VARCHAR(20),
    efternamn VARCHAR(20),
    kon CHAR(1),
    lon INT,
    fodd DATE,

    PRIMARY KEY (akronym)
);

SHOW TABLES;

SELECT * FROM larare;
