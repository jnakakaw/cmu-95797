select 
    count(*) as trips_no_valid_pulocation_id
from {{ ref('mart__fact_all_taxi_trips') }} as t
left join {{ ref('mart__dim_locations') }} as l on t.pulocationid = l.locationid
where l.locationid is null;