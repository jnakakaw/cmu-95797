.echo on
.schema
-- Write Tables
.output ./answers/raw_schemas.txt
SHOW TABLES;
DESCRIBE yellow_tripdata;
DESCRIBE green_tripdata;
DESCRIBE fhvhv_tripdata;
DESCRIBE fhv_tripdata;
DESCRIBE fhv_bases;
DESCRIBE central_park_weather;
DESCRIBE bike_data;
.output