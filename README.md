# 🗄️ Amazon Fresh — SQL Database Design & Business Analysis

## 📌 Project Overview

This project focuses on designing and analyzing an **Amazon Fresh relational database** using MySQL.

The project covers the complete SQL workflow, including database creation, table modifications, constraints, data manipulation, joins, aggregation, window functions, subqueries, and database normalization.

The database contains multiple related entities such as customers, orders, order details, products, suppliers, and reviews.

---

## 🎯 Project Objectives

The main objectives of this project are to:

- Create and manage a relational database
- Understand relationships between multiple tables
- Apply primary keys and foreign keys
- Modify existing table structures
- Perform INSERT, UPDATE, and DELETE operations
- Apply SQL constraints
- Filter and aggregate data
- Analyze customer and product behavior
- Use joins to combine related tables
- Use window functions for ranking
- Use subqueries for advanced analysis
- Normalize tables up to Third Normal Form (3NF)

---

## 🗂️ Database Structure

The Amazon Fresh database contains the following main tables:

- `customers`
- `orders`
- `order_details`
- `products`
- `suppliers`
- `reviews`

Additional tables were introduced during normalization:

- `categories`
- `subcategories`

---

## 🔗 Database Relationships

The database follows a relational structure where different entities are connected using primary and foreign keys.

### Main Relationships

- Customers → Orders
- Orders → Order Details
- Products → Order Details
- Products → Reviews
- Customers → Reviews
- Suppliers → Products
- Categories → Products
- Subcategories → Products

The EER diagram represents these relationships and the overall database structure.

---

## 🧱 Database Operations

### 1. Database & Table Management

The project begins by creating and selecting the `Amazon_Fresh` database and modifying existing tables to establish appropriate column definitions.

Examples include modifying:

- Customer attributes
- Order attributes
- Product attributes
- Review attributes
- Supplier attributes

---

## 🔑 Constraints

Several SQL constraints were implemented to improve data integrity.

### Primary Key

Customer IDs and other entity identifiers are used to uniquely identify records.

### UNIQUE Constraint

A unique constraint was applied to the customer `Name` field.

### NOT NULL Constraint

The `Age` field was modified to prevent NULL values.

### CHECK Constraint

Customer age was restricted using a CHECK condition.

Review ratings were also restricted to values between 1 and 5.

### DEFAULT Constraint

The `PrimeMember` field was assigned a default value of `NO`.

---

## ✏️ CRUD Operations

The project demonstrates the major SQL data manipulation operations.

### INSERT

Three new products were inserted into the `products` table.

### UPDATE

The stock quantity of a specific product was updated to `1000`.

### DELETE

A supplier associated with a specific city was identified and deleted.

These operations demonstrate practical data manipulation using SQL.

---

## 🔍 Filtering & Aggregation

The project uses SQL clauses such as:

- `WHERE`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `LIMIT`

Examples include:

- Finding customers from a specific city
- Finding products belonging to a specific category
- Finding products with average ratings greater than 4
- Ranking products based on total sales
- Finding the most frequently ordered categories

---

## 📊 Customer Analysis

Customer spending was calculated using aggregation functions.

The project also demonstrates ranking customers based on their total order amount using the `RANK()` window function.

### Customer Analysis Includes:

- Total spending per customer
- Customer ranking
- High-value customer identification
- Customers who have not placed any orders
- Prime member concentration by city

---

## 📦 Product & Sales Analysis

Product performance was analyzed using order and product information.

The analysis includes:

- Total sales per product
- Top 3 products by sales revenue
- Average product ratings
- Product stock availability
- Most frequently ordered categories

---

## 🔗 JOIN Operations

Multiple tables were combined using SQL JOINs.

Examples include:

### Customers + Orders

Used to analyze customer ordering behavior.

### Orders + Order Details

Used to calculate total revenue per order.

### Suppliers + Products

Used to identify suppliers with the highest number of products in stock.

### Products + Customers + Reviews

The relational structure allows product reviews to be connected with both customers and products.

---

---

## 📈 Key DAX Measures

DAX was used in Power BI to create key performance indicators and analyze customer, order, sales, product, and rating data.

### 1. Total Customers

```DAX
Total Customers =
DISTINCTCOUNT(customers[CustomerID])
```
What it does:
Counts the number of unique customers.

Why it is used:
Used to display the total customer count in the dashboard.

2. Total Orders
```DAX
Total Orders =
DISTINCTCOUNT(orders[OrderID])
```
What it does:
Counts the number of unique orders.

Why it is used:
Used to measure the total number of orders placed by customers.


3. Total Sales
```DAX
Total Sales =
SUMX(
    order_details,
    order_details[Quantity] * order_details[UnitPrice]
)
```
What it does:
Calculates the sales amount for each order detail by multiplying quantity by unit price and then adds all order values.

Why it is used:
Used to calculate total revenue and analyze overall sales performance.

4. Average Order Value

```DAX
Average Order Value =
DIVIDE(
    [Total Sales],
    [Total Orders]
)
```
What it does:
Divides total sales by the total number of orders.

Why it is used:
Used to understand the average amount spent per order.


the above ones are some of the example of the dax functions 

## dashboard 


<img width="1149" height="648" alt="Screenshot 2026-09-02 230308" src="https://github.com/user-attachments/assets/93503f09-f481-4956-a455-adca489cb4a4" />
<img width="1150" height="649" alt="Screenshot 2026-09-02 230332" src="https://github.com/user-attachments/assets/37f66590-a501-40f9-bd82-a03332eb8fdc" />
<img width="1146" height="648" alt="Screenshot 2026-09-02 230340" src="https://github.com/user-attachments/assets/35f7a05d-d22a-48fb-872d-2520851ad967" />
