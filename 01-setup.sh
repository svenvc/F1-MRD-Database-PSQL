#!/bin/bash
set -e

export PGPASSWORD=tiger

BASE_URL=https://github.com/svenvc/F1-MRD-Database-PSQL/raw/main

echo Processing $BASE_URL/f1db_dump.sql.bz2

curl -s -L $BASE_URL/f1db_dump.sql.bz2 | bunzip2 | psql -U scott -f - f1db

echo Processing $BASE_URL/f1db_constraints.sql

curl -s -L $BASE_URL/f1db_constraints.sql | psql -U scott -f - f1db
 
