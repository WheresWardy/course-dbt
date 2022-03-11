{{ config(materialized = 'view') }}

WITH source AS (
    SELECT *
    FROM {{ source('greenery_db', 'orders') }}
),

renamed_recast AS (
    SELECT
        order_id,
        promo_id,
        user_id,
        address_id,
        created_at,
        order_cost,
        shipping_cost,
        order_total,
        tracking_id,
        shipping_service,
        estimated_delivery_at,
        delivered_at,
        status
    FROM source
)

SELECT * FROM renamed_recast
