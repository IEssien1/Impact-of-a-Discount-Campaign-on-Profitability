-- View 1: Profitability Impact by Month
-- This view aggregates overall profitability metrics
-- (Total Transactions, Average Transaction Margin, Total Margin)
-- for November 2024, December 2024, and January 2025.
CREATE OR REPLACE VIEW vw_ProfitabilityImpact AS
SELECT 
    DATE_FORMAT(t.TransactionTimestamp, '%Y-%m') AS SalesMonth,
    COUNT(*) AS TotalTransactions,
    AVG(((p.UnitPrice - t.Discount) - p.CostPrice) * t.Quantity) AS AvgTransactionMargin,
    SUM(((p.UnitPrice - t.Discount) - p.CostPrice) * t.Quantity) AS TotalMargin
FROM Transaction t
JOIN Product p ON t.ProductPurchased = p.ProductID
WHERE DATE_FORMAT(t.TransactionTimestamp, '%Y-%m') IN ('2024-11', '2024-12', '2025-01')
GROUP BY DATE_FORMAT(t.TransactionTimestamp, '%Y-%m')
ORDER BY SalesMonth;

--------------------------------------------------
-- View 2: Product Category Performance
-- This view breaks down sales by product category,
-- showing Total Transactions, Total Units Sold, Average Unit Margin,
-- and Total Margin by category for each month.
CREATE OR REPLACE VIEW vw_ProductCategoryPerformance AS
SELECT 
    DATE_FORMAT(t.TransactionTimestamp, '%Y-%m') AS SalesMonth,
    p.Category,
    COUNT(t.TransactionID) AS TotalTransactions,
    SUM(t.Quantity) AS TotalUnitsSold,
    AVG(((p.UnitPrice - t.Discount) - p.CostPrice)) AS AvgUnitMargin,
    SUM(((p.UnitPrice - t.Discount) - p.CostPrice) * t.Quantity) AS TotalMargin
FROM Transaction t
JOIN Product p ON t.ProductPurchased = p.ProductID
WHERE DATE_FORMAT(t.TransactionTimestamp, '%Y-%m') IN ('2024-11', '2024-12', '2025-01')
GROUP BY SalesMonth, p.Category
ORDER BY SalesMonth, p.Category;

--------------------------------------------------
-- View 3: Customer Segment Analysis
-- This view classifies customers as New or Returning based on their registration date,
-- and aggregates the number of customers, Total Transactions, and Total Units Sold by month.
CREATE OR REPLACE VIEW vw_CustomerSegments AS
SELECT 
    DATE_FORMAT(t.TransactionTimestamp, '%Y-%m') AS SalesMonth,
    CASE 
        WHEN c.DateOfRegistration < DATE_FORMAT(t.TransactionTimestamp, '%Y-%m-01') THEN 'Returning Customer'
        ELSE 'New Customer'
    END AS CustomerType,
    COUNT(DISTINCT c.CustomerID) AS CustomerCount,
    COUNT(t.TransactionID) AS TotalTransactions,
    SUM(t.Quantity) AS TotalUnitsSold
FROM Transaction t
JOIN Customer c ON t.CustomerID = c.CustomerID
WHERE DATE_FORMAT(t.TransactionTimestamp, '%Y-%m') IN ('2024-11', '2024-12', '2025-01')
GROUP BY SalesMonth, CustomerType
ORDER BY SalesMonth, CustomerType;

--------------------------------------------------
-- View 4: Sales Cannibalization Potential
-- This view examines customer activity by comparing the number of transactions
-- in the prior months (November and December 2024) versus January 2025.
CREATE OR REPLACE VIEW vw_SalesCannibalization AS 
SELECT 
    ca.CustomerID,
    ca.Name,
    MAX(CASE WHEN ca.SalesMonth IN ('2024-11', '2024-12') THEN ca.Transactions ELSE 0 END) AS PrevTransactions,
    MAX(CASE WHEN ca.SalesMonth = '2025-01' THEN ca.Transactions ELSE 0 END) AS JanTransactions
FROM (
    SELECT 
        c.CustomerID,
        c.Name,
        DATE_FORMAT(t.TransactionTimestamp, '%Y-%m') AS SalesMonth,
        COUNT(t.TransactionID) AS Transactions
    FROM Transaction t
    JOIN Customer c ON t.CustomerID = c.CustomerID
    WHERE DATE_FORMAT(t.TransactionTimestamp, '%Y-%m') IN ('2024-11', '2024-12', '2025-01')
    GROUP BY c.CustomerID, c.Name, DATE_FORMAT(t.TransactionTimestamp, '%Y-%m')
) AS ca
GROUP BY ca.CustomerID, ca.Name
ORDER BY JanTransactions DESC;

-- View: Regional Sales Analysis
-- This view aggregates sales performance by region, including total transactions,
-- units sold, and revenue.
CREATE VIEW vw_RegionalSales AS
SELECT
 t.Region,
 COUNT(t.TransactionID) AS TotalTransactions,
 SUM(t.Quantity) AS TotalUnitsSold,
 SUM((p.UnitPrice - t.Discount) * t.Quantity) AS TotalRevenue
FROM Transaction t
JOIN Product p ON t.ProductPurchased = p.ProductID
GROUP BY t.Region;

-- View: Abandoned Carts & Conversion Rate
-- This view calculates the total number of carts started, the number of abandoned carts,
-- and the abandoned rate (in percentage).
CREATE VIEW vw_AbandonedCarts AS
SELECT
 COUNT(*) AS TotalCarts,
 SUM(CASE WHEN t.Abandoned = 'Yes' THEN 1 ELSE 0 END) AS AbandonedCarts,
 (SUM(CASE WHEN t.Abandoned = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS
AbandonedRate
FROM Transaction t
WHERE t.CartStartTimestamp IS NOT NULL;

-- View: Device/Channel Performance
-- This view breaks down transactions by the device used, showing the total number of transactions
-- and total units sold per device.
CREATE VIEW vw_DevicePerformance AS
SELECT
 t.DeviceUsed,
 COUNT(t.TransactionID) AS TotalTransactions,
 SUM(t.Quantity) AS TotalUnitsSold
FROM Transaction t
GROUP BY t.DeviceUsed;

-- View: Delivery Performance
-- This view shows the number of transactions for each delivery status.
CREATE VIEW vw_DeliveryPerformance AS
SELECT
 DeliveryStatus,
 COUNT(TransactionID) AS TotalDeliveries
FROM Transaction
GROUP BY DeliveryStatus;

-- View: Repeat Purchases (Customer Lifetime Value Proxy)
-- This view identifies customers with more than one transaction, serving as a proxy for repeat purchase rate.
-- CREATE VIEW vw_RepeatPurchases AS
SELECT
 c.CustomerID,
 c.Name,
 COUNT(t.TransactionID) AS TransactionCount
FROM Customer c
JOIN Transaction t ON c.CustomerID = t.CustomerID
GROUP BY c.CustomerID, c.Name
HAVING COUNT(t.TransactionID) > 1;