-- Time-based features derived from order timestamps
-- Goal: enable trend, seasonality, and delivery performance analysis
-- Grain: one row per order item

SELECT
    o.order_id,
    oi.order_item_id,

    -- Order timing
    DATE(o.order_purchase_timestamp) AS order_date,
    STRFTIME('%Y', o.order_purchase_timestamp) AS order_year,
    STRFTIME('%m', o.order_purchase_timestamp) AS order_month,
    STRFTIME('%Y-%m', o.order_purchase_timestamp) AS order_year_month,
    STRFTIME('%w', o.order_purchase_timestamp) AS order_weekday,

    -- Delivery timing
    DATE(o.order_delivered_customer_date) AS delivered_date,
    DATE(o.order_estimated_delivery_date) AS estimated_delivery_date,

    -- Delivery performance
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
JOIN order_items oi
    ON o.order_id = oi.order_id;

-- sanity check

SELECT
    COUNT(*) AS row_count,
    SUM(delivered_on_time) AS on_time_deliveries,
    COUNT(delivered_on_time) AS deliveries_with_status
FROM (
    SELECT
        o.order_id,
        oi.order_item_id,

        DATE(o.order_purchase_timestamp) AS order_date,
        STRFTIME('%Y', o.order_purchase_timestamp) AS order_year,
        STRFTIME('%m', o.order_purchase_timestamp) AS order_month,
        STRFTIME('%Y-%m', o.order_purchase_timestamp) AS order_year_month,
        STRFTIME('%w', o.order_purchase_timestamp) AS order_weekday,

        DATE(o.order_delivered_customer_date) AS delivered_date,
        DATE(o.order_estimated_delivery_date) AS estimated_delivery_date,

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
    JOIN order_items oi
        ON o.order_id = oi.order_id
) t;

