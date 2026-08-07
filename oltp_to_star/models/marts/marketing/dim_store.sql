WITH stores as
(
    SELECT * FROM {{ ref('stg_store')}}
),
addresses as
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
staffs as
(
    SELECT * FROM {{ ref('stg_staff')}}
),
final as
(   
    SELECT
        {{ dbt_utils.generate_surrogate_key(['s.store_id']) }} as store_key,
        s.store_id,
        s.manager_staff_id,
        s.address_id,
        a.address,
        a.postal_code,
        c.city,
        co.country,
        st.first_name || ' ' || st.last_name as manager_name,
        s.last_update
    FROM stores s
    LEFT JOIN addresses a ON s.address_id = a.address_id
    LEFT JOIN cities c ON a.city_id = c.city_id
    LEFT JOIN countries co ON c.country_id = co.country_id
    LEFT JOIN staff st on s.manager_staff_id = st.staff_id
)
SELECT * FROM final