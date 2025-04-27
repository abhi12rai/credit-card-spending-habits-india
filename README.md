# credit-card-spending-habits-india
### Gender, Location, and Transaction Trends

---

## 📋 Project Overview
This project analyzes **credit card spending behaviors** across various **cities, genders, and card types** in India.  
Through structured SQL queries, we uncover patterns in consumer spending that can provide valuable insights for business strategy and decision-making.

The primary goal is to practice **advanced SQL skills** and **data analysis thinking**, showcasing real-world analysis capabilities relevant to the **Data Analyst** role.

---

## 📂 Dataset Information

| Column Name | Description |
|:------------|:------------|
| city | City where the transaction occurred |
| date | Date of the transaction |
| card_type | Type of credit card used |
| exp_type | Type of expense |
| gender | Gender of the cardholder |
| amount | Transaction amount |

- **Note**:
  - Column names were standardized (lowercase, underscores instead of spaces).
  - Data types were corrected during SQL import (e.g., `date` as DATE, `amount` as FLOAT).

---

## 🎯 Business Problems and Analytical Objectives

| No. | Problem Statement |
|:----|:------------------|
| 1 | Identify the top 5 cities with the highest total spending and calculate their contribution percentage. |
| 2 | Determine the month with the highest spending for each card type along with the total amount. |
| 3 | Retrieve transaction details for each card type at the point when cumulative spending reaches 1 million. |
| 4 | Find the city with the lowest percentage spend for the 'Gold' card type. |
| 5 | For each city, find the expense type with the highest and lowest total spending. |
| 6 | Calculate the percentage contribution of female spending for each expense type. |
| 7 | Identify which card and expense type combination saw the highest month-over-month percentage growth in January 2014. |
| 8 | During weekends, find the city with the highest spend-to-transaction ratio. |
| 9 | Determine which city achieved 500 transactions in the shortest number of days from its first transaction date. |

👉 All detailed SQL queries are available inside [`queries/credit_card_spending_analysis.sql`](queries/credit_card_spending_analysis.sql)

---

## 🛠 Tools and Technologies
- **SQL Server** (Structured Query Language - SQL)
- **Data Cleaning and Transformation**
- **Window Functions, Aggregations, Common Table Expressions (CTEs)**
- **Date and Time Functions**
- **Analytical Thinking for Business Problems**

---

## 🔎 Key Insights and Findings
- Cities with the highest spending dominate a large share of total transactions.
- Spending patterns vary significantly across card types and time periods.
- Certain cities and expense types show significant seasonal or behavioral trends.
- Gender-based spending contributions reveal important consumer segmentation insights.

---

## 📈 Research Opportunities
Based on the project analysis, further research could include:
- **Understanding City-based Consumer Preferences**:  
  Identify which cities prefer certain types of expenses (e.g., bills vs travel) and customize marketing strategies accordingly.

- **Gender-Specific Campaign Planning**:  
  Use insights on how female and male spending patterns differ across categories to design targeted offers or promotions.

- **Seasonal Spend Behavior**:  
  Analyze if certain months or festivals (like Diwali, Christmas) drive higher spending based on card types and expense categories.

---

## 🚀 Future Enhancements
- Develop **interactive dashboards** (using Tableau or Power BI) to visualize spending behavior by city, gender, and card type.
- Expand the dataset by including additional years or more detailed demographic information for deeper trend analysis.
- Perform **time series analysis** on monthly spending to identify patterns or cycles.

---


---

## 📣 Connect with Me
If you found this project interesting, feel free to ⭐ this repo and connect with me on [LinkedIn](linkedin.com/in/abhishek-rai-5054001b7)!

---
