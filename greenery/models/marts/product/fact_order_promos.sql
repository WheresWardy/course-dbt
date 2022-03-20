{{ config(materialized='table') }}

WITH stg_promos AS (
    SELECT
        promo_id,
        discount,
        status
    FROM {{ ref('stg_promos') }}
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


fact_order_promos AS (
    SELECT
        stg_promos.promo_id,
        stg_promos.discount,
        stg_promos.status AS promos_status,
        stg_orders.order_id,
        stg_orders.promo_id AS orders_promo_id,
        stg_orders.user_id,
        stg_orders.address_id,
        stg_orders.created_at,
        stg_orders.order_cost,
        stg_orders.shipping_cost,
        stg_orders.order_total,
        stg_orders.tracking_id,
        stg_orders.shipping_service,
        stg_orders.estimated_delivery_at,
        stg_orders.delivered_at,
        stg_orders.status AS orders_status
    FROM stg_promos
    LEFT JOIN stg_orders ON stg_orders.promo_id = stg_promos.promo_id
)

SELECT * FROM fact_order_promos
