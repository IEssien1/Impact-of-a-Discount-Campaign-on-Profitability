# Analyzing the Impact of a Discount Campaign on Profitability

## Situation:
A retail company launched a 15% discount campaign in January, driving significant sales volume. However, the CEO questioned whether the campaign truly improved profitability. My goal was to analyze the company’s sales and customer data to determine:
- Whether profitability improved
- If the campaign cannibalized full-price sales
- Whether it attracted the right customer segments
Based on my findings, I provided strategic recommendations to ensure sustainable growth.

## Approach:
To systematically evaluate the campaign’s impact, I structured the analysis into the following key tasks:
### 1. Data Cleaning & Exploratory Data Analysis (EDA)
- Processed customer transactions and product data using Microsoft Excel Power Query.
- Removed duplicates, standardized formats, validated data ranges, and handled missing values.
- Converted negative transactional values to positive for accurate analysis.
### 2. Database & Data Pipeline Creation
- Established a MySQL database to store transaction, customer, and product data.
- Developed a Python script to automate data updates from Microsoft Excel to the database.
### 3. Data Analysis Using SQL
- Created analytical views to assess the impact on:
   - Profitability: Month-over-month profit margin trends.
   - Sales Cannibalization: Impact on full-price sales and repeat purchases.
   - Customer Segments: Analysis of new vs. returning customers.
   - Regional Performance: Identifying high-performing markets.
   - Product Performance: Evaluating the effect of the campaign across product categories.
   - Operational Efficiency: Examining order devices and delivery times.
## 4.	Visualization & Reporting
- Developed a Power BI dashboard to present key insights visually.
- Documented findings and strategic recommendations for the leadership team.

## Key Findings:
1.	Profitability: January’s average profit margin increased by 16.4%, compared to 10.9% in December, indicating a positive impact from the discount campaign.
2.	Sales Cannibalization: A decline in transactions from returning customers suggests that some full-price sales were cannibalized.
3.	Customer Acquisition: The campaign successfully attracted new customers, but returning customers showed reduced engagement.
4.	Regional Performance: Highest transaction volumes were recorded in Africa, Asia/Pacific, and North America.
5.	Product Performance: 
  - Electronics saw the highest transaction volume and profit margin, but the discount had no incremental effect.
  - Fashion items showed a slight improvement in units sold due to the campaign.
7.	User Behavior: Most transactions were conducted via desktop and tablet, rather than mobile devices.

## Recommendations:
1.	Customer Retention Strategy: Introduce tailored promotions to encourage repeat purchases from returning customers.
2.	Targeted Marketing: Increase marketing efforts in high-performing regions (Africa, Asia/Pacific, North America).
3.	Product-Specific Strategies: Since electronics sales were unaffected by the discount, analyze December’s growth drivers and replicate successful strategies.
4.	Delivery System Optimization: Improve logistics to enhance delivery speed and reduce pending orders.
5.	Mobile Experience Enhancement: Optimize the mobile app to encourage more transactions via smartphones.

## Conclusion:
This analysis highlights the importance of data-driven decision-making in promotional campaigns. While the discount strategy increased profitability and customer acquisition, refining approaches for customer retention and operational efficiency will ensure long-term sustainable growth.
