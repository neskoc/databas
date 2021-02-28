--
-- file: dml_agg.sql
-- Aggregerande funktioner.
-- By necu20 for course databas.
-- 2021-01-29
--

USE skolan;

SELECT "Uppgifter MIN och MAX" AS '';
SELECT "1. Hur mycket är den högsta lönen som en lärare har?" AS '';
SELECT "2. Hur mycket är den lägsta lönen som en lärare har?" AS '';
SELECT MIN(lon), MAX(lon) FROM larare;

SELECT "Uppgifter GROUP BY" AS '';
SELECT "1. Hur många lärare jobbar på de respektive avdelning?" AS '';
SELECT
	avdelning,
    COUNT(akronym) AS antal
FROM larare
    GROUP BY avdelning
;

SELECT "2. Hur mycket betalar respektive avdelning ut i lön varje månad?" AS '';
SELECT
	avdelning,
    SUM(lon) AS utbetalning
FROM larare
	GROUP BY avdelning;

SELECT "3. Hur mycket är medellönen för de olika avdelningarna?" AS '';
SELECT avdelning, AVG(lon) AS "medellön per avd" FROM larare GROUP BY avdelning;

SELECT "4. Hur mycket är medellönen för kvinnor kontra män?" AS '';
SELECT
	kon AS "kön",
    AVG(lon) AS "medellön per kön"
FROM larare
	GROUP BY kon;

SELECT "Visa snittet på kompetensen för alla avdelningar, sortera på kompetens i sjunkande ordning och visa enbart den avdelning som har högst kompetens." AS '';
SELECT
	avdelning,
    AVG(kompetens)
FROM larare
	GROUP BY avdelning
    ORDER BY kompetens
    DESC LIMIT 1
;

SELECT "Visa den avrundade snittlönen (ROUND()) grupperad per avdelning och per kompetens, sortera enligt avdelning och snittlön. Visa även hur många som matchar i respektive gruppering."  AS '';
SELECT
	avdelning AS Avdelning,
    kompetens AS Kompetens,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(akronym) AS Antal
FROM larare
	GROUP BY avdelning, kompetens
    ORDER BY avdelning, snittlon
;

SELECT "Uppgifter HAVING" AS '';

SELECT "1. Visa per avdelning hur många anställda det finns, gruppens snittlön, sortera per avdelning och snittlön" AS '';
SELECT
	avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(akronym) AS Antal
FROM larare
	GROUP BY avdelning
    ORDER BY avdelning, Snittlon
;

SELECT "2. Visa samma sak som i 1), men visa nu även de kompetenser som finns." AS '';
SELECT
	avdelning,
    kompetens,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(akronym) AS Antal
FROM larare
	GROUP BY avdelning, kompetens
    ORDER BY avdelning, kompetens DESC
;

SELECT "3. Visa samma sak som i 2), men ignorera de kompetenser som är större än 3." AS '';
SELECT
	avdelning,
    kompetens,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(akronym) AS Antal
FROM larare
	GROUP BY avdelning, kompetens
    HAVING kompetens < 4
    ORDER BY avdelning, kompetens DESC
;

SELECT "4. Visa samma sak som i 3), men exkludera de grupper som har fler än 1 deltagare och inkludera de som har snittlön mellan 30 000 - 45 000. Sortera per snittlön." AS '';
SELECT
	avdelning,
    kompetens,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(akronym) AS Antal
FROM larare
	GROUP BY avdelning, kompetens
    HAVING 
		kompetens < 4 AND
        Antal < 2 AND
        Snittlon >= 30000 AND
        Snittlon <= 45000
    ORDER BY Snittlon DESC
;