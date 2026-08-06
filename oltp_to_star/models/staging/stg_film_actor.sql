SELECT
    actor_id,
    film_id
FROM {{ source('public', 'film_actor') }}