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
        TRY_CAST(tripduration AS int) as trip_duration,
        TRY_CAST(starttime AS datetime) as start_time,
        TRY_CAST(stoptime AS datetime) as stop_time,
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
        where bikeid is not null

),

renamed_ride as (

    select
        TRY_CAST(bikeid AS int) as bike_id,
        ride_id,
        rideable_type,
        member_casual as user_type,
        TRY_CAST("birth year" AS int) as birth_year,
        TRY_CAST(gender AS int) as gender,
        TRY_CAST(tripduration AS int) as trip_duration,
        TRY_CAST(started_at AS date) as start_time,
        TRY_CAST(ended_at AS date) as stop_time,
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
        where ride_id is not null

)

-- new and old bike ride tables are unioned
select distinct * from renamed_bike
UNION
select distinct * from renamed_ride
