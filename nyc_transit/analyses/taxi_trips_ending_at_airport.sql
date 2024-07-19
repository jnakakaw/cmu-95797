select
    count(*) as total_trips_ending_at_airport
from {{ ref('mart__fact_all_taxi_trips') }}
join {{ ref('mart__dim_locations') }} on dolocationid = locationid
where service_zone = 'Airports' or service_zone = 'EWR';