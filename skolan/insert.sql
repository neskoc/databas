--
-- file: insert.sql
-- Joina tabell.
-- By necu20 for course databas.
-- 2021-02-07
--

SET NAMES 'utf8';

USE skolan;

DELETE FROM larare WHERE EXISTS (SELECT * FROM larare);

--
-- Add teacher staff
--
INSERT INTO larare
    (akronym, avdelning, fornamn, efternamn, kon, lon, fodd)
VALUES
    ('sna', 'DIPT', 'Severus', 'Snape', 'M', 40000, '1951-05-01'),
    ('dum', 'ADM', 'Albus', 'Dumbledore', 'M', 80000, '1941-04-01'),
    ('min', 'DIDD', 'Minerva', 'McGonagall', 'K', 40000, '1955-05-05'),
    ('hag', 'ADM', 'Hagrid', 'Rubeus', 'M', 25000, '1956-05-06'),
    ('fil', 'ADM', 'Argus', 'Filch', 'M', 25000, '1946-04-06'),
    ('hoc', 'DIDD', 'Madam', 'Hooch', 'K', 35000, '1948-04-08'),
    ('gyl', 'DIPT', 'Gyllenroy', 'Lockman', 'M', 30000, '1952-05-02'),
    ('ala', 'DIPT', 'Alastor', 'Moody', 'M', 30000, '1943-04-03')
;

DELETE FROM larare_pre WHERE EXISTS (SELECT * FROM larare_pre);
INSERT INTO larare_pre SELECT * FROM larare;

DELETE FROM kurstillfalle;
DELETE FROM kurs;

--
-- Enable LOAD DATA LOCAL INFILE on the server.
--
SET GLOBAL local_infile = 1;

--
-- Insert into kurs 
--
LOAD DATA LOCAL INFILE 'kurs.csv'
INTO TABLE kurs
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

--
-- Insert into kurstillfalle. 
--
LOAD DATA LOCAL INFILE 'kurstillfalle.csv'
INTO TABLE kurstillfalle
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(kurskod, kursansvarig, lasperiod)
;
