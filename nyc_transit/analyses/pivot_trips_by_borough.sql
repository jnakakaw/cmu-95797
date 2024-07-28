pivot {{ ref('mart__fact_trips_by_borough') }}
on borough
using sum(trips) as trips;