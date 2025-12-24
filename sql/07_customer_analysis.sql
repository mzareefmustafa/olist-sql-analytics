-- Customer analysis by state
-- Goal: understand geographic distribution and customer value
-- Grain: customer_state

WITH customer_orders AS (
    SELECT
        c.customer_state,
        o.order_id,
        oi.price
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN customers c
        ON o.customer_id = c.customer_id
)

SELECT
    customer_state,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS total_items,
    SUM(price) AS total_revenue,
    AVG(price) AS avg_item_price
FROM customer_orders
GROUP BY customer_state
ORDER BY total_revenue DESC;
