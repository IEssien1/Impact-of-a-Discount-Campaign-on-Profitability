The sql_files folder contains the follwoing files for their respective purpose:

- Create_tables: This contains codes for creating the transcation, customer and product tables in MySQL database
- Analytical_views: This contains codes that generate the following views:
    - View 1: Profitability Impact by Month: This view aggregates overall profitability metrics
    - View 2: Product Category Performance: This view breaks down sales by product category, showing Total Transactions, Total Units Sold, Average Unit Margin, and Total Margin by category for each month.
    - View 3: Customer Segment Analysis: This view classifies customers as New or Returning based on their registration date, and aggregates the number of customers, Total Transactions, and Total Units Sold by month.
    - View 4: Sales Cannibalization Potential: This view examines customer activity by comparing the number of transactions in the prior months (November and December 2024) versus January 2025.
    - View 5: Regional Sales Analysis: This view aggregates sales performance by region, including total transactions, units sold, and revenue.
    - View 6: Abandoned Carts & Conversion Rate: This view calculates the total number of carts started, the number of abandoned carts, and the abandoned rate (in percentage).
    - View 7: Device/Channel Performance: This view breaks down transactions by the device used, showing the total number of transactions and total units sold per device.
    - View 8: Delivery Performance: This view shows the number of transactions for each delivery status.
    - View 9: Repeat Purchases (Customer Lifetime Value Proxy): This view identifies customers with more than one transaction, serving as a proxy for repeat purchase rate.
