{{ config(materialized='table') }}

WITH stg_orders AS (
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

stg_order_items AS (
    SELECT
        order_id,
        product_id,
        quantity
    FROM {{ ref('stg_order_items') }}
),

stg_products AS (
    SELECT
        product_id,
        name,
        price,
        inventory
    FROM {{ ref('stg_products') }}
),

fact_orders AS (
    SELECT
        stg_orders.order_id,
        stg_orders.promo_id,
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
        stg_orders.status,
        stg_order_items.order_id AS order_items_order_id,
        stg_order_items.product_id AS order_items_product_id,
        stg_order_items.quantity,
        stg_products.product_id,
        stg_products.name,
        stg_products.price,
        stg_products.inventory
    FROM stg_orders
    LEFT JOIN stg_order_items ON stg_order_items.order_id = stg_orders.order_id
    LEFT JOIN stg_products ON stg_products.product_id = stg_order_items.product_id
)

SELECT * FROM fact_orders
