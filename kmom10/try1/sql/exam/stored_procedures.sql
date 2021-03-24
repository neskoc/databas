--
-- file: stored_procedures.sql
-- Test av lagrade procedure.
-- By necu20 for exam databas.
-- 2021-03-24
--

USE exam;
SET NAMES 'utf8';
SET collation_connection = 'utf8_swedish_ci';


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
ORDER BY Ras, Registrerad DESC
;

END;;
DELIMITER ;
-- SET @search = '%Laska%';
-- CALL get_all(@search);
