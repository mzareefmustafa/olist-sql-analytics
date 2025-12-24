-- 01_schema_exploration.sql
-- Goal: confirm table sizes, keys, and join paths before any analysis.

-- Row counts (sanity check)
SELECT 'orders' AS table_name, COUNT(*) AS row_count FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'customers', COUNT(*) FROM customers
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'payments', COUNT(*) FROM payments
UNION ALL SELECT 'reviews', COUNT(*) FROM reviews
UNION ALL SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL SELECT 'category_translation', COUNT(*) FROM category_translation;

-- Quick peek at each table
SELECT * FROM orders LIMIT 5;
SELECT * FROM order_items LIMIT 5;
SELECT * FROM customers LIMIT 5;
SELECT * FROM products LIMIT 5;
SELECT * FROM payments LIMIT 5;
SELECT * FROM reviews LIMIT 5;
SELECT * FROM sellers LIMIT 5;
SELECT * FROM category_translation LIMIT 5;

-- Distinct IDs (basic key checks)
SELECT COUNT(*) AS rows, COUNT(DISTINCT order_id) AS distinct_order_id FROM orders;
SELECT COUNT(*) AS rows, COUNT(DISTINCT customer_id) AS distinct_customer_id FROM customers;
SELECT COUNT(*) AS rows, COUNT(DISTINCT product_id) AS distinct_product_id FROM products;
SELECT COUNT(*) AS rows, COUNT(DISTINCT seller_id) AS distinct_seller_id FROM sellers;

-- Cardinality checks (how tables relate)
-- Orders can have multiple items
SELECT
  COUNT(*) AS item_rows,
  COUNT(DISTINCT order_id) AS distinct_orders_with_items,
  ROUND(1.0 * COUNT(*) / COUNT(DISTINCT order_id), 3) AS avg_items_per_order
FROM order_items;

-- Payments can have multiple rows per order (split payments, etc.)
SELECT
  COUNT(*) AS payment_rows,
  COUNT(DISTINCT order_id) AS distinct_orders_with_payments,
  ROUND(1.0 * COUNT(*) / COUNT(DISTINCT order_id), 3) AS avg_payment_rows_per_order
FROM payments;

-- Join smoke tests (should return rows, no weird NULL explosions)
SELECT
  o.order_id,
  o.order_status,
  o.order_purchase_timestamp,
  oi.product_id,
  oi.seller_id,
  oi.price,
  oi.freight_value
FROM orders o
JOIN order_items oi
  ON o.order_id = oi.order_id
LIMIT 10;

SELECT
  oi.order_id,
  p.product_id,
  p.product_category_name,
  ct.product_category_name_english
FROM order_items oi
JOIN products p
  ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
  ON p.product_category_name = ct.product_category_name
LIMIT 10;

SELECT
  o.order_id,
  pay.payment_type,
  pay.payment_installments,
  pay.payment_value
FROM orders o
JOIN payments pay
  ON o.order_id = pay.order_id
LIMIT 10;

SELECT
  o.order_id,
  r.review_score,
  r.review_creation_date
FROM orders o
JOIN reviews r
  ON o.order_id = r.order_id
LIMIT 10;
