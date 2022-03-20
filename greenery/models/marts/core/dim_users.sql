{{ config(materialized='table') }}

WITH stg_users AS (
    SELECT
        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        created_at,
        updated_at,
        address_id
    FROM {{ ref('stg_users') }}
),

stg_addresses AS (
    SELECT
        address_id,
        address,
        zipcode,
        state,
        country
    FROM {{ ref('stg_addresses') }}
),

dim_users AS (
    SELECT
        stg_users.user_id,
        stg_users.first_name,
        stg_users.last_name,
        CONCAT(stg_users.first_name, ' ', stg_users.last_name) AS full_name,
        stg_users.email,
        stg_users.phone_number,
        stg_users.created_at,
        stg_users.updated_at,
        stg_users.address_id AS user_address_id,
        stg_addresses.address_id,
        stg_addresses.address,
        stg_addresses.zipcode,
        stg_addresses.state,
        stg_addresses.country
    FROM stg_users
    LEFT JOIN stg_addresses ON stg_users.address_id = stg_addresses.address_id
)

SELECT * FROM dim_users
