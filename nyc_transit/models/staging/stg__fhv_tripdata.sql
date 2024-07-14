with source as (

    select * from {{ source('main', 'fhv_tripdata') }}

),

renamed as (

    select
        {{ clean_base_ids("dispatching_base_num") }} as dispatching_base_id,
        pickup_datetime,
        dropOff_datetime as dropoff_datetime,
        PUlocationID as pickup_location_id,
        DOlocationID as dropoff_location_id,
        {{ clean_base_ids("Affiliated_base_number") }} as affiliated_base_id,
        filename

        from source

)

select distinct * from renamed

-- filename column was removed and it is reported here (./data/taxi/fhv_tripdata.parquet)
-- SR_Flag column was removed as all its values are nulls