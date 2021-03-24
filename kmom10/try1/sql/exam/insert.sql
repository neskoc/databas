--
-- file: insert.sql
-- Initiera eshop-db med värdena från csv-filer.
-- By necu20 for eshop databas.
-- 2021-03-24
--

-- I mariadb cli: source insert.sql;

SET NAMES 'utf8';

USE exam;

DELETE FROM medlem2hund;
DELETE FROM ras;
DELETE FROM hund;
DELETE FROM medlem;

--
-- Enable LOAD DATA LOCAL INFILE on the server.
--
SET GLOBAL local_infile = 1;

--
-- Insert into medlem 
--
LOAD DATA LOCAL INFILE 'medlem.csv'
INTO TABLE medlem
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
    (
    `id`,
    `fornamn`,
    `alias`,
    `efternamn`,
    `ort`
     )
;

DELETE FROM ras;
--
-- Insert into ras. 
--
LOAD DATA LOCAL INFILE 'ras.csv'
INTO TABLE ras
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
    (
    `id`,
    `namn`,
    `godkand`
    )
;

DELETE FROM hund;
--
-- Insert into hund. 
--
LOAD DATA LOCAL INFILE 'hund.csv'
INTO TABLE hund
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
    (
    `id`,
    `namn`,
    `url`,
    `ras_id`
    )
;

--
-- Insert into medlem2hund. 
--
LOAD DATA LOCAL INFILE 'medlem2hund.csv'
INTO TABLE medlem2hund
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
    (
    `id`,
    `medlem_id`,
    `hund_id`,
    `registrerad`
    )
;
