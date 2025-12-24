-- Base order-item level dataset
-- One row per order item
-- Reused for downstream analysis

-- Expecting 112,650 rows
SELECT COUNT(*)
FROM (
    SELECT
        o.order_id,
        o.order_purchase_timestamp,
        o.order_status,
        oi.order_item_id,
        oi.product_id,
        oi.seller_id,
        oi.price,
        oi.freight_value,
        p.product_category_name,
        ct.product_category_name_english,
        c.customer_id,
        c.customer_city,
        c.customer_state
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    LEFT JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN category_translation ct
        ON p.product_category_name = ct.product_category_name
    LEFT JOIN customers c
        ON o.customer_id = c.customer_id
);
