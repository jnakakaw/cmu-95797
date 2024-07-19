with all_trips as
(
select
    weekday(pickup_datetime) as weekday,
    count(*) as trips
    from {{ ref('mart__fact_all_taxi_trips') }} as t
    where pulocationid is not null and dolocationid is not null
    group by all
),

inter_borough as 
(
select
    weekday(pickup_datetime) as weekday,
    count(*) as trips
from {{ ref('mart__fact_all_taxi_trips') }} as t
join {{ ref('mart__dim_locations') }} as pl on t.pulocationid = pl.locationid
join {{ ref('mart__dim_locations') }} as dl on t.dolocationid = pl.locationid
where pl.borough != dl.borough
group by all
)

select all_trips.weekday, 
       all_trips.trips as all_trips,
       inter_borough.trips as inter_borough_trips,
       inter_borough.trips / all_trips.trips as percent_inter_borough
from all_trips
join inter_borough on (all_trips.weekday = inter_borough.weekday); 