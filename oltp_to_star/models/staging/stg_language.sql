SELECT
    language_id,
    name
FROM {{ source('public', 'language') }}