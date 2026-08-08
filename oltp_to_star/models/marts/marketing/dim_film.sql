WITH films as 
(
    SELECT * FROM {{ ref('stg_film')}}
),
categories as 
(
    SELECT * FROM {{ ref('stg_category')}}
),
film_categories as 
(
    SELECT * FROM {{ ref('stg_film_category')}}
),
languages as 
(
    SELECT * FROM {{ ref('stg_language')}}
),
final as
(
    SELECT
        {{ dbt_utils.generate_surrogate_key(['f.film_id']) }} as film_key,
        f.film_id,
        f.film_title,
        f.film_description,
        f.film_release_year,
        l.language_name as language,
        c.category_name as category,
        f.rental_duration,
        f.rental_rate,
        f.film_length,
        f.replacement_cost,
        f.film_rating,
        f.special_features,
        f.last_update
    FROM films f
    LEFT JOIN languages l ON f.language_id = l.language_id
    LEFT JOIN film_categories fc ON f.film_id = fc.film_id
    LEFT JOIN categories c ON fc.category_id = c.category_id
)
SELECT * FROM final