import sqlite3
import pandas as pd

# Connect to database
conn = sqlite3.connect("chinook.db")

# Example: Run Query 1 (Top Spenders)
query1 = """
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
"""

df_top_customers = pd.read_sql_query(query1, conn)
print("=== TOP 5 CUSTOMERS BY SPENDING ===")
print(df_top_customers)

# Example: Run Query 2 (Top Genres)
query2 = """
SELECT 
    g.Name AS Genre,
    COUNT(il.InvoiceLineId) AS TracksSold,
    ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS TotalRevenue
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY g.GenreId, g.Name
ORDER BY TotalRevenue DESC
LIMIT 5;
"""

df_top_genres = pd.read_sql_query(query2, conn)
print("\n=== TOP 5 GENRES BY REVENUE ===")
print(df_top_genres)

conn.close()