{{ config(materialized = 'view') }}

WITH source AS (
    SELECT *
    FROM {{ source('greenery_db', 'order_items') }}
),

renamed_recast AS (
    SELECT
        order_id,
        product_id,
        quantity
    FROM source
)

SELECT * FROM renamed_recast
