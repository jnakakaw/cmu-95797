with source as (

    select * from {{ source('main', 'green_tripdata') }}

),

renamed as (

    select
        VendorID as vendor_id,
        lpep_pickup_datetime as pickup_datetime,
        lpep_dropoff_datetime as dropoff_datetime,
        {{ flag_to_bool("store_and_fwd_flag") }} as store_and_fwd,
        RatecodeID as ratecode_id,
        PULocationID as pickup_location_id,
        DOLocationID as dropoff_location_id,
        passenger_count,
        trip_distance,
        fare_amount as fare_charges,
        extra as extra_charges,
        mta_tax,
        tip_amount as tip_charges,
        tolls_amount as toll_charges,
        improvement_surcharge,
        total_amount,
        payment_type,
        trip_type,
        congestion_surcharge,
        filename

        from source
            WHERE lpep_pickup_datetime < TIMESTAMP '2022-12-31' -- drop rows in the future
                AND trip_distance >= 0 -- drop negative trip_distance

)

select distinct * from renamed

-- filename column was removed and it is reported here (./data/taxi/green_tripdata.parquet)