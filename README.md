# Chinook Digital Media Store: SQL Business Performance Analysis

## Project Overview
This project performs end-to-end relational database analysis on the **Chinook** media store database. Using structured SQL queries, it evaluates customer lifetime value, genre revenue contributions, sales representative performance, and regional sales rankings to extract actionable commercial insights.

---

## Database Architecture
The Chinook database models a digital media store with a relational schema comprising:
* **Customers & Invoices:** Transaction logs, billing information, and customer profiles.
* **Tracks, Albums, & Genres:** Catalog inventory and categorical metadata.
* **Employees:** Internal sales support hierarchy.

---

## Key Business Questions & SQL Implementations

### 1. Top Customers by Total Spend
* **Technique:** Multi-table `JOIN`, `SUM()` aggregation, `GROUP BY`, `ORDER BY`.
* **Objective:** Identify the highest-value customers driving store revenue.

### 2. Best-Selling Music Genres by Revenue
* **Technique:** 4-table relational `JOIN` (`Genre` -> `Track` -> `InvoiceLine` -> `Invoice`).
* **Objective:** Determine catalog demand to inform licensing and marketing focus.

### 3. Sales Representative Quota & Performance
* **Technique:** Relational `JOIN` across employee support tiers and customer transactions.
* **Objective:** Benchmark sales representatives by total handled revenue.

### 4. Intra-Country Customer Ranking
* **Technique:** Common Table Expressions (CTEs) and Window Function `DENSE_RANK() OVER (PARTITION BY Country ORDER BY TotalSpent DESC)`.
* **Objective:** Rank top spenders within individual geographic markets.

### 5. Monthly Running Revenue Accumulation
* **Technique:** CTE with cumulative window sum `SUM(MonthlyTotal) OVER (ORDER BY MonthYear)`.
* **Objective:** Track monthly run-rate and cumulative financial trajectory.

---

## Tech Stack & Tools
* **Database Engine:** SQLite
* **Query Language:** SQL (Window functions, CTEs, multi-table joins)
* **Execution & Reporting:** Python, Pandas

---

## How to Run Locally

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/Durga-5002-coder/SQL-BUSINESS-ANALYTICS-CHINOOK.git](https://github.com/Durga-5002-coder/SQL-BUSINESS-ANALYTICS-CHINOOK.git)
   cd SQL-BUSINESS-ANALYTICS-CHINOOK