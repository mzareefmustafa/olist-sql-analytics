-- exporting main tables into "outputs" folder in csv format

.headers on
.mode csv
.output outputs/top_category_per_state.csv

-- Top product categories per state
WITH state_category_sales AS (
    SELECT
        c.customer_state,
        ct.product_category_name_english AS product_category,
        COUNT(*) AS total_items,
        SUM(oi.price) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN customers c
        ON o.customer_id = c.customer_id
    LEFT JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN category_translation ct
        ON p.product_category_name = ct.product_category_name
    GROUP BY c.customer_state, ct.product_category_name_english
),

ranked_categories AS (
    SELECT
        customer_state,
        product_category,
        total_items,
        total_revenue,
        RANK() OVER (
            PARTITION BY customer_state
            ORDER BY total_revenue DESC
        ) AS category_rank
    FROM state_category_sales
)

SELECT
    customer_state,
    product_category,
    total_items,
    total_revenue,
    category_rank
FROM ranked_categories
WHERE category_rank <= 3
ORDER BY customer_state, category_rank;

.output stdout
