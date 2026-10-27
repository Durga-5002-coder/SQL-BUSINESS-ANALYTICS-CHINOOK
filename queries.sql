-- ====================================================================
-- PROJECT: CHINOOK DIGITAL MEDIA STORE - SQL BUSINESS ANALYSIS
-- Author: Durga Reddy Nidrabingi
-- Tools: SQLite / Relational Database Analysis
-- ====================================================================

-- 1. Top 5 Customers by Total Spend (Multi-table JOIN, Aggregation, Sorting)
-- Business Question: Who are our highest-value customers?
SELECT 
    c.CustomerId,
    c.FirstName || ' ' || c.LastName AS CustomerName,
    c.Country,
    ROUND(SUM(i.Total), 2) AS TotalSpent
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName, c.Country
ORDER BY TotalSpent DESC
LIMIT 5;


-- 2. Best-Selling Music Genres by Total Revenue (Multi-table 4-way JOIN)
-- Business Question: Which genres generate the most sales?
SELECT 
    g.Name AS Genre,
    COUNT(il.InvoiceLineId) AS TracksSold,
    ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS TotalRevenue
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY g.GenreId, g.Name
ORDER BY TotalRevenue DESC
LIMIT 10;


-- 3. Top-Performing Sales Representative by Revenue (Self/Employee JOIN)
-- Business Question: How much revenue did each sales support agent generate?
SELECT 
    e.EmployeeId,
    e.FirstName || ' ' || e.LastName AS SalesRepName,
    e.Title,
    ROUND(SUM(i.Total), 2) AS TotalSalesHandled
FROM Employee e
JOIN Customer c ON e.EmployeeId = c.SupportRepId
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY e.EmployeeId, SalesRepName, e.Title
ORDER BY TotalSalesHandled DESC;


-- 4. Customer Spending Ranking within Each Country (Window Function: DENSE_RANK)
-- Business Question: Who are the top spenders inside each individual country?
WITH CustomerSpending AS (
    SELECT 
        c.Country,
        c.FirstName || ' ' || c.LastName AS CustomerName,
        ROUND(SUM(i.Total), 2) AS TotalSpent
    FROM Customer c
    JOIN Invoice i ON c.CustomerId = i.CustomerId
    GROUP BY c.Country, c.CustomerId, CustomerName
)
SELECT 
    Country,
    CustomerName,
    TotalSpent,
    DENSE_RANK() OVER (PARTITION BY Country ORDER BY TotalSpent DESC) AS CountryRank
FROM CustomerSpending
ORDER BY Country ASC, CountryRank ASC;


-- 5. Monthly Revenue and Running Cumulative Total (Window Function)
-- Business Question: How has revenue accumulated month over month?
WITH MonthlyRevenue AS (
    SELECT 
        STRFTIME('%Y-%m', InvoiceDate) AS MonthYear,
        ROUND(SUM(Total), 2) AS MonthlyTotal
    FROM Invoice
    GROUP BY MonthYear
)
SELECT 
    MonthYear,
    MonthlyTotal,
    ROUND(SUM(MonthlyTotal) OVER (ORDER BY MonthYear), 2) AS CumulativeTotal
FROM MonthlyRevenue
ORDER BY MonthYear;