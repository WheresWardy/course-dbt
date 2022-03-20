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

stg_orders AS (
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
    FROM {{ ref('stg_orders') }}
),

fact_user_orders AS (
    SELECT
        stg_users.user_id,
        stg_users.first_name,
        stg_users.last_name,
        stg_users.email,
        stg_users.phone_number,
        stg_users.created_at,
        stg_users.updated_at,
        stg_users.address_id,
        stg_orders.order_id,
        stg_orders.promo_id,
        stg_orders.user_id AS orders_user_id,
        stg_orders.address_id AS orders_address_id,
        stg_orders.created_at AS orders_created_at,
        stg_orders.order_cost,
        stg_orders.shipping_cost,
        stg_orders.order_total,
        stg_orders.tracking_id,
        stg_orders.shipping_service,
        stg_orders.estimated_delivery_at,
        stg_orders.delivered_at,
        stg_orders.status
    FROM stg_users
    LEFT JOIN stg_orders ON stg_orders.user_id = stg_users.user_id
)

SELECT * FROM fact_user_orders
