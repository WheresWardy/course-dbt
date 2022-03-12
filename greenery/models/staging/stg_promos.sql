{{ config(materialized = 'view') }}

WITH source AS (
    SELECT *
    FROM {{ source('greenery_db', 'promos') }}
),

renamed_recast AS (
    SELECT
        promo_id,
        discount,
        status
    FROM source
)

SELECT * FROM renamed_recast
