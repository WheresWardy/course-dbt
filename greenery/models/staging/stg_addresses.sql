{{ config(materialized = 'view') }}

WITH source AS (
    SELECT *
    FROM {{ source('greenery_db', 'addresses') }}
),

renamed_recast AS (
    SELECT
        address_id,
        address,
        zipcode,
        state,
        country
    FROM source
)

SELECT * FROM renamed_recast
