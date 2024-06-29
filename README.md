# cmu-95797-23m6

week #1 Assignment

Steps to follow, run the following command in terminal, make sure CMU-95797 is your current directory:

1. duckdb main.db -s ".read ./sql/ingest.sql"
2. duckdb main.db -s ".read ./sql/dump_raw_schemas.sql"
3. python scripts/dump_raw_counts.py
