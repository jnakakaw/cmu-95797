create table yellow_tripdata as select * from
read_parquet('./data/taxi/yellow_tripdata*.parquet',
union_by_name=True, filename=True);
