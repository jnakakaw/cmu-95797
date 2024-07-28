-- last trip in each zone will get null as time_delta_next_trip
-- avg_time_delta_next_trip in seconds
with trip_delta_table as (
    select
        borough as borough,
        zone as zone,
        pickup_datetime,
        datediff('seconds', pickup_datetime, LEAD(pickup_datetime, 1) 
            over (partition by borough, zone order by pickup_datetime))
                as time_delta_next_trip
    from {{ ref('mart__fact_all_taxi_trips') }} as t
    join {{ ref('mart__dim_locations') }} as l on t.pulocationid = l.locationid
    order by borough, zone, pickup_datetime
)

select
    borough as borough,
    zone as zone,
    AVG(time_delta_next_trip) as avg_time_delta_next_trip
from trip_delta_table
group by borough, zone
order by avg_time_delta_next_trip;
