# cmu-95797-23m6

Week #1 Assignment

Make sure you have duckdb and dbt installed in your enviroment

Steps to follow, run the following commands in terminal, make sure CMU-95797 is your current directory:

1. duckdb main.db -s ".read ./sql/ingest.sql"
2. duckdb main.db -s ".read ./sql/dump_raw_schemas.sql"
3. python scripts/dump_raw_counts.py
4. cd nyc_transit
5. dbt run
