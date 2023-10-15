with payments as (
    select 
        id as payment_id,
        orderid as order_id,
        amount,
    from `dbt-tutorial.stripe.payment`
)

select * from payments