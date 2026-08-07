WITH customer as
(
    SELECT * FROM {{ ref('stg_customers')}}
),
address as
(
    SELECT * FROM {{ ref('stg_address')}}
),
cities as
(
    SELECT * FROM {{ ref('stg_city')}}
),
countries as
(
    SELECT * FROM {{ ref('stg_country')}}
),
final as
(
    SELECT
        {{ dbt_utils.generate_surrogate_key(['c.customer_id']) }} as customer_key,
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        a.address_id,
        a.address,
        a.postal_code,
        ci.city,
        co.country,
        c.create_date
    FROM customer c
    LEFT JOIN address a ON c.address_id = a.address_id
    LEFT JOIN cities ci ON a.city_id = ci.city_id
    LEFT JOIN countries co ON ci.country_id = co.country_id
)
SELECT * FROM final