#!/usr/bin/env bash
#
# Recreate and reset the database to be as after part I.
#
echo ">>> Reset skolan to after part 1"
echo ">>> Recreate the database (as root)"
mariadb -uroot -p < setup.sql > /dev/null

file="ddl.sql"
echo ">>> Create tables ($file)"
mariadb -uuser -ppass skolan < $file  > /dev/null

file="dml_insert.sql"
echo ">>> Insert into larare ($file)"
mariadb -uuser -ppass skolan < $file  > /dev/null

file="ddl_migrate.sql"
echo ">>> Alter table larare ($file)"
mariadb -uuser -ppass skolan < $file  > /dev/null

file="dml_update.sql"
echo ">>> Förbered lönerevision, grundlön larare ($file)"
mariadb -uuser -ppass skolan < $file  > /dev/null
