#!/bin/bash
set -e

export PGPASSWORD=tiger

curl -s -L https://github.com/svenvc/F1-MRD-Database-PSQL/raw/main/f1db_dump.sql.bz2 | bunzip2 | psql -U scott -f - f1db

curl -s -L https://github.com/svenvc/F1-MRD-Database-PSQL/raw/main/f1db_constraints.sql | psql -U scott -f - f1db
 
