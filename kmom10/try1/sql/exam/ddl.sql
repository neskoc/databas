--
-- file: ddl.sql
-- Skapa tabeller för exam.
-- By necu20 for exam databas.
-- 2021-03-24
--

USE exam;
SET NAMES 'utf8';
SET collation_connection = 'utf8_swedish_ci';

DROP TABLE IF EXISTS medlem2hund;
DROP TABLE IF EXISTS hund;
DROP TABLE IF EXISTS ras;
DROP TABLE IF EXISTS medlem;


-- medlem (#id, fornamn, alias, efternamn, ort)
-- DROP TABLE IF EXISTS medlem;
CREATE TABLE medlem
(
    `id`            INT NOT NULL,
    `fornamn`       VARCHAR(20),
    `alias`         VARCHAR(20),
    `efternamn`     VARCHAR(20),
    `ort`           VARCHAR(30),

    PRIMARY KEY (id)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- ras (#id, namn, godkand)
-- DROP TABLE IF EXISTS ras;
CREATE TABLE ras
(
    `id`       VARCHAR(5) NOT NULL,
    `namn`     VARCHAR(30),
    `godkand`  VARCHAR(3),

    PRIMARY KEY (id)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;

-- hund (#id, namn, url, ras_id)
-- DROP TABLE IF EXISTS hund;
CREATE TABLE hund
(
    `id` INT NOT NULL,
    `namn` VARCHAR(30),
    `url`  VARCHAR(200),
    `ras_id` VARCHAR(5) NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (ras_id) REFERENCES ras(id)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;


-- medlem2hund (#id, medlem_id, hund_id, registrerad)
-- DROP TABLE IF EXISTS medlem2hund;
CREATE TABLE medlem2hund
(
    `id`            INT NOT NULL,
    `medlem_id`     INT NOT NULL,
    `hund_id`       INT NOT NULL,
    `registrerad`   INT,

    PRIMARY KEY (id),
    FOREIGN KEY (medlem_id) REFERENCES medlem(id),
    FOREIGN KEY (hund_id) REFERENCES hund(id)
)
ENGINE=INNODB
CHARSET utf8
COLLATE utf8_swedish_ci
;


-- ---------------------------------------------------------
-- Stored procedures
-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_all;
DELIMITER ;;
CREATE PROCEDURE get_all(
        p_search VARCHAR(50)
    )
BEGIN
    SET @search = IFNULL(p_search, '%%');
    
    SELECT CONCAT(fornamn, ' ("' , alias, '") '  , efternamn) AS Namn,
           ort AS Ort,
            h.namn AS Hund,
            url,
            r.namn AS Ras,
            r.godkand AS Godkand,
            registrerad AS Registrerad
    FROM medlem AS m
        JOIN medlem2hund AS m2h
            ON m.id = m2h.medlem_id
        JOIN hund AS h
            ON h.id = m2h.hund_id
        JOIN ras AS r
            ON r.id = h.ras_id
    HAVING Namn LIKE @search OR
        Ort LIKE @search OR
        Hund LIKE @search OR
        url LIKE @search OR
        Ras LIKE @search OR
        Godkand LIKE @search OR
        Registrerad LIKE @search
        ORDER BY registrerad;
END;;
DELIMITER ;

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_report;
DELIMITER ;;
CREATE PROCEDURE get_report()
BEGIN
    
(
    SELECT CONCAT(fornamn, ' ("' , alias, '") '  , efternamn) AS Namn,
           ort AS Ort,
           h.namn AS Hund,
           IF(r.namn='Blandras','Blandras (X)',r.namn) AS Ras,
           registrerad AS Registrerad
    FROM hund AS h
        RIGHT JOIN ras AS r
            ON r.id = h.ras_id
        LEFT JOIN medlem2hund AS m2h
            ON h.id = m2h.hund_id
        LEFT JOIN medlem AS m
            ON m.id = m2h.medlem_id
    WHERE r.id != 'sc'
)
UNION
(
    SELECT CONCAT(fornamn, ' ("' , alias, '") '  , efternamn) AS Namn,
           ort AS Ort,
           h.namn AS Hund,
           IF(r.namn='Blandras','Blandras (X)',r.namn) AS Ras,
           registrerad AS Registrerad
    FROM hund AS h
        RIGHT JOIN ras AS r
            ON r.id = h.ras_id
        LEFT JOIN medlem2hund AS m2h
            ON h.id = m2h.hund_id
        RIGHT JOIN medlem AS m
            ON m.id = m2h.medlem_id
)
ORDER BY Ras, Registrerad DESC, Hund
;

END;;
DELIMITER ;
-- SET @search = '%Laska%';
-- CALL get_all(@search);
