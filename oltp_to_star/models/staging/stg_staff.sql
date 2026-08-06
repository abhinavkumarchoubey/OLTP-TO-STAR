SELECT
    staff_id,
    first_name,
    last_name,
    email,
    address_id,
    store_id,
    active,
    username,
    password
FROM {{ source('public', 'staff') }}