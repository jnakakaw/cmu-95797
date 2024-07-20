-- count of total bike trips and total trip time (seconds) by weekday
-- weekday day is taken from bike trip start date and time
select
    weekday(started_at_ts) as weekday,
    count(*) as total_trips,
    sum(duration_sec) as total_trip_duration_secs
from {{ ref('mart__fact_all_bike_trips') }}
group by all;