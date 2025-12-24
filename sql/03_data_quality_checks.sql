-- Data quality checks for base order-item dataset
-- Goal: validate grain, key integrity, and critical fields
-- Any issues found here should be resolved before analysis

-- Expect one row per order item
SELECT COUNT(*) AS row_count
FROM order_items;

-- Check for duplicate order-item keys
SELECT
    order_id,
    order_item_id,
    COUNT(*) AS duplicate_count
FROM order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

-- Critical field null checks
SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) AS null_order_item_id,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_price
FROM order_items;

-- Product category coverage (after joining products)
SELECT
    COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN p.product_category_name IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_category
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id;


-- Summary:
-- Base order-item dataset is clean at the expected grain (one row per order item)
-- No duplicate keys or critical nulls detected
-- ~1.4% of items missing product category due to upstream metadata gaps
-- Safe to proceed with feature engineering and analysis


