with source as (

    select * from {{ source('main', 'central_park_weather') }}

),

renamed as (

    select
        --station,
        --name,
        TRY_CAST(date AS date) as date,
        TRY_CAST(awnd AS double) as awnd,
        TRY_CAST(prcp AS double) as prcp, 
        TRY_CAST(snow AS double) as snow,
        TRY_CAST(tmax AS int) as tmax,
        TRY_CAST(tmin AS int) as tmin,
        --filename

        from source

)

select * from renamed