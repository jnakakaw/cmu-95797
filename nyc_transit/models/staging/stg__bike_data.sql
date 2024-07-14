with source as (

    select * from {{ source('main', 'bike_data') }}

),

renamed_bike as (

    select
        TRY_CAST(bikeid AS int) as bike_id,
        ride_id,
        rideable_type,
        usertype as user_type,
        TRY_CAST("birth year" AS int) as birth_year,
        TRY_CAST(gender AS int) as gender,
        TRY_CAST(starttime AS datetime) as start_time,
        TRY_CAST(stoptime AS datetime) as stop_time,
        TRY_CAST(datediff('second', start_time, stop_time) AS int) as trip_duration,
        TRY_CAST("start station id" AS int) as start_station_id,
        "start station name" as start_station_name,
        TRY_CAST("start station latitude" AS double) as start_station_latitude,
        TRY_CAST("start station longitude" AS double) as start_station_longitude,
        TRY_CAST("end station id" AS int) as end_station_id,
        "end station name" as end_station_name,
        TRY_CAST("end station latitude" AS double) as end_station_latitude,
        TRY_CAST("end station longitude" AS double) as end_station_longitude,
        filename

        from source
        -- drop rows with null bike_id and trip times less than 0 and greater than 8 hours
        where bikeid is not null and trip_duration >= 0 and trip_duration <= 28800 

),

renamed_ride as (

    select
        TRY_CAST(bikeid AS int) as bike_id,
        ride_id,
        rideable_type,
        member_casual as user_type,
        TRY_CAST("birth year" AS int) as birth_year,
        TRY_CAST(gender AS int) as gender,
        TRY_CAST(started_at AS date) as start_time,
        TRY_CAST(ended_at AS date) as stop_time,
        TRY_CAST(datediff('second', start_time, stop_time) AS int) as trip_duration,
        -- intermediate points removed from station ids
        TRY_CAST(REPLACE(start_station_id, '.', '') AS int) as start_station_id,
        start_station_name,
        TRY_CAST(start_lat AS double) as start_station_latitude,
        TRY_CAST(start_lng AS double) as start_station_longitude,
        -- intermediate points removed from station ids
        TRY_CAST(REPLACE(end_station_id, '.', '') AS int) as end_station_id,
        end_station_name,
        TRY_CAST(end_lat AS double) as end_station_latitude,
        TRY_CAST(end_lng AS double) as end_station_longitude,
        filename

        from source
        -- drop rows with null ride_id and trip times less than 0 and greater than 8 hours
        where ride_id is not null and trip_duration >= 0 and trip_duration <= 28800 

)

-- new and old bike ride tables are unioned
select distinct * from renamed_bike
UNION
select distinct * from renamed_ride
