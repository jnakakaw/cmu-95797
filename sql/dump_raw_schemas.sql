.echo on
.schema
-- Write Tables
.output ./answers/raw_schemas.txt
DESCRIBE yellow_tripdata;
DESCRIBE green_tripdata;
DESCRIBE fhvhv_tripdata;
DESCRIBE fhv_tripdata;
DESCRIBE fhv_bases;
DESCRIBE central_park_weather;
DESCRIBE bike_data;
.output
-- Delete Tables
DROP TABLE yellow_tripdata;
DROP TABLE green_tripdata;
DROP TABLE fhvhv_tripdata;
DROP TABLE fhv_tripdata;
DROP TABLE fhv_bases;
DROP TABLE central_park_weather;
DROP TABLE bike_data;