with source as (

    select * from {{ source('main', 'fhv_bases') }}

),

renamed as (

    select
        {{ clean_base_ids("base_number") }} as base_id,
        base_name,
        dba,
        dba_category,
        filename

        from source

)

select distinct * from renamed
