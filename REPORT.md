# Olist E-Commerce SQL Analysis

## Project Overview

This project analyzes transactional data from **Olist**, a Brazilian e-commerce marketplace, using SQL.  
The goal is to understand **revenue performance, delivery reliability, and customer behavior** across time, geography, and product categories.

All analysis was conducted in **SQLite**, with an emphasis on:

- Clear query structure
- Explicit data grain
- Validated results through upfront data quality checks

The core analytical grain for this project is **one row per order item**, which allows accurate revenue attribution and flexible aggregation throughout the analysis.

---

## Key Questions

- How reliable is delivery performance overall?
- Does high revenue or volume affect delivery reliability?
- Which product categories drive the most revenue?
- How does revenue vary by time and geography?
- Do category preferences differ by state?

---

## Project Structure

The analysis is organized as a sequence of SQL files, each building on the previous step:

1. **`01_schema_exploration.sql`**  
   Initial exploration of tables, columns, and relationships.

2. **`02_base_order_items.sql`**  
   Constructs the base order-item–level dataset used throughout the project.

3. **`03_data_quality_checks.sql`**  
   Validates grain, key integrity, and critical fields before analysis.

4. **`04_time_features.sql`**  
   Derives time-based features from order timestamps.

5. **`05_delivery_performance.sql`**  
   Evaluates delivery timing and on-time performance.

6. **`06_revenue_analysis.sql`**  
   Analyzes revenue trends by time and product category.

7. **`07_customer_analysis.sql`**  
   Examines customer behavior and revenue by state.

8. **`08_top_categories_by_state.sql`**  
   Breaks down category-level revenue within each state.

9. **`09_top_category_per_state.sql`**  
   Ranks top revenue-generating categories per state using window functions.

10. **`10_delivery_vs_revenue.sql`**  
    Compares delivery performance across product categories and revenue levels.

11. **`11_executive_summary.sql`**  
    Produces high-level metrics used to summarize key findings.

---

## Data & Methodology

### Core Tables Used

- `orders`
- `order_items`
- `customers`
- `products`
- `category_translation`

### Base Dataset

A reusable **order-item–level dataset** was created by joining:

- Orders → order items
- Products → category metadata
- Customers → geographic attributes

This base dataset is reused across all downstream analyses to ensure consistency and reduce duplication of logic.

---

## Data Quality Checks

Before performing analysis, the following validations were completed:

- Confirmed **one row per order item**
- Verified no duplicate `(order_id, order_item_id)` pairs
- Confirmed no nulls in critical fields (`order_id`, `order_item_id`, `price`)
- Identified some missing product categories  
  (expected due to incomplete product metadata)

All critical integrity checks passed, and the dataset was deemed suitable for analysis.

---

## Key Findings

### Delivery Performance

- **Overall on-time delivery rate:** ~92.9%
- High-revenue categories maintain delivery performance close to the overall average
- No product category shows systematic delivery delays

**Insight:** Higher sales volume does not appear to negatively impact delivery reliability.

---

### Revenue Performance

- Revenue is highly concentrated in a small number of product categories
- Top revenue drivers include:
  - Health & beauty
  - Watches & gifts
  - Bed & bath
  - Sports & leisure
  - Computers & accessories

**Insight:** A limited set of categories generates a disproportionate share of total revenue.

---

### Customer & Geographic Patterns

- São Paulo (SP) dominates total orders, items sold, and revenue
- RJ and MG follow at a significantly lower scale
- Some lower-volume states show higher average item prices

**Insight:** Revenue concentration is geographic, but customer value varies meaningfully by state.

---

### Category Performance by State

- Product categories were ranked by revenue within each state using window functions
- Health & beauty frequently ranks as the top category, but not universally
- Category preferences differ substantially across states

**Insight:** Regional demand patterns suggest opportunities for targeted marketing and inventory planning.

---

## Limitations

- Customer lifetime value and repeat purchase behavior were not analyzed
- Delivery performance is measured relative to estimated delivery dates only
- Some product categories are missing due to incomplete metadata
- Discounts and promotional effects are not explicitly modeled

---

## Conclusion

Olist demonstrates strong delivery reliability alongside highly concentrated revenue streams across product categories and geography. By structuring the analysis at the order-item level and validating data quality upfront, the results remain accurate, interpretable, and reproducible.

Potential next steps include:

- Diversifying revenue beyond top-performing categories
- Exploring regional demand differences in more detail
- Monitoring logistics performance as sales scale
