with source as (

    select * from {{ source('main', 'fhvhv_tripdata') }}

),

renamed as (

    select
        hvfhs_license_num,
        dispatching_base_num as dispatching_base_id,
        originating_base_num as originating_base_id,
        request_datetime,
        on_scene_datetime,
        pickup_datetime,
        dropoff_datetime,
        PULocationID as pickup_location_id,
        DOLocationID as dropoff_location_id,
        trip_miles,
        trip_time,
        base_passenger_fare,
        tolls as toll_charges,
        bcf as black_card_funds,
        sales_tax,
        congestion_surcharge,
        airport_fee,
        tips as tip_charges,
        driver_pay,
        shared_request_flag as shared_request,
        shared_match_flag as shared_match,
        access_a_ride_flag as metro_transportation,
        wav_request_flag as wheelchair_accesible_request,
        wav_match_flag as wheelchair_accesible_match

        from source

)

select distinct * from renamed

-- filename column was removed and it is reported here (./data/taxi/fhvhv_tripdata.parquet)