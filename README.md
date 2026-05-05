Cohort & Retention Analysis (PostgreSQL Project)

* Description

This project demonstrates cohort analysis and customer retention calculation using SQL in PostgreSQL.



Database Structure

 customers — users
 orders — transactions
 order_items — order details
 products — product catalog



Features

- Cohort analysis (by first purchase month)
- Retention rate calculation
- Month-to-month user tracking
- Data normalization by cohort size



 SQL Concepts Used

- CTE (WITH)
- Window functions
-  DATE_TRUNC
-  Aggregations
-  JOINs



Example Output

| cohort_month | month_number | retention |
| ------------ | ------------ | --------- |
| 2025-05      | 0            | 1.0       |
| 2025-05      | 1            | 0.6       |
| 2025-05      | 2            | 0.3       |



How to run

1. Create tables using schema.sql
2. Insert data using data.sql
3. Run analysis.sql


Goal

Practice SQL for product analytics:

-  retention
- cohort analysis
- working with dates



 * Author

Aidana Orazynbetova
