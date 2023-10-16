with source as (
    select * from {{ source('jaffle_shop', 'customers') }}
),

customers as (
    SELECT
        id as customer_id,
        first_name,
        last_name
    FROM
        source
)

select * from customers