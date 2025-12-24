-- Top product categories by state
-- Goal: identify category-level revenue drivers per state
-- Grain: customer_state x product_category

WITH state_category_sales AS (
    SELECT
        c.customer_state,
        ct.product_category_name_english AS product_category,
        oi.price
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN customers c
        ON o.customer_id = c.customer_id
    LEFT JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN category_translation ct
        ON p.product_category_name = ct.product_category_name
)

SELECT
    customer_state,
    product_category,
    COUNT(*) AS total_items,
    SUM(price) AS total_revenue
FROM state_category_sales
GROUP BY customer_state, product_category
ORDER BY customer_state, total_revenue DESC;
