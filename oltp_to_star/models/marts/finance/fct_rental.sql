WITH rentals as
(
    SELECT * FROM {{ ref('stg_rental')}}
),
payments as
(
    SELECT * FROM {{ ref('stg_payment')}}
),
dim_customer as
(
    SELECT * FROM {{ ref('dim_customer')}}
),
dim_date as
(
    SELECT * FROM {{ ref('dim_date')}}
),
dim_film as
(   
    SELECT * FROM {{ ref('dim_film')}}
),
dim_store as    
(
    SELECT * FROM {{ ref('dim_store')}}
),
dim_staff as
(
    SELECT * FROM {{ ref('dim_staff')}}
),
inventory as
(
    SELECT * FROM {{ ref('stg_inventory')}}
),
final as
(
    SELECT 
        r.rental_id,
        c.customer_key,
        d.date_key AS rental_date_key,
        f.film_key,
        s.store_key,
        st.staff_key,
        LOWER(rental_period) AS rental_start_date,
        UPPER(rental_period) AS rental_end_date,
        EXTRACT(DAY FROM (UPPER(rental_period) - LOWER(rental_period))) AS rental_duration_days,
        p.payment_amount AS rental_amount
    FROM rentals r
    LEFT JOIN payments p ON r.rental_id = p.rental_id
    LEFT JOIN dim_customer c ON r.customer_id = c.customer_id
    LEFT JOIN dim_date d ON DATE(LOWER(r.rental_period)) = d.date_day
    LEFT JOIN dim_staff st ON r.staff_id = st.staff_id
    LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
    LEFT JOIN dim_film f ON i.film_id = f.film_id
    LEFT JOIN dim_store s ON i.store_id = s.store_id
)
SELECT * FROM final