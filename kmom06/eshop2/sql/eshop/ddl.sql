--
-- file: ddl.sql
-- Skapa tabeller för eshop.
-- By necu20 for course databas.
-- 2021-02-016
--

SET NAMES 'utf8';
USE eshop;

DROP TABLE IF EXISTS logg;
DROP TABLE IF EXISTS produkt2hylla;
DROP TABLE IF EXISTS produkt2kategori;
DROP TABLE IF EXISTS bestallning_rad;
DROP TABLE IF EXISTS faktura_rad;
DROP TABLE IF EXISTS faktura;
DROP TABLE IF EXISTS bestallning;

DROP TABLE IF EXISTS produkt;
DROP TABLE IF EXISTS produktkategori;
DROP TABLE IF EXISTS kund;
DROP TABLE IF EXISTS hylla;


-- produkt(id, namn, antal, kort beskrivning, bild)
-- DROP TABLE IF EXISTS produkt;
CREATE TABLE produkt
(
    `produkt_id` INT AUTO_INCREMENT NOT NULL,
    `produktnamn` VARCHAR(30),
    `pris` INT,
    `beskrivning` VARCHAR(300),
    `produktbild_lank` VARCHAR(200),

    PRIMARY KEY (produkt_id)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- produktkategori (id, namn, bild)
-- DROP TABLE IF EXISTS produktkategori;
CREATE TABLE produktkategori
(
    `kategori_id` INT AUTO_INCREMENT NOT NULL,
    `kategorinamn` VARCHAR(30),
    `bildlank`  VARCHAR(200),

    PRIMARY KEY (kategori_id)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- kund (id, namn, telefon, epost, fakturaadress, leveransadress, datum)
-- DROP TABLE IF EXISTS kund;
CREATE TABLE kund
(
    `kund_id`            INT AUTO_INCREMENT NOT NULL,
    `fornamn`            VARCHAR(20),
    `efternamn`          VARCHAR(20),
    `telefon`            VARCHAR(15),
    `epost`              VARCHAR(40),
    `fakturaadress`      VARCHAR(200),
    `leveransadress`     VARCHAR(200),
    `registreringsdatum` DATE,

    PRIMARY KEY (kund_id)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- hylla (id, position)
-- DROP TABLE IF EXISTS hylla;
CREATE TABLE hylla
(
    `hylla_id`   INT AUTO_INCREMENT NOT NULL,

    PRIMARY KEY (hylla_id)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- produkthylla (#produkt_id, #hyll_id, antal)
-- DROP TABLE IF EXISTS produkt2hylla;
CREATE TABLE produkt2hylla
(
    `produkt_id`    INT NOT NULL,
    `hylla_id`      INT NOT NULL,

    PRIMARY KEY (produkt_id, hylla_id),
    FOREIGN KEY (produkt_id) REFERENCES produkt(produkt_id),
    FOREIGN KEY (hylla_id) REFERENCES hylla(hylla_id)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- order (id, #kund_id, datum, senast uppdaterat, status)
-- DROP TABLE IF EXISTS bestallning;
CREATE TABLE bestallning
(
    `bestallning_id` INT AUTO_INCREMENT NOT NULL,
    `kund_id`        INT NOT NULL,
    `skapad`         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `uppdaterad`     TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    `bestalld`       TIMESTAMP NULL,
    `skickad`        TIMESTAMP NULL,
    `raderad`        TIMESTAMP NULL,
    `status`         VARCHAR(10),
    -- Status: “Skapad”, “Uppdaterad”, “Raderad”, “Beställd” eller “Skickad”

    PRIMARY KEY (bestallning_id),
    FOREIGN KEY (kund_id) REFERENCES kund(kund_id),
    KEY `bestallning_key` (`status`),
    FULLTEXT KEY bestallning_fulltext(`status`)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- bestallningrad (#bestallning_id, #produkt_id, antal)
-- DROP TABLE IF EXISTS bestallning_rad;
CREATE TABLE bestallning_rad
(
    `bestallning_id` INT NOT NULL,
    `produkt_id`     INT NOT NULL,
    `antal`          INT NOT NULL,
    `pris`           INT NOT NULL,

    PRIMARY KEY (bestallning_id, produkt_id),
    FOREIGN KEY (bestallning_id) REFERENCES bestallning(bestallning_id),
    FOREIGN KEY (produkt_id) REFERENCES produkt(produkt_id)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- faktura (id, #bestallning_id, #kund_id, summa)
DROP TABLE IF EXISTS faktura;
CREATE TABLE faktura
(
    `faktura_id`     INT AUTO_INCREMENT NOT NULL,
    `kund_id`        INT NOT NULL,
    `bestallning_id` INT NOT NULL,
    `skapad`         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `betalld`        DATE NULL,
    `status`         VARCHAR(10),

    PRIMARY KEY (faktura_id),
    FOREIGN KEY (kund_id) REFERENCES kund(kund_id),
    FOREIGN KEY (bestallning_id) REFERENCES bestallning(bestallning_id)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- fakturarad (#faktura_id, #produkt_id, antal, pris)
-- DROP TABLE IF EXISTS faktura_rad;
CREATE TABLE faktura_rad
(
    `faktura_id`   INT NOT NULL,
    `produkt_id`   INT NOT NULL,
    `antal`        INT NOT NULL,
    `pris`         FLOAT NOT NULL,

    PRIMARY KEY (faktura_id, produkt_id),
    FOREIGN KEY (faktura_id) REFERENCES faktura(faktura_id),
    FOREIGN KEY (produkt_id) REFERENCES produkt(produkt_id)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- logg (id, timestamp, händelse)
-- DROP TABLE IF EXISTS logg;
CREATE TABLE logg
(
    `logg_id`       INT AUTO_INCREMENT NOT NULL,
    `tidsstampel`   TIMESTAMP,
    `hadelse`       VARCHAR(300),

    PRIMARY KEY (logg_id),
    KEY `handelse_index` (`hadelse`),
    FULLTEXT KEY handelse_fulltext(`hadelse`)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

CREATE TABLE `produkt2kategori` (
    `produkt_id` int(11) NOT NULL,
    `kategori_id` int(11) NOT NULL,
    PRIMARY KEY (`produkt_id`,`kategori_id`),
    FOREIGN KEY (produkt_id) REFERENCES  produkt(produkt_id),
    FOREIGN KEY (kategori_id) REFERENCES  produktkategori(kategori_id)
)
ENGINE=InnoDB
CHARSET=utf8
COLLATE=utf8_swedish_ci
;
