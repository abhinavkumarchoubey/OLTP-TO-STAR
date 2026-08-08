SELECT
    category_id,
    name as category_name
FROM {{ source('public', 'category') }}