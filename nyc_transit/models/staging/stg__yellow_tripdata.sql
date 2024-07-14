with source as (

    select * from {{ source('main', 'yellow_tripdata') }}

),

renamed as (

    select
        VendorID as vendor_id,
        tpep_pickup_datetime as pickup_datetime,
        tpep_dropoff_datetime as dropoff_datetime,
        passenger_count,
        trip_distance,
        RatecodeID as ratecode_id,
        {{flag_to_bool("store_and_fwd_flag")}} as store_and_fwd,
        PULocationID as pickup_location_id,
        DOLocationID as dropoff_location_id,
        payment_type,
        fare_amount as fare_charges,
        extra as extra_charges,
        mta_tax,
        tip_amount as tip_charges,
        tolls_amount as toll_charges,
        improvement_surcharge,
        total_amount,
        congestion_surcharge,
        airport_fee as airport_charges,
        filename

        from source
            WHERE tpep_pickup_datetime < TIMESTAMP '2022-12-31' -- drop rows in the future
                AND trip_distance >= 0 -- drop negative trip_distance

)

select distinct * from renamed

-- filename column was removed and it is reported here (./data/taxi/yellow_tripdata.parquet)
-- ehail_fee column was removed, as all values are null