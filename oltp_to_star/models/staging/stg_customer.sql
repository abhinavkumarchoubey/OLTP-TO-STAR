SELECT 
    customer_id,
    store_id,
    first_name as customer_first_name,
    last_name as customer_last_name,
    email as customer_email,
    address_id,
    activebool as active_bool,
    create_date,
    last_update
FROM {{ source('public', 'customer') }}