
WITH users AS (
    SELECT
        user_id AS user_guid,
        first_name,
        last_name,
        email,
        phone_number,
        created_at,
        updated_at,
        address_id
    FROM {{ source('greenery_db', 'users') }}
)

SELECT *
FROM users