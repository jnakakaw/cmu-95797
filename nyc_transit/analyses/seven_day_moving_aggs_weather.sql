select measurement_date,
    precipitation,
    MIN(precipitation) over seven_days as min_precipitation,
    MAX(precipitation) over seven_days as max_precipitation,
    AVG(precipitation) over seven_days as avg_precipitation,
    SUM(precipitation) over seven_days as sum_precipitation,
    snow,
    MIN(snow) over seven_days as min_snow,
    MAX(snow) over seven_days as max_snow,
    AVG(snow) over seven_days as avg_snow,
    sum(snow) over seven_days as sum_snow
from {{ ref('stg__central_park_weather') }}
window seven_days as (
    order by measurement_date asc
    range between interval 3 days preceding and
                  interval 3 days following)
order by measurement_date;