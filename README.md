# 🛒 Olist E-Commerce SQL Analysis (Relational Data Analysis Project)

An end-to-end SQL project analyzing transactional data from **Olist**, a Brazilian e-commerce marketplace.  
The project focuses on building a clean analytical base, validating data quality, and answering business questions around revenue, delivery performance, customer geography, and product categories.

All analysis was performed in **SQLite** using structured queries, CTEs, window functions, and time-based feature engineering.

---

## 🚀 What This Project Shows

- Real-world relational data analysis using SQL
- Designing and enforcing a clear analytical grain
- Building reusable base datasets with joins
- Performing data quality checks before analysis
- Time-based feature engineering
- Aggregations, window functions, and ranking logic
- Exporting SQL outputs for reporting and visualization
- Translating raw query results into business insights

This project emphasizes **analysis correctness, structure, and reasoning**, rather than visualization.

---

## 📊 Analysis Highlights

This project answers questions such as:

- How reliable is delivery performance overall?
- Does high revenue or volume impact delivery reliability?
- Which product categories drive the most revenue?
- How does revenue vary by time and geography?
- Do category preferences differ by state?

Key analytical themes include:

- Delivery performance vs. estimated delivery dates
- Revenue concentration by category
- Customer and revenue distribution by state
- Category rankings within each state
- Relationship between revenue scale and delivery reliability

---

## 🧱 Analytical Design

### Core Grain

> **One row per order item**

This grain allows:

- Accurate revenue attribution
- Flexible aggregation across time, geography, and product categories
- Consistent reuse across all downstream analyses

A reusable order-item–level dataset is constructed and referenced throughout the project.

---

## 🛠 Tools & Skills Used

- SQL (SQLite dialect)
- INNER and LEFT joins
- Common Table Expressions (CTEs)
- Window functions (RANK)
- Time functions (STRFTIME, JULIANDAY)
- Aggregations and grouping
- CASE statements
- Data quality validation
- Analytical query organization
- Exporting query results to CSV

---

## 📂 Project Structure

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

---

## 🧠 Key Insights (Quick Summary)

- Overall on-time delivery rate: ~92.9%
- High-revenue categories maintain delivery performance close to the overall average
- Revenue is highly concentrated in a small number of product categories
- São Paulo (SP) dominates in orders, items sold, and total revenue
- Some lower-volume states show higher average item prices
- Category preferences vary meaningfully by state
- High revenue does not appear to come at the cost of delivery reliability
  (Full analysis and context available in REPORT.md and the SQL files.)

---

## 📦 Data Source

- [Kaggle – Olist Brazilian E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?select=olist_order_items_dataset.csv)

---

## 👤 Author

**Mohammed Zareef-Mustafa**

---

## 📜 License

This project is licensed under the **MIT License**. See the [LICENSE.txt](LICENSE.txt) file for details.
