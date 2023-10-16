with customers as (
    select * from {{ ref('stg_customers') }}
    
),

orders as (
    select * from {{ ref ('stg_orders') }}
),

customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,

    from orders
    group by 1
),

order_amounts as (
    select * from {{ ref('fct_orders') }}
),

final as (
    SELECT
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        sum(order_amounts.amount) as lifetime_value
    FROM
        customers
    left join
        customer_orders using (customer_id)
    inner join
        order_amounts using (customer_id)
    group by 1, 2, 3, 4, 5, 6
)

select * from final