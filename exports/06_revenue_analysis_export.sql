-- exporting main tables into "outputs" folder in csv format

.headers on
.mode csv
.output outputs/revenue_analysis.csv

-- Revenue analysis by time and product category
WITH base_revenue AS (
    SELECT
        STRFTIME('%Y-%m', o.order_purchase_timestamp) AS order_year_month,
        COALESCE(ct.product_category_name_english, 'unknown') AS product_category,
        oi.price,
        oi.freight_value
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    LEFT JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN category_translation ct
        ON p.product_category_name = ct.product_category_name
)

SELECT
    order_year_month,
    product_category,
    COUNT(*) AS total_items,
    SUM(price) AS total_revenue,
    SUM(freight_value) AS total_freight,
    AVG(price) AS avg_item_price
FROM base_revenue
GROUP BY 1, 2
ORDER BY 1, 2;

.output stdout
