{{ config(materialized='table') }}

WITH source_data AS (
    select * from `dbt-tutorial.jaffle_shop.customers`
)

SELECT *
FROM source_data