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
        {{ flag_to_bool("shared_request_flag") }} as shared_request,
        {{ flag_to_bool("shared_match_flag") }} as shared_match,
        {{ flag_to_bool("access_a_ride_flag") }} as metro_transportation,
        {{ flag_to_bool("wav_request_flag") }} as wheelchair_accesible_request,
        {{ flag_to_bool("wav_match_flag") }} as wheelchair_accesible_match,
        filename

        from source
            WHERE trip_time >= 0 and trip_time < 28800 -- drop negative trip_time and trips longer than 8 hours

)

select distinct * from renamed
