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
        store_and_fwd_flag as store_and_fwd,
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
        airport_fee as airport_charges

        from source

)

select * from renamed