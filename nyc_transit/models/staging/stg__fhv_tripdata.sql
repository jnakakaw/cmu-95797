with source as (

    select * from {{ source('main', 'fhv_tripdata') }}

),

renamed as (

    select
        dispatching_base_num as dispatching_base_id,
        pickup_datetime,
        dropOff_datetime as dropoff_datetime,
        PUlocationID as pickup_location_id,
        DOlocationID as dropoff_location_id,
        CASE 
            WHEN LEN(LEFT(TRIM(UPPER(Affiliated_base_number)), 6)) != 6 THEN null
            WHEN LEFT(TRIM(UPPER(Affiliated_base_number)), 1) != 'B' THEN null 
            ELSE REPLACE(LEFT(TRIM(UPPER(Affiliated_base_number)), 6), 'O', '0')
        END as affiliated_base_id

        from source

)

select distinct * from renamed

-- filename column was removed and it is reported here (./data/taxi/fhv_tripdata.parquet)
-- SR_Flag column was removed as all its values are nulls
-- affiliated_base_id values not strating with B and lenth smaller than 6 are replaced with nulls
-- affiliated_base_id values O are replaced with 0, assuming a capturing error