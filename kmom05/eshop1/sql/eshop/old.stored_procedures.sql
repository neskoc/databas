--
-- file: stored_procedures.sql
-- Test av lagrade procedure.
-- By necu20 for eshop databas.
-- 2021-03-02
--

USE eshop;


DROP PROCEDURE IF EXISTS get_category;
DELIMITER ;;
CREATE PROCEDURE get_category(
        p_category_id INT
    )
BEGIN
    SELECT * FROM produktkategori WHERE kategori_id = p_category_id;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS get_categories;
DELIMITER ;;
CREATE PROCEDURE get_categories()
BEGIN
    SELECT * FROM produktkategori;
END;;
DELIMITER ;
-- CALL get_categories();


DROP PROCEDURE IF EXISTS get_products_categories;
DELIMITER ;;
CREATE PROCEDURE get_products_categories(p_produkt_id INT)
BEGIN
    SELECT p.kategori_id, kategorinamn FROM produktkategori AS p
        JOIN produkt2kategori AS p2k
            ON p.kategori_id = p2k.kategori_id
    WHERE p2k.produkt_id = @p_produkt_id
    ;
END;;
DELIMITER ;
-- CALL get_products_categories(9);

DROP PROCEDURE IF EXISTS get_customers;
DELIMITER ;;
CREATE PROCEDURE get_customers()
BEGIN
    SELECT * FROM kund;
END;;
DELIMITER ;

-- CALL get_customers();


-- Visa (minst) produktens id, namn, pris och antal som finns i lagret.
-- Visa även information om vilken kategori som produkten tillhör (TIPS GROUP_CONCAT).
DROP PROCEDURE IF EXISTS get_products;
DELIMITER ;;
CREATE PROCEDURE get_products()
BEGIN
    SELECT p.produkt_id AS id, produktnamn AS namn, IFNULL(SUM(ph.antal),0) AS antal, pris, aktiv,
            (
                SELECT  GROUP_CONCAT(pk.kategorinamn SEPARATOR ', ')
                FROM produktkategori AS pk
                    JOIN produkt2kategori AS p2k
                        ON p2k.kategori_id = pk.kategori_id
                WHERE p.produkt_id = p2k.produkt_id
            ) AS kategorier
    FROM produkt AS p
        LEFT JOIN produkt2hylla AS ph
            ON ph.produkt_id = p.produkt_id
    GROUP BY id
    ;
END;;
DELIMITER ;
-- CALL get_products();


DROP PROCEDURE IF EXISTS get_shelves;
DELIMITER ;;
CREATE PROCEDURE get_shelves()
BEGIN
    SELECT * FROM hylla;
END;;
DELIMITER ;
-- CALL get_shelves();


DROP PROCEDURE IF EXISTS get_inventory;
DELIMITER ;;
CREATE PROCEDURE get_inventory(
        IN search VARCHAR(100)
    )
BEGIN
    SELECT p.produkt_id AS produktid, produktnamn, hylla_id AS hylla, antal FROM produkt AS p
        JOIN produkt2hylla AS p2h
            ON p.produkt_id = p2h.produkt_id
    WHERE p.produkt_id LIKE search
        OR produktnamn LIKE search
        OR hylla_id LIKE search
;
END;;
DELIMITER ;
-- CALL get_inventory('%kaffe%');


DROP PROCEDURE IF EXISTS increase_inventory;
DELIMITER ;;
CREATE PROCEDURE increase_inventory(
        IN p_produkt_id INT,
        IN p_hylla_id VARCHAR(100),
        IN p_antal INT
    )
BEGIN
    SET @res = NULL;

    SELECT antal 
        FROM produkt2hylla
            WHERE produkt_id = p_produkt_id AND
                hylla_id = p_hylla_id
    INTO @res
    ;

    IF ISNULL(@res) THEN
        INSERT INTO produkt2hylla(produkt_id, hylla_id, antal)
            VALUES(p_produkt_id, p_hylla_id, p_antal)
        ;
    ELSE
        UPDATE produkt2hylla
            SET antal = antal + p_antal
                WHERE produkt_id = p_produkt_id AND
                    hylla_id = p_hylla_id
        ;
    END IF;
END
;;
DELIMITER ;

-- SET @p_produkt_id = 1;
-- SET @p_hylla_id =  'A101';
-- SET @p_antal =  5;
-- CALL increase_inventory(@p_produkt_id, @p_hylla_id, @p_antal);
-- SELECT * FROM eshop.produkt2hylla;


DROP PROCEDURE IF EXISTS decrease_inventory;
DELIMITER ;;
CREATE PROCEDURE decrease_inventory(
        IN p_produkt_id INT,
        IN p_hylla_id VARCHAR(100),
        IN p_antal INT,
        OUT fel BOOLEAN
    )
BEGIN
    SET @res = NULL;

    SELECT antal 
        FROM produkt2hylla
            WHERE produkt_id = p_produkt_id AND
                hylla_id = p_hylla_id
    INTO @res
    ;
    IF ISNULL(@res) = 0 AND @res >= p_antal THEN
        UPDATE produkt2hylla
            SET antal = antal - p_antal
                WHERE produkt_id = p_produkt_id AND
                    hylla_id = p_hylla_id
        ;
        SET fel = FALSE;
    ELSE
        SET fel = TRUE;
    END IF;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS add_product2category;
DELIMITER ;;
CREATE PROCEDURE add_product2category(
        IN p_produkt_id INT,
        IN p_kategori_id VARCHAR(100)
    )
BEGIN
    INSERT INTO produkt2kategori(produkt_id, kategori_id)
        VALUES(p_produkt_id, p_kategori_id)
    ;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS get_product_in_category;
DELIMITER ;;
CREATE PROCEDURE get_product_in_category(
        p_category_id INT
    )
BEGIN
    SELECT p.produkt_id AS id, produktnamn AS namn, produktbild_lank AS lank FROM produkt AS p
        JOIN produkt2kategori AS p2k
            ON p.produkt_id = p2k.produkt_id
    WHERE kategori_id = p_category_id;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS add_product;
DELIMITER ;;
CREATE PROCEDURE add_product(
        p_produktnamn VARCHAR(150),
        p_pris DECIMAL(10,2),
        p_beskrivning VARCHAR(300),
        p_produktbild_lank VARCHAR(200)
    )
BEGIN
    INSERT INTO produkt(produktnamn, pris, beskrivning, produktbild_lank)
        VALUES(p_produktnamn, p_pris, p_beskrivning, p_produktbild_lank)
    ;
END
;;
DELIMITER ;

-- SET @p_produktnamn = 'test produkt';
-- SET @p_pris = '100';
-- SET @p_beskrivning =  'Beskrivning';
-- SET @p_produktbild_lank = 'test_bild.png';
-- CALL add_product(@p_produktnamn, @p_pris, @p_beskrivning, @p_produktbild_lank);

DROP PROCEDURE IF EXISTS get_product;
DELIMITER ;;
CREATE PROCEDURE get_product(
        p_produkt_id INT
    )
BEGIN
    SELECT * FROM produkt WHERE produkt_id = p_produkt_id;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS update_product;
DELIMITER ;;
CREATE PROCEDURE update_product(
        p_produkt_id INT,
        p_produktnamn VARCHAR(150),
        p_pris DECIMAL(10,2),
        p_beskrivning VARCHAR(300),
        p_produktbild_lank VARCHAR(200)
    )
BEGIN    
    UPDATE produkt
        SET produkt_id = p_produkt_id,
            produktnamn = p_produktnamn,
            pris = p_pris,
            beskrivning = p_beskrivning,
            produktbild_lank = p_produktbild_lank
        WHERE produkt_id = p_produkt_id
    ;
END
;;
DELIMITER ;

-- SET @p_produkt_id = 8;
-- SET @p_produktnamn = 'produkt8';
-- SET @p_pris = '445';
-- SET @p_beskrivning =  'Beskrivning8';
-- SET @p_produktbild_lank = 'bild8.png';
-- CALL update_product(@p_produkt_id, @p_produktnamn, @p_pris, @p_beskrivning, @p_produktbild_lank);


DROP PROCEDURE IF EXISTS delete_product;
DELIMITER ;;
CREATE PROCEDURE delete_product(
        p_produkt_id INT
    )
BEGIN    
    UPDATE produkt SET aktiv = FALSE
        WHERE produkt_id = p_produkt_id;
    DELETE FROM produkt2kategori WHERE produkt_id = p_produkt_id;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS delete_categories4product;
DELIMITER ;;
CREATE PROCEDURE delete_categories4product(p_produkt_id INT)
BEGIN
    DELETE FROM produkt2kategori WHERE produkt_id = p_produkt_id;
END;;
DELIMITER ;
-- CALL delete_categories4product(1);


DROP PROCEDURE IF EXISTS delete_product_permanently;
DELIMITER ;;
CREATE PROCEDURE delete_product_permanently(
        p_produkt_id INT
    )
BEGIN
    DELETE FROM produkt2kategori WHERE produkt_id = p_produkt_id;
    DELETE FROM produkt WHERE produkt_id = p_produkt_id;
END
;;
DELIMITER ;

-- SET @p_produktnamn = 'produkt';
-- SET @p_pris = '44';
-- SET @p_beskrivning =  'Beskrivning';
-- SET @p_produktbild_lank = 'bild.png';
-- CALL add_product(@p_produktnamn, @p_pris, @p_beskrivning, @p_produktbild_lank);
-- SET @produkt_id = 1;
-- CALL delete_product(@produkt_id);


DROP PROCEDURE IF EXISTS activate_product;
DELIMITER ;;
CREATE PROCEDURE activate_product(
        p_produkt_id INT
    )
BEGIN    
    UPDATE produkt SET aktiv = TRUE
        WHERE produkt_id = p_produkt_id;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS get_logs;
DELIMITER ;;
CREATE PROCEDURE get_logs(
        p_search VARCHAR(50),
        p_number_of_lines INT
    )
BEGIN
    SET @search = IFNULL(p_search, '%%');
    
    IF ISNULL(p_number_of_lines)
    THEN
        SELECT * FROM logg
            WHERE handelse LIKE @search
            ORDER BY tidsstampel DESC
            LIMIT 20;
    ELSE
        SELECT * FROM logg
            WHERE handelse LIKE @search
            ORDER BY tidsstampel DESC
            LIMIT p_number_of_lines;
    END IF;
END;;
DELIMITER ;

-- SET @p_number_of_logs = 3;
-- CALL get_logs(@p_number_of_logs);

-- -------------------------------------------------------------------
-- Triggers
-- -------------------------------------------------------------------

DROP TRIGGER IF EXISTS log_produkt_insert;
DELIMITER ;;
CREATE TRIGGER log_produkt_insert
AFTER INSERT
ON produkt
FOR EACH ROW
BEGIN
    SET @handelse = CONCAT("Ny produkt lades till med produktid `", NEW.produkt_id, "`.");
    INSERT INTO logg (`handelse`)
        VALUES (@handelse);
END;;
DELIMITER ;


DROP TRIGGER IF EXISTS log_produkt_update;
DELIMITER ;;
CREATE TRIGGER log_produkt_update
AFTER UPDATE
ON produkt
FOR EACH ROW
BEGIN
    IF OLD.aktiv = TRUE AND NEW.aktiv = FALSE
        THEN
            SET @handelse = CONCAT("Produkten med produktid `", NEW.produkt_id, "` inaktiverades.");
            INSERT INTO logg (`handelse`)
                VALUES (@handelse);
        ELSEIF OLD.aktiv = FALSE AND NEW.aktiv = TRUE
        THEN
            SET @handelse = CONCAT("Produkten med produktid `", NEW.produkt_id, "` aktiverades.");
            INSERT INTO logg (`handelse`)
                VALUES (@handelse);
        ELSE
            SET @handelse = CONCAT("Detaljer om produktid `", NEW.produkt_id, "` uppdaterades.");
            INSERT INTO logg (`handelse`) VALUES (@handelse);
        END IF;
END;;
DELIMITER ;


DROP TRIGGER IF EXISTS log_produkt_tabort;
DELIMITER ;;
CREATE TRIGGER log_produkt_tabort
AFTER DELETE
ON produkt
FOR EACH ROW
BEGIN
     SET @handelse = CONCAT("Detaljer om produktid `", OLD.produkt_id, "` togs bort permanent.");
     INSERT INTO logg (`handelse`) VALUES (@handelse);
END;;
DELIMITER ;