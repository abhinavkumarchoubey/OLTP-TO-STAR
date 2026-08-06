SELECT
    inventory_id,
    film_id,
    store_id
FROM {{ source('public', 'inventory') }}