-- Delivery performance summary
-- Grain: year_month × customer_state

WITH base_time AS (
    SELECT
        o.order_id,
        oi.order_item_id,
        STRFTIME('%Y-%m', o.order_purchase_timestamp) AS order_year_month,
        c.customer_state,
        JULIANDAY(o.order_delivered_customer_date)
            - JULIANDAY(o.order_purchase_timestamp) AS delivery_days_actual,
        JULIANDAY(o.order_estimated_delivery_date)
            - JULIANDAY(o.order_purchase_timestamp) AS delivery_days_estimated,
        CASE
            WHEN o.order_delivered_customer_date IS NULL THEN NULL
            WHEN JULIANDAY(o.order_delivered_customer_date)
                 <= JULIANDAY(o.order_estimated_delivery_date)
            THEN 1
            ELSE 0
        END AS delivered_on_time
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN customers c ON o.customer_id = c.customer_id
)

SELECT
    order_year_month,
    customer_state,
    COUNT(*) AS total_items,
    AVG(
    CASE 
        WHEN delivery_days_actual IS NOT NULL 
        THEN delivery_days_actual 
    END
    ) AS avg_actual_days,
    AVG(delivery_days_estimated) AS avg_estimated_days,
    AVG(delivered_on_time) AS on_time_rate
FROM base_time
GROUP BY 1, 2
ORDER BY 1, 2;

