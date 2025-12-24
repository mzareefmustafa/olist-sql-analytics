-- Revenue vs delivery performance by product category
-- Goal: understand whether high-revenue categories also deliver on time
-- Grain: product_category

WITH category_delivery AS (
    SELECT
        ct.product_category_name_english AS product_category,
        oi.price,
        CASE
            WHEN o.order_delivered_customer_date IS NULL THEN NULL
            WHEN JULIANDAY(o.order_delivered_customer_date)
                 <= JULIANDAY(o.order_estimated_delivery_date)
            THEN 1
            ELSE 0
        END AS delivered_on_time
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    LEFT JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN category_translation ct
        ON p.product_category_name = ct.product_category_name
)

SELECT
    product_category,
    COUNT(*) AS total_items,
    SUM(price) AS total_revenue,
    AVG(delivered_on_time) AS on_time_rate
FROM category_delivery
GROUP BY product_category
HAVING product_category IS NOT NULL
ORDER BY total_revenue DESC;
