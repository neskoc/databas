#!/usr/bin/env bash
#
# Recreate and reset the database to be as after part II.
#

#
# Load a SQL file into skolan
#
function loadSqlIntoSkolan
{
    echo ">>> $4 ($3)"
#    mysql "-u$1" "-p$2" skolan < "$3" > /dev/null
    if ! mysql "-u$1" "-p$2" skolan < "$3" > /dev/null; then
        echo "The command failed, you may have issues with your SQL code."
        echo "Verify that all SQL commands can be exeucted in sequence in the file:"
        echo " '$3'"
        exit 1
    fi
}

#
# Recreate and reset the database to be as after part II.
#
echo ">>> Reset skolan to after part 3"
loadSqlIntoSkolan "root" "" "setup.sql" "Initiera database och användare"
loadSqlIntoSkolan "user" "pass" "ddl_all.sql" "Skapa tabeller och vyer"
loadSqlIntoSkolan "user" "pass" "insert.sql" "Insert into larare"
loadSqlIntoSkolan "user" "pass" "dml_update_lonerevision.sql" "Utför lönerevision"

echo ">>> Check larare_pre: Lönesumman = 305000, Kompetens = 8."
mysql -uuser -ppass skolan -e "SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare_pre;"

echo ">>> Check larare: Lönesumman = 330242, Kompetens = 19."
mysql -uuser -ppass skolan -e "SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;"

# Export 
mysql -uuser -ppass skolan -e "SELECT * FROM larare LIMIT 3;" --batch > report.xls

echo "Database backap"
mysqldump -uroot -p skolan > skolan.sql

