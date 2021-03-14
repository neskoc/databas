--
-- file: stored_procedures.sql
-- Test av lagrade procedure.
-- By necu20 for eshop databas.
-- 2021-03-06
--

USE eshop;


-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_categories;
DELIMITER ;;
CREATE PROCEDURE get_categories()
BEGIN
    SELECT * FROM produktkategori;
END;;
DELIMITER ;
-- CALL get_categories();

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_customer;
DELIMITER ;;
CREATE PROCEDURE get_customer(
    p_kund_id INT
    )
BEGIN
    SELECT * FROM kund WHERE kund_id = p_kund_id;
END;;
DELIMITER ;
-- CALL get_customer(1);

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_customers;
DELIMITER ;;
CREATE PROCEDURE get_customers()
BEGIN
    SELECT * FROM kund;
END;;
DELIMITER ;
-- CALL get_customers();

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_shelves;
DELIMITER ;;
CREATE PROCEDURE get_shelves()
BEGIN
    SELECT * FROM hylla;
END;;
DELIMITER ;
-- CALL get_shelves();

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_products_in_category;
DELIMITER ;;
CREATE PROCEDURE get_products_in_category(
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

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS delete_categories4product;
DELIMITER ;;
CREATE PROCEDURE delete_categories4product(p_produkt_id INT)
BEGIN
    DELETE FROM produkt2kategori WHERE produkt_id = p_produkt_id;
END;;
DELIMITER ;
-- CALL delete_categories4product(1);

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS create_order;
DELIMITER ;;
CREATE PROCEDURE create_order(
        p_kund_id INT,
        OUT p_bestallning_id INT
    )
BEGIN
    INSERT INTO bestallning(kund_id, `status`) 
        VALUES(p_kund_id, 'skapad')
    ;
    SELECT LAST_INSERT_ID() INTO p_bestallning_id;

    SET @handelse = CONCAT("Order `", p_bestallning_id, "` skapades.");
    INSERT INTO logg (`handelse`) VALUES (@handelse);
END
;;
DELIMITER ;

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS create_order_row;
DELIMITER ;;
CREATE PROCEDURE create_order_row(
        p_bestallning_id INT,
        p_produkt_id INT,
        p_antal INT,
        p_pris INT
    )
BEGIN
    INSERT INTO bestallning_rad(bestallning_id, produkt_id, antal, pris) 
        VALUES(p_bestallning_id, p_produkt_id, p_antal, p_pris)
    ;
END
;;
DELIMITER ;

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_order;
DELIMITER ;;
CREATE PROCEDURE get_order(
    p_bestallning_id INT
    )
BEGIN
    SELECT * FROM bestallning WHERE bestallning_id = p_bestallning_id;
END;;
DELIMITER ;
-- CALL get_order(2);

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_invoice_by_orderid;
DELIMITER ;;
CREATE PROCEDURE get_invoice_by_orderid(
    p_bestallning_id INT
    )
BEGIN
    SELECT faktura_id, skapad, betalld, `status`
        FROM faktura
            WHERE bestallning_id = p_bestallning_id;
END;;
DELIMITER ;
-- CALL get_invoice_by_orderid(3);

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_orders;
DELIMITER ;;
CREATE PROCEDURE get_orders(
        IN search VARCHAR(100)
    )
BEGIN
    SELECT b.bestallning_id, kund_id, skapad, COUNT(br.bestallning_id) AS antal, b.status FROM bestallning AS b
        LEFT JOIN bestallning_rad AS br
            ON b.bestallning_id = br.bestallning_id
    WHERE b.bestallning_id LIKE search OR kund_id LIKE search
        GROUP BY b.bestallning_id
    ;
END
;;
DELIMITER ;

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_customer_from_order;
DELIMITER ;;
CREATE PROCEDURE get_customer_from_order(p_bestallning_id INT)
BEGIN
    SELECT kund_id FROM bestallning 
        WHERE bestallning_id = p_bestallning_id
            LIMIT 1
    ;
END
;;
DELIMITER ;
-- CALL get_customer_from_order(2);

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_order_rows;
DELIMITER ;;
CREATE PROCEDURE get_order_rows(p_bestallning_id INT)
BEGIN
    SELECT produkt_id, antal, pris FROM bestallning_rad 
        WHERE bestallning_id = p_bestallning_id
            ORDER BY produkt_id
    ;
END
;;
DELIMITER ;
-- CALL get_order_rows(2);

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS remove_order_rows;
DELIMITER ;;
CREATE PROCEDURE remove_order_rows(p_bestallning_id INT)
BEGIN
    DELETE FROM bestallning_rad
        WHERE bestallning_id = p_bestallning_id
    ;
END
;;
DELIMITER ;

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS change_order_status;
DELIMITER ;;
CREATE PROCEDURE change_order_status(
    p_bestallning_id INT,
    p_status VARCHAR(10)
    )
BEGIN
    IF p_status != "aktivera" THEN
        UPDATE bestallning
            SET `status` = p_status
        WHERE bestallning_id = p_bestallning_id;
    END IF;
   
    SET @p_timestamp = NOW();
    CASE p_status
        WHEN "beställd" THEN
            UPDATE bestallning
                SET bestalld = @p_timestamp
                    WHERE bestallning_id = p_bestallning_id
            ;
        WHEN "skickad" THEN
            UPDATE bestallning
                SET skickad = @p_timestamp
                    WHERE bestallning_id = p_bestallning_id
            ;
        WHEN "raderad" THEN
            UPDATE bestallning
                SET raderad = @p_timestamp
                    WHERE bestallning_id = p_bestallning_id
            ;
        WHEN "uppdaterad" THEN
            UPDATE bestallning
                SET raderad = NULL
                    WHERE bestallning_id = p_bestallning_id
            ;
        WHEN "aktivera" THEN
            BEGIN
                UPDATE bestallning
                    SET raderad = NULL, `status` =
                            CASE
                                WHEN skickad IS NOT NULL THEN "skickad"
                                WHEN bestalld IS NOT NULL THEN "beställd"
                                ELSE "uppdaterad"
                            END
                        WHERE bestallning_id = p_bestallning_id
                ;
            END;
        ELSE
            BEGIN
            END; -- do nothing
    END CASE;
END;;
DELIMITER ;

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_invoice_rows;
DELIMITER ;;
CREATE PROCEDURE get_invoice_rows(p_faktura_id INT)
BEGIN
    SELECT produkt_id, antal, pris FROM faktura_rad 
        WHERE faktura_id = p_faktura_id
    ;
END
;;
DELIMITER ;
-- CALL get_invoice_rows(4);

-- ---------------------------------------------------------


DROP PROCEDURE IF EXISTS create_invoice;
DELIMITER ;;
CREATE PROCEDURE create_invoice(
    p_bestallning_id INT
    )
BEGIN
    SELECT kund_id
        FROM bestallning
            WHERE bestallning_id = p_bestallning_id AND
                (`status` = 'beställd' OR `status` = 'skickad')
        INTO @p_kund_id
    ;
    INSERT INTO faktura(bestallning_id, `status`, kund_id)
        VALUES(
            p_bestallning_id,
            'skapad',
            @p_kund_id
            )
    ;
    SELECT LAST_INSERT_ID() INTO @p_faktura_id;
    INSERT INTO faktura_rad(faktura_id, produkt_id, antal, pris)
        SELECT @p_faktura_id, produkt_id, antal, pris
            FROM bestallning_rad
                WHERE bestallning_id = p_bestallning_id
    ;
    CALL change_order_status(p_bestallning_id, "skickad");
END;;
DELIMITER ;
-- CALL create_invoice(3);

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS set_invoice_status2paid;
DELIMITER ;;
CREATE PROCEDURE set_invoice_status2paid(
    IN p_invoice_id INT,
    IN p_date DATE,
    OUT p_tranaction_status BOOLEAN
    )
BEGIN
    SET p_tranaction_status = is_invoice(p_invoice_id);

    IF (p_tranaction_status) THEN
        UPDATE faktura
            SET `status` = "betalld",
                betalld = p_date
            WHERE faktura_id = p_invoice_id;
    END IF;        
END;;
DELIMITER ;

-- ---------------------------------------------------------

DROP PROCEDURE IF EXISTS get_shelves_with_products;
DELIMITER ;;
CREATE PROCEDURE get_shelves_with_products(
    IN p_bestallning_id INT
    )
BEGIN
    SELECT br.produkt_id, produktnamn, hylla_id, p2h.antal
    FROM bestallning_rad AS br
        JOIN produkt2hylla AS p2h
            ON br.produkt_id = p2h.produkt_id
        JOIN produkt AS p
            ON br.produkt_id = p.produkt_id
    WHERE bestallning_id = p_bestallning_id
    ORDER BY br.produkt_id
;    
END;;
DELIMITER ;

-- ----------------------------------------------------------------------------------------------------------------------------------------
-- Functions
-- ----------------------------------------------------------------------------------------------------------------------------------------

--
-- Check if invoice exists.
--
DROP FUNCTION IF EXISTS is_invoice;
DELIMITER ;;

CREATE FUNCTION is_invoice(
    f_faktura_id INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    SELECT COUNT(faktura_id) FROM faktura
        WHERE faktura_id = f_faktura_id AND `status` = "skapad"
            LIMIT 1
    INTO @exist;
    IF (@exist = 0) THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END
;;

DELIMITER ;

-- ----------------------------------------------------------------------------------------------------------------------------------------
-- Triggers
-- ----------------------------------------------------------------------------------------------------------------------------------------

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

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------

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

-- ---------------------------------------------------------