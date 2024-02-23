{{ config(materialized='table') }}
 
with fhv_tripdata as 
(
  select *
  from {{ source('staging','fhv_tripdata') }}
)
select

    dispatching_base_num,
    
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropoff_datetime,
    
    {{ dbt.safe_cast("PUlocationID", api.Column.translate_type("float")) }} as PUlocationID,
    {{ dbt.safe_cast("DOlocationID", api.Column.translate_type("float")) }} as DOlocationID,
    {{ dbt.safe_cast("SR_Flag", api.Column.translate_type("float")) }} as SR_Flag,
    
    Affiliated_base_number

from

    fhv_tripdata

-- dbt build --select <model.sql> --vars '{'is_test_run: false}'
{% if var('is_test_run', default=true) %}

{% endif %}