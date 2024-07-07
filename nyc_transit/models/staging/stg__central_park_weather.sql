with source as (

    select * from {{ source('main', 'central_park_weather') }}

),

renamed as (

    select
        TRY_CAST(date AS date) as measurement_date,
        TRY_CAST(awnd AS double) as avg_wind_speed,
        TRY_CAST(prcp AS double) as precipitation, 
        TRY_CAST(snow AS double) as snow,
        TRY_CAST(tmax AS int) as max_temp,
        TRY_CAST(tmin AS int) as min_temp,

        from source

)

select distinct * from renamed

-- station and name was removed, as all mesurements were taken from the same station
-- filename column was removed and it is reported here (./data/central_park_weather.csv)