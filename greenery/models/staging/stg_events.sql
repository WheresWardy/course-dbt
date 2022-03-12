{{ config(materialized = 'view') }}

WITH source AS (
    SELECT *
    FROM {{ source('greenery_db', 'events') }}
),

renamed_recast AS (
    SELECT
        event_id,
        session_id,
        user_id,
        page_url,
        created_at,
        event_type,
        order_id,
        product_id
    FROM source
)

SELECT * FROM renamed_recast
