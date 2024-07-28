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
8. dbt compile 
9. cd ..
10. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/bike_trips_and_duration_by_weekday.sql"
11. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/inter_borough_taxi_trips_by_weekday.sql"
12. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/taxi_trips_ending_at_airport.sql"
13. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/trips_duration_grouped_by_borough_zone.sql"
14. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/taxi_trips_no_valid_pickup_location_id.sql"
15. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/zones_with_less_than_100k_trips.sql"
16. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/pivot_trips_by_borough.sql"
17. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/yellow_taxi_fare_comparison.sql"
18. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/dedupe.sql"
19. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/seven_day_moving_average_prcp.sql"
20. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/seven_day_moving_aggs_weather.sql"
21. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/average_time_between_pickups.sql"
22. duckdb nyc_transit.db -s ".read ./nyc_transit/target/compiled/nyc_transit/analyses/days_before_precip_more_bike_trips.sql"