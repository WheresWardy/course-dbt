
SELECT
    order_id,
    product_id,
    quantity

FROM {{ source('greenery_db', 'order_items') }}