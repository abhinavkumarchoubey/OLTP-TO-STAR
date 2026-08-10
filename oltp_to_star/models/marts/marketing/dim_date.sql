WITH sate_spine as (
    {{dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2005-01-01' as date)",
        end_date="cast('2006-12-31' as date)"
    )}}
),
final as (
    SELECT
        cast(date_day as date) as date_day,
        {{ dbt_utils.generate_surrogate_key(['date_day']) }} as date_key,
        extract(year from date_day) as year,
        extract(month from date_day) as month,
        extract(day from date_day) as day,
        extract(dow from date_day) as date_of_week,
        to_char(date_day, 'Day') as day_name,
        to_char(date_day, 'Month') as month_name
    FROM sate_spine s
)
SELECT * FROM final