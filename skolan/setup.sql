-- Skapa databas
-- CREATE DATABASE skolan;
CREATE DATABASE IF NOT EXISTS skolan;
CREATE DATABASE IF NOT EXISTS dbwebb;

-- Välj vilken databas du vill använda
USE skolan;

-- Visa vilka databaser som finns
SHOW DATABASES;

-- Visa vilka databaser som finns
-- som heter något i stil med *skolan*
SHOW DATABASES LIKE "%skolan%";

-- Ta bort en användare
DROP USER IF EXISTS 'user'@'%';
-- Alternate for MariaDB

CREATE USER IF NOT EXISTS 'user'@'%'
    IDENTIFIED BY 'pass';

CREATE USER IF NOT EXISTS 'user'@'localhost'
    IDENTIFIED BY 'pass';

-- Grant the user all privilegies on the database.
GRANT ALL PRIVILEGES
    ON dbwebb.*
    TO 'user'@'%';

GRANT ALL PRIVILEGES
    ON skolan.*
    TO 'user'@'%';
;

GRANT ALL PRIVILEGES
    ON *.*
    TO 'user'@'localhost'
;

FLUSH PRIVILEGES;

/* Change password on MariaDB 10.4+ */
-- ALTER USER 'user'@'localhost' IDENTIFIED BY 'pass';

-- Visa vad en användare kan göra mot vilken databas.
SHOW GRANTS FOR 'user'@'%';
SHOW GRANTS FOR 'user'@'localhost';

-- Visa för nuvarande användare
SHOW GRANTS FOR CURRENT_USER;
