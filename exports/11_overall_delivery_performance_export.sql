-- exporting main tables into "outputs" folder in csv format

.headers on
.mode csv
.output outputs/overall_delivery_performance.csv

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

.output stdout
