{{ config(materialized = 'view') }}

WITH source AS (
    SELECT *
    FROM {{ source('greenery_db', 'superheroes') }}
),

renamed_recast AS (
    SELECT
        id,
        name,
        gender,
        eye_color,
        race,
        hair_color,
        height,
        publisher,
        skin_color,
        alignment,
        weight,
        created_at,
        updated_at
    FROM source
)

SELECT * FROM renamed_recast
