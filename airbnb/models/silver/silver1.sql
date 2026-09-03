{{ config(materialized='table') }}

select *
from {{ ref('bronze_listings') }}
