WITH staffs as
(
    SELECT * FROM {{ ref('stg_staff')}}
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
final as
(   
    SELECT
        {{ dbt_utils.generate_surrogate_key(['st.staff_id']) }} as staff_key,
        st.staff_id,
        st.staff_first_name,
        st.staff_last_name,
        st.address_id,
        a.address_line1,
        a.address_line2,
        a.postal_code,
        c.city_name,
        co.country_name,
        st.staff_email,
        st.store_id,
        st.active,
        st.staff_username
    FROM staffs st  
    LEFT JOIN addresses a ON st.address_id = a.address_id
    LEFT JOIN cities c ON a.city_id = c.city_id
    LEFT JOIN countries co ON c.country_id = co.country_id
)
SELECT * FROM final