# 🛒 Olist E-Commerce Analysis & Forecasting

This project explores the **Brazilian E-Commerce Public Dataset by Olist** to analyze order fulfillment, detect anomalies, and forecast inventory demand using SQL and Python.

---

## 📌 Project Goals

- 📦 **Analyze fulfillment performance** by product, seller, and region  
- ⚠️ **Detect delivery anomalies**, such as extreme delays or price outliers  
- 📈 **Forecast item-level demand** to support inventory planning  
- ⭐ **Quantify the impact of late deliveries** on customer reviews  

---

## 🧰 Tools & Technologies

- **SQL (SQLite)** – for joining and filtering the relational dataset  
- **Python (Pandas, Matplotlib, Seaborn)** – for EDA and visualization  
- **Jupyter Notebook** – for step-by-step analysis  
- **Prophet / XGBoost / statsmodels** *(planned)* – for demand forecasting  
- **Git & GitHub** – for version control and collaboration  

---

## 📄 SQL Scripts

This project uses a modular SQL script (`sql/olist_customer_seller_revenue_ranked.sql`) to preprocess and enrich the raw Olist dataset. It includes:

- A CTE for customer-seller revenue aggregation
- Window functions for:
  - Ranking customers by seller revenue
  - Calculating total order revenue
  - Averaging seller review scores
  - Identifying duplicate reviews per order
- Joins across all relevant Olist tables

This script prepares a clean dataset for advanced analysis and modeling in the Python notebook.

---

## 📂 Project Structure

