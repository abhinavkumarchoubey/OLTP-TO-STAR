SELECT
    film_id,
    title as film_title,
    description as film_description,
    release_year as film_release_year,
    language_id,
    rental_duration,
    rental_rate,
    length as film_length,
    replacement_cost,
    rating as film_rating,
    special_features,
    last_update
FROM
    {{ source('public', 'film') }}