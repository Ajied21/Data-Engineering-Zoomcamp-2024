{{ config(materialized='table') }}

with fhv_tripdata as (
    select *
    from {{ ref('stg_fhv_tripdata') }}
), 
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select
    fhv_tripdata.dispatching_base_num, 
    fhv_tripdata.pickup_datetime,
    fhv_tripdata.dropOff_datetime,
    fhv_tripdata.PUlocationID,
    fhv_tripdata.DOlocationID,
    fhv_tripdata.SR_Flag,
    fhv_tripdata.Affiliated_base_number,
    dim_zones.locationid,
    dim_zones.borough,
    dim_zones.zone,
    dim_zones.service_zone
from 
    fhv_tripdata
inner join 
    dim_zones
on 
    fhv_tripdata.PUlocationID = dim_zones.locationid;    