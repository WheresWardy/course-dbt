{{ config(materialized = 'view') }}

WITH source AS (
    SELECT *
    FROM {{ source('greenery_db', 'products') }}
),

renamed_recast AS (
    SELECT
        product_id,
        name,
        price,
        inventory
    FROM source
)

SELECT * FROM renamed_recast
