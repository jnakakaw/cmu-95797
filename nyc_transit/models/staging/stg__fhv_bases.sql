with source as (

    select * from {{ source('main', 'fhv_bases') }}

),

renamed as (

    select
        base_number as base_id,
        base_name,
        dba,
        dba_category

        from source

)

select distinct * from renamed

-- filename column was removed and it is reported here (./data/fhv_bases.csv)