.echo on
.schema

-- Import Tables
create table yellow_tripdata as select * from
read_parquet('./data/taxi/yellow_tripdata*.parquet',
union_by_name=True, filename=True);
create table green_tripdata as select * from
read_parquet('./data/taxi/green_tripdata*.parquet',
union_by_name=True, filename=True);
create table fhvhv_tripdata as select * from
read_parquet('./data/taxi/fhvhv_tripdata*.parquet',
union_by_name=True, filename=True);
create table fhv_tripdata as select * from
read_parquet('./data/taxi/fhv_tripdata*.parquet',
union_by_name=True, filename=True);
create table fhv_bases as select * from
read_csv('./data/fhv_bases.csv');
create table central_park_weather as select * from
read_csv('./data/central_park_weather.csv');
create table bike_data as select * from
read_csv('./data/citibike-tripdata.csv.gz');
