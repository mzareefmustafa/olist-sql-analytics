-- exporting main tables into "outputs" folder in csv format

.headers on
.mode csv
.output outputs/top_5_revenue_categories.csv

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

.output stdout