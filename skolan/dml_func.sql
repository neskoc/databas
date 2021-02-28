--
-- file: dml_func.sql
-- Inbyggda funktioner.
-- By necu20 for course databas.
-- 2021-01-30
--

USE skolan;

SELECT "Strängfunktioner" AS '';

SELECT "1. Skriv en SELECT-sats som skriver ut förnamn + efternamn + avdelning i samma kolumn enligt följande struktur: förnamn efternamn (avdelning)." AS '';
SELECT CONCAT(fornamn, " ", efternamn, " (", avdelning, ")") AS NamnAvdelning FROM larare;

SELECT "3. Gör om samma sak men skriv ut avdelningens namn med små bokstäver och begränsa utskriften till 3 rader" AS '';
SELECT CONCAT(fornamn, " ", efternamn, " (", lower(avdelning), ")") AS NamnAvdelning
FROM larare
    LIMIT 3;

SELECT "Datum och tid" AS '';

SELECT "1. Skriv en SELECT-sats som endast visar dagens datum." AS '';
SELECT CURDATE();

SELECT "2. Gör en SELECT-sats som visar samtliga lärare, deras födelseår samt dagens datum och klockslag." AS '';
SELECT
    fornamn,
    fodd,
    CURDATE() AS "Dagens datum",
    CURDATE() AS Klockslag
FROM
    larare
;

SELECT "Beräkna ålder" AS '';

SELECT "1. Skriv en SELECT-sats som beräknar lärarens ålder, sortera rapporten för att visa vem som är äldst och yngst." AS '';
SELECT
    fornamn,
    fodd,
    ROUND(DATEDIFF(CURDATE(), fodd) / 365) AS `Ålder`
FROM larare
    ORDER BY fodd ASC
;

SELECT "Filtrera per del av datum" AS '';

SELECT "1. Visa de lärare som är födda på 40-talet." AS '';
SELECT fornamn, YEAR(fodd) AS "födelseår"
FROM larare
    WHERE
        YEAR(fodd) >= 1940 AND
        YEAR(fodd) < 1950
;