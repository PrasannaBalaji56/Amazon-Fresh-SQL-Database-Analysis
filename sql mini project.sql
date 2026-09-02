create database Amazon_Fresh;
use Amazon_Fresh;
alter table amazon_fresh.customers change ï»¿CustomerID CustomerID varchar(100) unique;
alter table amazon_fresh.customers modify Name varchar(100),
modify Age varchar(100), 
modify Gender varchar(100),
modify City varchar(100),
modify Country varchar(100),
modify SignupDate varchar(100),
modify PrimeMember varchar(100);
alter table amazon_fresh.customers modify State varchar(100);

alter table amazon_fresh.order_details change ï»¿OrderID OrderID varchar(100);
alter table amazon_fresh.order_details modify ProductID varchar(100),
modify Quantity int(100), 
modify UnitPrice int(100),
modify Discount int(100);


alter table amazon_fresh.orders change ï»¿OrderID OrderID varchar(100);
alter table amazon_fresh.orders modify CustomerID varchar(100),
modify OrderDate varchar(100), 
modify OrderAmount int(100),
modify DeliveryFee int(100),
modify DiscountApplied int(100);



alter table amazon_fresh.products change ï»¿ProductID ProductID varchar(100);
alter table amazon_fresh.products modify ProductName varchar(100),
modify Category varchar(100), 
modify SubCategory varchar(100),
modify PricePerUnit int(100),
modify StockQuantity int(100),
modify SupplierID varchar(100);



alter table amazon_fresh.reviews change ï»¿ReviewID ReviewID varchar(100);
alter table amazon_fresh.reviews modify ProductID varchar(100),
modify CustomerID varchar(100), 
modify Rating int(100),
modify ReviewText varchar(100);



alter table amazon_fresh.suppliers change ï»¿SupplierID SupplierID varchar(100);
alter table amazon_fresh.suppliers modify SupplierName varchar(100),
modify ContactPerson varchar(100), 
modify Phone varchar(100),
modify City varchar(100),
modify State varchar(100),
modify PHONE_NO varchar(100);

show tables from Amazon_Fresh;

select * from amazon_fresh.products;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- TASK 3 ) 

select * from amazon_fresh.customers where city = "Bettyport";
select * from amazon_fresh.products where Category= "Fruits";

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- TASK 4 : write a ddl statements to recreate the customers table with following constraints 

-- customerID as the primary key 
-- done in the task 2

-- Ensure Age cannot be null and must be greater than 18.
alter table amazon_fresh.customers
modify Age int not null check(age>=18);

-- Add a unique constraint for Name.
alter table amazon_fresh.customers
modify name varchar(100) unique;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Task 5: Insert 3 new rows into the Products table using INSERT statements.

insert into amazon_fresh.products(ProductID,Productname ,Category,SubCategory,PricePerUnit,StockQuantity,SupplierID) values
("3prasan768-g567-45b5-sa55-8esaoddfgebdk",'milk Dairy','Dairy','Sub-Dairy-4',20,27,"739703aohfibafnwfib"),
("4prasannabalaj79gv-balajcxtrx-bvcrx8976r",'kentucky','Meat','Sub-Meat-4',25,30,"45892yigfd864327"),
("6r6ftxzrfvjbtrxx-bhcscggrc46437-bghij9756",'aroma snacks','Snacks','Sub-Snacks-4',20,45,"945892jhuvyttbuyftf");

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Task 6: Update the stock quantity of a product where ProductID matches a specific ID.
set sql_safe_updates=0;

select * from amazon_fresh.products
where ProductID = '0219aafa-5dbc-4d92-acd9-8a78b4158651';

update amazon_fresh.products
set StockQuantity = 1000
where ProductID = '0219aafa-5dbc-4d92-acd9-8a78b4158651';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Task 7: Delete a supplier from the Suppliers table where their city matches a specific value.
select * from amazon_fresh.suppliers;

select supplierid from amazon_fresh.suppliers
where city = "South Ana";
-- 03ec3130-f542-432e-b173-f110efd69026
delete from amazon_fresh.suppliers
where SupplierID = '03ec3130-f542-432e-b173-f110efd69026';

-- Task 8: Use SQL constraints to:
-- Add a CHECK constraint to ensure that ratings in the Reviews table are between 1 and 5.
alter table amazon_fresh.reviews
modify Rating int check(Rating between 1 and 5);

-- Add a DEFAULT constraint for the PrimeMember column in the Customers table (default value: "No").

alter table amazon_fresh.customers
modify PrimeMember varchar(100) default('NO');

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

--  Task 9: Write queries using:
-- WHERE clause to find orders placed after 2024-01-01.
select * from amazon_fresh.orders
where OrderDate > 2024-01-01;

-- HAVING clause to list products with average ratings greater than 4.
select ProductID , avg(Rating) as AVERAGE_RATINGS from amazon_fresh.reviews
group by ProductID
having avg(Rating)>4;

-- GROUP BY and ORDER BY clauses to rank products by total sales.
select ProductID, sum(Quantity * UnitPrice) as TOTAL_SALES
from amazon_fresh.order_details
group by ProductID
order by TOTAL_SALES desc;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Task 10: Identifying High-Value Customers

-- Calculate each customer's total spending.
select customerID,sum(orderamount)
from amazon_fresh.orders
group by customerid;

-- Rank customers based on their spending.

select o.CustomerID,c.name,sum(orderamount) as TOTAL_AMOUNT , rank() over (order by sum(orderamount) desc ) as Ranks
from amazon_fresh.orders as o 
inner join amazon_fresh.customers as c
on o.CustomerID= c.CustomerID
group by o.CustomerID,c.name;

-- Identify customers who have spent more than ₹5,000.
select o.CustomerID,c.name,sum(orderamount)
from amazon_fresh.orders as o 
inner join amazon_fresh.customers as c
on o.CustomerID = c.CustomerID
group by o.CustomerID, c.Name
having o.CustomerID>5000;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- Task 11)
-- Join the Orders and OrderDetails tables to calculate total revenue per order.
SELECT o.OrderID,SUM(d.Quantity * d.UnitPrice - d.Discount) AS TotalRevenue 
from amazon_fresh.orders as o 
join amazon_fresh.order_details as d on o.OrderID = d.OrderID
group by  o.OrderID order by  TotalRevenue DESC;

-- Identify customers who placed the most orders in a specific time period.
SELECT c.CustomerID,c.Name,count(o.OrderID) as TOTALREVENUE	
from amazon_fresh.customers as c 
join amazon_fresh.orders as o on c.CustomerID=o.CustomerID 
where OrderDate between '2025-01-01' and '2025-01-08' 
group by c.CustomerID,c.Name 
Order by TOTALREVENUE desc; 

-- Find the supplier with the most products in stock.
SELECT s.SupplierID,s.SupplierName,COUNT(p.ProductID) AS Products_In_the_Stock 
FROM amazon_fresh.suppliers as s 
join amazon_fresh.products as p ON s.SupplierID = p.SupplierID 
WHERE p.StockQuantity > 0 
GROUP BY  s.SupplierID,s.SupplierName 
ORDER BY Products_In_the_Stock DESC
LIMIT 1;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Task 12: Normalize the Products table to 3NF:
-- Separate product categories and subcategories into a new table.
CREATE TABLE amazon_fresh.categories ( CategoryID INT PRIMARY KEY ,CategoryName VARCHAR(100) NOT NULL);
CREATE TABLE amazon_fresh.subcategories (SubCategoryID INT PRIMARY KEY,SubCategoryName VARCHAR(100) NOT NULL,CategoryID INT NOT NULL, FOREIGN KEY (CategoryID) REFERENCES amazon_fresh.categories(CategoryID));
alter table amazon_fresh.products ADD COLUMN CategoryID INT,ADD COLUMN SubCategoryID INT;
alter table amazon_fresh.products ADD CONSTRAINT fk_product_category FOREIGN KEY (CategoryID) REFERENCES amazon_fresh.categories(CategoryID);
alter table amazon_fresh.products ADD CONSTRAINT fk_product_subcategory FOREIGN KEY (SubCategoryID) REFERENCES amazon_fresh.subcategories(SubCategoryID);
select * from amazon_fresh.products;

SELECT DISTINCT Category
FROM amazon_fresh.products;

INSERT INTO amazon_fresh.categories (CategoryID, CategoryName)
VALUES
(1, 'Bakery'),
(2, 'Dairy'),
(3, 'Snacks'),
(4, 'Meat'),
(5, 'Fruits'),
(6, 'Vegetables');

select * from amazon_fresh.categories;

SELECT DISTINCT Category, SubCategory
FROM amazon_fresh.products
ORDER BY Category, SubCategory;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- task 13) Write a subquery to Identify the top 3 products based on sales revenue.

SELECT p.ProductID,p.ProductName,sub.Total_Revenue 
FROM amazon_fresh.products as p
JOIN (SELECT ProductID, SUM(Quantity * UnitPrice) AS Total_Revenue 
FROM amazon_fresh.order_details GROUP BY ProductID ORDER BY Total_Revenue DESC LIMIT 3) as sub
ON p.ProductID = sub.ProductID ORDER BY sub.Total_Revenue DESC;

-- Find customers who haven’t placed any orders yet.
SELECT CustomerID,Name from amazon_fresh.customers 
where CustomerID NOT IN (select CustomerID from amazon_fresh.orders);
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- Task 14 
-- Which cities have the highest concentration of Prime members?
select city from amazon_fresh.customers 
where PrimeMember ='Yes' 
group by city 
order by count(PrimeMember) 
desc limit 1; 

-- What are the top 3 most frequently ordered categories?
select Category from amazon_fresh.products 
group by Category 
order by count(ProductID) 
desc limit 3;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 



