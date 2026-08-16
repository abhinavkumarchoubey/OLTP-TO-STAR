WITH customer as
(
    SELECT * FROM {{ ref('stg_customer')}}
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
        {{ dbt_utils.generate_surrogate_key(['c.customer_id', 'c.dbt_valid_from']) }} as customer_key,
        c.customer_id,
        c.customer_first_name,
        c.customer_last_name,
        c.customer_email,
        a.address_id,
        a.address_line1,
        a.address_line2,
        a.postal_code,
        ci.city_name,
        co.country_name,
        c.create_date
    FROM customer c
    LEFT JOIN address a ON c.address_id = a.address_id
    LEFT JOIN cities ci ON a.city_id = ci.city_id
    LEFT JOIN countries co ON ci.country_id = co.country_id
)
SELECT * FROM final