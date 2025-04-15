# 🛒 Olist E-Commerce Analysis

This project explores the **Brazilian E-Commerce Public Dataset by Olist** to analyze seller performance, fulfillment reliability, and customer dynamics using SQL and Python.

📽️ [Download the Olist Project Slide Deck (PDF)](visuals/Olist_E-Commerce_Analysis.pdf)

---

## 📌 Project Goals

- 🧠 Showcase SQL capabilities: joins, CTEs, window functions
- 📦 Investigate seller concentration (Pareto principle)
- 🚚 Analyze fulfillment performance and late deliveries
- 👥 Explore customer behavior through cohort analysis

📉 Forecasting and LTV modeling were both explored during this analysis. However, they were ultimately excluded to preserve analytical integrity:
- Forecasting was limited by a short historical window, increasing the risk of overfitting and reducing long-term reliability.
- LTV modeling was impacted by customer ID inconsistencies uncovered during cohort analysis, which suggested unreliable retention tracking.

---

## 📊 Key Insights

- 📉 **Fulfillment Lag During Growth**: From **Nov 2017 to Mar 2018**, on-time delivery rates dropped as monthly revenue surged, suggesting capacity constraints.
- 🛠️ **Operational Recovery**: By **Apr 2018**, Olist recovered fulfillment performance while sustaining growth.
- 🏆 **Seller Concentration**: 17.9% of sellers generate 80% of revenue, roughly confirming the Pareto Principle.
- 🚩 **High-Value Orders More Likely Delayed**: Anomaly detection flagged that large orders were disproportionately affected by fulfillment delays.
- 📦 **Late Deliveries Hurt Satisfaction**: On-time orders averaged a 4.29 review score, while severely delayed ones dropped to 1.73 — quantifying the fulfillment–CX connection.

----

## 📉 Data Limitations

> ⚠️ **Cohort Analysis Insight**  
> The cohort analysis suggests that `cust_unique_id` may not reliably track returning users. Even satisfied customers rarely appear in subsequent periods, which raises concerns that returning buyers may be assigned new IDs.  
> This data limitation impacts any metric relying on customer retention (e.g., churn, LTV) and should be considered when interpreting results.

---

## 🧰 Tools & Technologies

- **SQL (MySQL)** – joining 8+ tables, using CTEs and advanced window functions
- **Python (Pandas, Matplotlib, Seaborn)** – EDA, anomaly detection, cohort analysis
- **Jupyter Notebook** – step-by-step analysis with storytelling
- **Git & GitHub** – version control

---

## 📄 SQL Scripts

This project uses a modular SQL script (`sql/prepare_seller_customer_order_data.sql`) to preprocess and enrich the raw Olist dataset. It includes:

- Joins across orders, customers, sellers, reviews, products
- CTE for seller-level customer revenue aggregation
- Window functions:
  - Rank customers by revenue per seller
  - Calculate order totals
  - Average review score by seller
  - Preserve multiple reviews per order while ensuring metrics like revenue and fulfillment are not double-counted

This script prepares a clean dataset for advanced analysis and modeling in the Python notebook.
[📄 View SQL Query](sql/prepare_seller_customer_order_data.sql)

---

## 📂 Project Structure

```
├── data/                        # Raw and processed data files
├── notebooks/                  # Jupyter notebooks (main analysis)
│   └── olist_project_cleaned.ipynb
├── sql/                        # SQL queries for preprocessing
├── visuals/                    # Exported plots for README / presentation
├── README.md                   # Project summary and walkthrough
└── requirements.txt            # Python dependencies
```

## 📌 Conclusion

This project simulates a real-world business scenario:

- SQL is used to create clean, joinable datasets from disparate sources
- EDA uncovers fulfillment bottlenecks during scale
- Cohort analysis raised concerns about the reliability of **cust_unique_id** in tracking returning users
- Visualization connects operational issues with lost revenue

> **Key takeaway**: Data science is not just algorithms — it's understanding the business, challenging assumptions, and knowing what the data *can* and *cannot* tell you.
