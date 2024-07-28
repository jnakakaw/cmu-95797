-- Average trip duration in seconds
-- only taxi trips are taken into account as bike trips does not have borough column
select
    borough as borough,
    zone as zone,
    count(*) as trips,
    avg(duration_sec) as average_trip_duaration
from {{ ref('mart__fact_all_taxi_trips') }} as t
join {{ ref('mart__dim_locations') }} as l on t.pulocationid = l.locationid
group by l.borough, l.zone;