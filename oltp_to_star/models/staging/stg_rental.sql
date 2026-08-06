SELECT
    rental_id,
    inventory_id,
    customer_id,
    staff_id,
    rental_period
FROM {{ source('public', 'rental') }}