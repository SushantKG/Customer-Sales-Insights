
-- Create a database named "sales" 
-- Import all the required CSV files to this database as tables
-- Check all the columns
-- Now we will conduct exploratory data analysis (EDA) by answering some questions 
-----------------------------------------------------------------------------------------------

-- Q1: Show total revenue in years 2017-2020 --

SELECT d.year, SUM(t.sales_amount)
FROM transactions AS t
INNER JOIN date AS d
ON t.order_date= d.date
GROUP BY d.year;


-- Q2: Show revenue generated from each zone in 2020 --

SELECT d.year, m.zone, SUM(t.sales_amount)
FROM transactions AS t
INNER JOIN markets AS m
ON t.market_code=m.market_code
INNER JOIN date AS d
ON t.order_date=d.date
WHERE d.year=2020
GROUP BY m.zone
ORDER BY SUM(t.sales_amount)DESC;


-- Q3: Show markets(City) present in diffrent zones --

SELECT zone, market_name
FROM markets
GROUP BY zone , market_name
ORDER BY zone DESC;


-- Q4: Show total number of customers from each market(city)--

SELECT  m.market_name, COUNT(distinct t.customer_code)
FROM transactions AS t
INNER JOIN markets AS m
ON t.market_code=m.market_code
INNER JOIN customers as c
on t.customer_code= c.customer_code
GROUP BY m.market_name
ORDER BY COUNT(distinct t.customer_code)DESC;


-- Q5: Show total revenue generated from each Market(city) in year 2020 --

SELECT d.year, m.market_code, m.market_name, SUM(sales_amount)
FROM transactions AS t
INNER JOIN date AS d
ON t.order_date= d.date
INNER JOIN markets as m
ON t.market_code= m.market_code
WHERE d.year= 2020
GROUP BY m.market_name,m.market_code
ORDER BY SUM(sales_amount)DESC;


-- Q6: Show total number of transactions in Delhi NCR in year 2020 (Delhi NCR market code is Mark004)--

SELECT d.year ,COUNT(*) 
FROM transactions AS t
INNER JOIN DATE AS d
ON t.order_date= d.date
WHERE market_code= "Mark004" AND d.year=2020;


-- Q7: Show total revenue from Delhi NCR in year 2020 --

SELECT d.year, SUM(sales_amount)
FROM transactions AS t
INNER JOIN date AS d
ON t.order_date = d.date
WHERE market_code= "Mark004" and d.year= 2020
GROUP BY d.year;


-- Q8: Which store generated highest revenue in Delhi NCR in year 2020 --

SELECT d.year,c.custmer_name, SUM(sales_amount)
from transactions as t
INNER JOIN date as d
ON t.order_date=d.date
INNER JOIN customers as c
on t.customer_code= c.customer_code
WHERE market_code= "Mark004" and d.year=2020
GROUP BY d.year, c.custmer_name
ORDER BY SUM(sales_amount)DESC;


-- Q9: Show bestselling product codes from all stores in Delhi NCR in year 2020 --

SELECT distinct c.custmer_name, d.year, t.product_code, COUNT(t.product_code)
FROM transactions AS t
INNER JOIN customers as c
ON t.customer_code=c.customer_code
INNER JOIN date AS d
ON t.order_date=d.date
WHERE market_code= "Mark004" and d.year=2020
GROUP BY t.customer_code, d.year, t.product_code
ORDER BY COUNT(t.product_code) DESC ;


-- 10: Which store generated highest revenue in Mumbai in year 2020 --

SELECT d.year,c.custmer_name, SUM(sales_amount)
from transactions as t
INNER JOIN date as d
ON t.order_date=d.date
INNER JOIN customers as c
on t.customer_code= c.customer_code
WHERE market_code= "Mark002" and d.year=2020
GROUP BY d.year, c.custmer_name
ORDER BY SUM(sales_amount)DESC;


-- Q11: Show bestselling product codes from all stores in Mumbai in year 2020 --

SELECT distinct c.custmer_name, d.year, t.product_code, COUNT(t.product_code)
FROM transactions AS t
INNER JOIN customers as c
ON t.customer_code=c.customer_code
INNER JOIN date AS d
ON t.order_date=d.date
WHERE market_code= "Mark004" and d.year=2020
GROUP BY t.customer_code, d.year, t.product_code
ORDER BY COUNT(t.product_code) DESC ;
