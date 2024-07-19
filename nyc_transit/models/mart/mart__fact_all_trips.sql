with trips_renamed as 
(
    -- UNION ALL will use the column name from the first select
    select 'bike' as type, start_time as started_at_ts, stop_time as ended_at_ts
    from {{ ref('stg__bike_data') }}
    union all
    select 'fhv' as type, pickup_datetime, dropoff_datetime
    from {{ ref('stg__fhv_tripdata') }}
    union all
    select 'fhvhv' as type, pickup_datetime, dropoff_datetime
    from {{ ref('stg__fhvhv_tripdata') }}
    union all
    select 'green' as type, pickup_datetime, dropoff_datetime
    from {{ ref('stg__green_tripdata') }}
    union all
    select 'yellow' as type, pickup_datetime, dropoff_datetime
    from {{ ref('stg__yellow_tripdata') }}
)

select
    type,
    started_at_ts,
    ended_at_ts,
    datediff('minute', started_at_ts, ended_at_ts) as duration_min,
    datediff('second', started_at_ts, ended_at_ts) as duration_sec,
from trips_renamed