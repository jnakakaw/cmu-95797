select
    vendor_id,
    pickup_datetime,
    borough,
    zone,
    AVG(fare_charges) over (partition by borough) as borough_avg_fare,
    AVG(fare_charges) over (partition by borough, zone) as zone_avg_fare,
    AVG(fare_charges) over () as overall_avg_fare
from {{ ref('stg__yellow_tripdata') }} as t
join {{ ref('mart__dim_locations') }} as l on t.pickup_location_id = l.locationid;