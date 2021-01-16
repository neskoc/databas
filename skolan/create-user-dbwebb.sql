/*
DROP USER IF EXISTS 'dbwebb'@'%';
Följande kommandån körs manuellt för att skapa ett hemligt lösenord

CREATE USER 'dbwebb'@'%'
    IDENTIFIED BY 'password';

CREATE USER 'dbwebb'@'localhost'
    IDENTIFIED BY 'password';
*/

GRANT ALL PRIVILEGES
    ON *.*
    TO 'dbwebb'@'%'
    WITH GRANT OPTION;

SHOW VARIABLES LIKE "%version%";

--
-- Check the status for users root, dbwebb and user.
--
SELECT
    User,
    Host,
    Grant_priv,
    plugin
FROM mysql.user
WHERE
    User IN ('root', 'dbwebb', 'user')
ORDER BY User;
