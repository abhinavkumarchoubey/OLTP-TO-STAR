SELECT
    country_id,
    country as country_name,
    last_update
FROM {{ source('public', 'country') }}