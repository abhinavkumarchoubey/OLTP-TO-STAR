SELECT
    staff_id,
    first_name as staff_first_name,
    last_name as staff_last_name,
    email as staff_email,
    address_id,
    store_id,
    active,
    username as staff_username,
    password
FROM {{ source('public', 'staff') }}