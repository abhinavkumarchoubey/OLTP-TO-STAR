SELECT
    language_id,
    name language_name
FROM {{ source('public', 'language') }}