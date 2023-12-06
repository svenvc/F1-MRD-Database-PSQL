# F1-MRD-Database-PSQL
Ergast Formula One Motor Racing Data Database for PostgreSQL


## Introduction

The Ergast Developer API is an experimental web service which provides
a historical record of motor racing data for non-commercial purposes.

The API provides data for the Formula One series,
from the beginning of the world championships in 1950.

http://ergast.com/mrd/

PostgreSQL database created using database images.

- http://ergast.com/mrd/db/
- http://ergast.com/docs/f1db_user_guide.txt
- http://ergast.com/images/ergast_db.png


## Start with the MySQL dump

http://ergast.com/downloads/f1db.sql.gz


## Install MySQL and import full image

```
$ mysql -u root
mysql> create database f1db
mysql> source f1db.sql
```


## Export from MySQL

```
$ mysqldump -u root -p --compatible=ansi --skip-quote-names --no-data f1db > f1db_schema.sql
```

Edited CREATE TABLE statements for compatibility.
This schema can be found in this repository as [f1db_schema.sql](f1db_schema.sql)

```
$ mysqldump -u root -p --compatible=ansi --skip-quote-names --no-create-info --skip-extended-insert --skip-add-locks --skip-add-drop-table f1db > f1db_data.sql
```

Manually fixed a couple of embedded single quotes (\' -> '') in INSERT statements


## Install PostgreSQL and import

```
$ psql postgresql://username:password@localhost:5432/f1db

$ psql -h localhost -U username -d f1db -p 5432 < f1db/f1db_schema.sql

$ psql -h localhost -U username -d f1db -p 5432 < f1db/f1db_data.sql &> /tmp/output.log
```
