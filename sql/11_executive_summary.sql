-- Executive summary checks
-- Goal: support key business insights with simple metrics

-- Overall delivery performance
SELECT
    COUNT(*) AS total_items,
    AVG(
        CASE
            WHEN o.order_delivered_customer_date IS NULL THEN NULL
            WHEN JULIANDAY(o.order_delivered_customer_date)
                 <= JULIANDAY(o.order_estimated_delivery_date)
            THEN 1
            ELSE 0
        END
    ) AS overall_on_time_rate
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id;

-- Top 5 revenue categories
SELECT
    ct.product_category_name_english AS product_category,
    SUM(oi.price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 5;
