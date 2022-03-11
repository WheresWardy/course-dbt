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
        event_type,
        page_url,
        created_at,
        order_id,
        product_id
    FROM source
)

SELECT * FROM renamed_recast
