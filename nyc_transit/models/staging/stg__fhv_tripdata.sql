with source as (

    select * from {{ source('main', 'fhv_tripdata') }}

),

renamed as (

    select
        dispatching_base_num,
        pickup_datetime,
        dropOff_datetime as dropoff_datetime,
        PUlocationID as pickup_location_id,
        DOlocationID as dropoff_location_id,
        --SR_Flag as shared_ride,
        Affiliated_base_number as affiliated_base_number

        from source

)

select * from renamed