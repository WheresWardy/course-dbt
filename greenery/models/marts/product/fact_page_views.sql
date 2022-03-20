{{ config(materialized='table') }}

WITH stg_events AS (
    SELECT
        event_id,
        session_id,
        user_id,
        page_url,
        created_at,
        event_type,
        order_id,
        product_id
    FROM {{ ref('stg_events') }}
),

stg_users AS (
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

stg_products AS (
    SELECT
        product_id,
        name,
        price,
        inventory
    FROM {{ ref('stg_products') }}
),

fact_page_views AS (
    SELECT
        stg_events.event_id,
        stg_events.session_id,
        stg_events.user_id AS events_user_id,
        stg_events.page_url,
        stg_events.created_at AS events_created_at,
        stg_events.event_type,
        stg_events.order_id AS events_order_id,
        stg_events.product_id AS events_product_id,
        stg_users.user_id,
        stg_users.first_name,
        stg_users.last_name,
        stg_users.email,
        stg_users.phone_number,
        stg_users.created_at AS users_created_at,
        stg_users.updated_at,
        stg_users.address_id AS users_address_id,
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
        stg_orders.status,
        stg_products.product_id,
        stg_products.name,
        stg_products.price,
        stg_products.inventory
    FROM stg_events
    LEFT JOIN stg_users ON stg_users.user_id = stg_events.user_id
    LEFT JOIN stg_orders ON stg_orders.order_id = stg_events.order_id
    LEFT JOIN stg_products ON stg_products.product_id = stg_events.product_id
)

SELECT * FROM fact_page_views
