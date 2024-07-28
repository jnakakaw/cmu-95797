-- only taxi trips are taken into account as bike trips does not have zone column
-- zones with less than 100000 trips
select
    zone as zone,
    count(*) as trips,
from {{ ref('mart__fact_all_taxi_trips') }} as t
join {{ ref('mart__dim_locations') }} as l on t.pulocationid = l.locationid
group by l.zone
having trips < 100000;