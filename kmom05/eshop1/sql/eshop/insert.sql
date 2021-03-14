--
-- file: insert.sql
-- Initiera eshop-db med värdena från csv-filer.
-- By necu20 for eshop databas.
-- 2021-03-02
--

-- I mariadb cli: source insert.sql;

SET NAMES 'utf8';

USE eshop;

DELETE FROM produkt2hylla;
DELETE FROM produkt2kategori;
DELETE FROM kund;

--
-- Enable LOAD DATA LOCAL INFILE on the server.
--
SET GLOBAL local_infile = 1;

--
-- Insert into kund 
--
LOAD DATA LOCAL INFILE 'kund.csv'
INTO TABLE kund
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
    (
       `fornamn`,
       `efternamn`,
       `telefon`,
       `epost`,
       `fakturaadress`,
       `leveransadress`,
       `registreringsdatum`
     )
;

DELETE FROM produkt;
--
-- Insert into produkt. 
--
LOAD DATA LOCAL INFILE 'produkt.csv'
INTO TABLE produkt
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
    (
        @produkt,
        pris,
        produktnamn,
        produktbild_lank,
        beskrivning
    )
;

DELETE FROM produktkategori;
--
-- Insert into kategori. 
--
LOAD DATA LOCAL INFILE 'produktkategori.csv'
INTO TABLE produktkategori
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
    (
        kategorinamn,
        kategoribild_lank
    )
;

DELETE FROM hylla;
--
-- Insert into kategori. 
--
LOAD DATA LOCAL INFILE 'hylla.csv'
INTO TABLE hylla
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
    (
        hylla_id
    )
;

--
-- Insert into produkt2kategori. 
--
LOAD DATA LOCAL INFILE 'produkt2kategori.csv'
INTO TABLE produkt2kategori
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
    (
        @produkt,
        produkt_id,
        @kategori,
        kategori_id
    )
;

--
-- Insert into produkt2hylla. 
--
LOAD DATA LOCAL INFILE 'produkt2hylla.csv'
INTO TABLE produkt2hylla
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
    (
        @produkt,
        produkt_id,
        antal,
        hylla_id
    )
;
