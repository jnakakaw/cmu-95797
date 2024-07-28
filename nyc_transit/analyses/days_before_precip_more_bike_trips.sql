-- logic flags added to weather table
-- preceding_weather_flag: indentifies days that preceeds rainy or snowy days, 
-- but there was no rain or snow during these days
-- weather_flag: indentifies days with ray or snow 
with weather_events as 
(
    select 
        measurement_date,
        precipitation,
        snow,
        case 
            when 
                (LEAD(precipitation, 1) over (order by measurement_date) > 0
                or LEAD(snow, 1) over (order by measurement_date) > 0)
                and precipitation = 0
                and snow = 0
                then TRUE
            else FALSE end
                as preceding_weather_flag,
        case 
            when
                precipitation > 0
                or snow > 0
                then TRUE
            else FALSE end
                as weather_flag
    from {{ ref('stg__central_park_weather') }}
    order by measurement_date
),

-- count of bike trips by day
bike_trips as
(
    select 
        count(*) as bike_trips,
        TRY_CAST(started_at_ts as date) as trip_date
    from {{ ref('mart__fact_all_bike_trips') }}
    group by trip_date
)

-- group by preceding_weather_flag and weather_flag logic flags
-- avg bike trips are calculated
select
    case
        when weather_flag = TRUE then 'Rainy or snowy day'
        when preceding_weather_flag = TRUE then 'Preciding Rainy or snowy day'
        else 'NA' end
            as weather_criteria, 
    AVG(bike_trips) as avg_bike_trips
from bike_trips as bt
join weather_events as we on bt.trip_date = we.measurement_date
group by preceding_weather_flag, weather_flag
having weather_flag = TRUE or preceding_weather_flag = TRUE;
