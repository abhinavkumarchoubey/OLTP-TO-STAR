WITH stores as
(
    SELECT * FROM {{ ref('stg_store')}}
),
addresses as
(
    SELECT * FROM {{ ref('stg_address')}} WHERE is_current = TRUE
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
        a.address_line1,
        a.address_line2,
        a.postal_code,
        c.city_name,
        co.country_name,
        st.staff_first_name || ' ' || st.staff_last_name as manager_name
    FROM stores s
    LEFT JOIN addresses a ON s.address_id = a.address_id
    LEFT JOIN cities c ON a.city_id = c.city_id
    LEFT JOIN countries co ON c.country_id = co.country_id
    LEFT JOIN staffs st on s.manager_staff_id = st.staff_id
)
SELECT * FROM final