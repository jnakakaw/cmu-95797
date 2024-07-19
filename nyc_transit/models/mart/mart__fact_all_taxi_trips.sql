with trips_renamed as 
(
    -- UNION ALL will use the column name from the first select
    select 'fhv' as type, pickup_datetime, dropoff_datetime, pickup_location_id, dropoff_location_id
    from {{ ref('stg__fhv_tripdata') }}
    union all
    select 'fhvhv' as type, pickup_datetime, dropoff_datetime, pickup_location_id, dropoff_location_id
    from {{ ref('stg__fhvhv_tripdata') }}
    union all
    select 'green' as type, pickup_datetime, dropoff_datetime, pickup_location_id, dropoff_location_id
    from {{ ref('stg__green_tripdata') }}
    union all
    select 'yellow' as type, pickup_datetime, dropoff_datetime, pickup_location_id, dropoff_location_id
    from {{ ref('stg__yellow_tripdata') }}
)

select
    type,
    pickup_datetime,
    dropoff_datetime,
    datediff('minute', pickup_datetime, dropoff_datetime) as duration_min,
    datediff('second', pickup_datetime, dropoff_datetime) as duration_sec,
    pickup_location_id as pulocationid,
    dropoff_location_id as dolocationid
from trips_renamed