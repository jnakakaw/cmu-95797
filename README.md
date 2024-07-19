# cmu-95797-23m6

### Week #3 Assignment
### Name: Jinzo Nakakawa

Make sure you have duckdb and dbt installed in your enviroment

Steps to follow, run the following commands in terminal, make sure CMU-95797 is your current directory:

1. duckdb nyc_transit.db -s ".read ./sql/ingest.sql"
2. duckdb nyc_transit.db -s ".read ./sql/dump_raw_schemas.sql"
3. python scripts/dump_raw_counts.py
4. cd nyc_transit
5. dbt build
6. dbt docs generate
7. dbt docs serve 
8. cd ..
9. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/bike_trips_and_duration_by_weekday.sql"
10. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/inter_borough_taxi_trips_by_weekday.sql"
11. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/taxi_trips_ending_at_airport.sql"