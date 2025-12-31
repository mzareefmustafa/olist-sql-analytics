# Olist E-Commerce Analytics (SQL)

An end-to-end SQL analysis of transactional data from **Olist**, a Brazilian e-commerce marketplace.  
This project focuses on building a clean analytical foundation, validating data quality, and answering business questions related to revenue, delivery performance, customer geography, and product categories.

All analysis was performed in **SQLite**, emphasizing analytical correctness, structure, and reasoning over visualization.

## Purpose

This project was built to:
- Design a reusable analytical dataset with a clear and explicit grain
- Validate data quality before analysis
- Analyze revenue concentration, delivery reliability, and geographic patterns
- Answer business questions using structured, production-style SQL queries

## Key Questions Answered

- How reliable is delivery performance overall?
- Does higher revenue or order volume affect delivery reliability?
- Which product categories generate the most revenue?
- How does revenue vary by time and geography?
- Do category preferences differ by state?

## Analytical Design

### Core Grain

**One row per order item**

This grain enables:
- Accurate revenue attribution
- Flexible aggregation across time, geography, and product categories
- Consistent reuse across all downstream analyses

A reusable order-item–level dataset is constructed and referenced throughout the project.

## Analysis Highlights

- Delivery performance compared against estimated delivery dates
- Revenue concentration across product categories
- Customer and revenue distribution by state
- Category rankings within each state using window functions
- Relationship between revenue scale and delivery reliability

## Key Insights

- Overall on-time delivery rate is approximately **92.9%**.
- High-revenue categories maintain delivery performance close to the overall average.
- Revenue is highly concentrated within a small subset of product categories.
- São Paulo (SP) dominates in total orders, items sold, and revenue.
- Several lower-volume states show higher average item prices.
- Product category preferences vary meaningfully by state.
- Higher revenue does not appear to come at the cost of delivery reliability.

(Full analysis and supporting queries are available in `REPORT.md` and the SQL files.)

## Tools & Skills Used

- SQL (SQLite)
- INNER and LEFT joins
- Common Table Expressions (CTEs)
- Window functions (RANK)
- Time functions (STRFTIME, JULIANDAY)
- Aggregations and grouping
- CASE statements
- Data quality validation
- Analytical query organization
- Exporting query results to CSV

## Project Structure

```text
data/
│
├── raw/
│   ├── olist_customers_dataset.csv
│   ├── olist_orders_dataset.csv
│   ├── olist_order_items_dataset.csv
│   ├── olist_products_dataset.csv
│   ├── olist_sellers_dataset.csv
│   ├── olist_order_payments_dataset.csv
│   ├── olist_order_reviews_dataset.csv
│   └── product_category_name_translation.csv
│
└── olist.db                          <-- SQLite database

sql/
├── 01_schema_exploration.sql         <-- table inspection & schema understanding
├── 02_base_order_items.sql           <-- base analytical dataset (order-item grain)
├── 03_data_quality_checks.sql        <-- integrity & validation checks
├── 04_time_features.sql              <-- time-based feature engineering
├── 05_delivery_performance.sql       <-- delivery reliability analysis
├── 06_revenue_analysis.sql           <-- revenue trends & category performance
├── 07_customer_analysis.sql          <-- customer & geographic analysis
├── 08_top_categories_by_state.sql    <-- category revenue by state
├── 09_top_category_per_state.sql     <-- ranked categories per state
├── 10_delivery_vs_revenue.sql        <-- revenue vs delivery reliability
└── 11_executive_summary.sql          <-- high-level summary metrics

exports/                              <-- SQL export scripts
outputs/                              <-- CSV outputs from analysis

REPORT.md                             <-- detailed written analysis & findings
README.md                             <-- project overview
```

## Data Source

- [Kaggle – Olist Brazilian E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?select=olist_order_items_dataset.csv)

## Author

**Mohammed Zareef-Mustafa**

## License

This project is licensed under the **MIT License**. See the [LICENSE.txt](LICENSE.txt) file for details.
