select
    distinct
    start_station_id as station_id,
    start_station_name as station_name,
    start_station_latitude as station_lat,
    start_station_longitude as station_lng
from {{ ref('stg__bike_data') }}
union
select
    distinct
    end_station_id as station_id,
    end_station_name as station_name,
    end_station_latitude as station_lat,
    end_station_longitude as station_lng
from {{ ref('stg__bike_data') }}