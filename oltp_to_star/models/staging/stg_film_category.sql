SELECT
    film_id,
    category_id
FROM {{ source('public', 'film_category') }}