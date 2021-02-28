#!/usr/bin/env bash
#
# Recreate and reset the database to be as after part I.
#
echo ">>> Reset skolan to after part 1"
echo ">>> Recreate the database (as root)"
mariadb -uroot -p < setup.sql > /dev/null

bash reset_pre_lonerevision.bash

# Make copy of larare-table
file="ddl_copy.sql"
echo ">>> Copy table ($file)"
mariadb -uuser -ppass skolan < $file  > /dev/null

file="dml_update_lonerevision.sql"
echo ">>> Utför lönerevision ($file)"
mariadb -uuser -ppass skolan < $file  > /dev/null

echo ">>> Check Lönesumman = 330242, Kompetens = 19."
mariadb  -uuser -ppass skolan -e "SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;"

file="dml_view.sql"
echo ">>> Add view ($file)"
mariadb -uuser -ppass skolan < $file  > /dev/null
