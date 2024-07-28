-- if a lag or lead value does not exist, this is replaced with the current precipitation value
select measurement_date,
    precipitation,
    (LAG(precipitation, 3, precipitation) 
        over (order by measurement_date) + 
    LAG(precipitation, 2, precipitation) 
        over (order by measurement_date) + 
    LAG(precipitation, 1, precipitation)
        over (order by measurement_date) +
    precipitation +
    LEAD(precipitation, 1, precipitation) 
        over (order by measurement_date) + 
    LEAD(precipitation, 2, precipitation) 
        over (order by measurement_date) + 
    LEAD(precipitation, 3, precipitation)
        over (order by measurement_date)) / 7
        as precipitation_moving_avg
from {{ ref('stg__central_park_weather') }}
order by measurement_date;