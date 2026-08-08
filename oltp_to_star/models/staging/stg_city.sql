SELECT
    city_id,
    city as city_name,
    country_id,
    last_update
FROM {{ source('public', 'city') }}