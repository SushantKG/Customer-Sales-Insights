# Customer Sales Insights

## Project Overview

This project gives sales insights into a hardware manufacturing company from 2017 to 2020 with ten regional offices in three zones across India generating an overall revenue of close to 100 crores from 20 lakhs sales in 4 years.

### Raw Data Source - [db_dump.sql](db_dump.sql)

## Steps

- import the dataset to my SQL workbench
- Perform QA testing and Data Profiling
- Import this SQL database in Power BI
- Use power Queries to build KPIs and Create an insightful interactive dashboard [interactive Dashboard](https://github.com/SushantKG/Customer-Sales-Insights/blob/main/Power%20BI%20Interactive%20Dashboard.pbix)
- Data validation using My SQL queries [SQL Queries](https://github.com/SushantKG/Customer-Sales-Insights/blob/main/MySQL%20Queries.sql)
- Refer to Schema [Schema](Schema.png)

## Tools

- MY SQL - For QA testing, Data profiling and Data Validation
- Power BI - For Data Transformation, build KPIs and create an interactive dashboard,

## My SQL Queries and Results



### Q1: Show total revenue in years 2017-2020
```SQL
SELECT d.year, SUM(t.sales_amount) AS Total_Revenue
FROM transactions AS t
INNER JOIN date AS d
ON t.order_date= d.date
GROUP BY d.year;
```
![Screenshot 2023-12-19 121446](https://github.com/SushantKG/Customer-Sales-Insights/assets/152982735/b479441a-fce8-43d6-95ee-13907f2f18e6)




### Q2: Show revenue generated from each zone in 2020
```sql
SELECT d.year, m.zone, SUM(t.sales_amount) AS Total_Revenue
FROM transactions AS t
INNER JOIN markets AS m
ON t.market_code=m.markets_code
INNER JOIN date AS d
ON t.order_date=d.date
WHERE d.year=2020
GROUP BY m.zone
ORDER BY SUM(t.sales_amount)DESC;
```
![Screenshot 2023-12-19 121604](https://github.com/SushantKG/Customer-Sales-Insights/assets/152982735/9ba52e63-a1d8-488d-aa08-30618c24f2ff)


### Q3: Show markets(City) present in diffrent zones
```sql
SELECT zone, markets_name AS City
FROM markets
GROUP BY zone , markets_name
ORDER BY zone DESC;
```

![Screenshot 2023-12-19 121824](https://github.com/SushantKG/Customer-Sales-Insights/assets/152982735/6c339712-d91c-43f0-b85b-c875d458c2e8)



### Q4: Show total number of customers from each market(city)
```sql
SELECT  m.markets_name AS market, COUNT(distinct t.customer_code) AS No_of_Customers
FROM transactions AS t
INNER JOIN markets AS m
ON t.market_code=m.markets_code
INNER JOIN customers AS c
ON t.customer_code= c.customer_code
GROUP BY m.markets_name
ORDER BY COUNT(distinct t.customer_code)DESC;
```
![Screenshot 2023-12-19 124611](https://github.com/SushantKG/Customer-Sales-Insights/assets/152982735/6971223e-0a5c-482c-b474-ec6341d2f62c)



### Q5: Show total revenue generated from each Market(city) in year 2020
```sql
SELECT d.year, m.markets_code, m.markets_name AS Market, SUM(sales_amount) AS Total_Revenue
FROM transactions AS t
INNER JOIN date AS d
ON t.order_date= d.date
INNER JOIN markets AS m
ON t.market_code= m.markets_code
WHERE d.year= 2020
GROUP BY m.markets_name,m.markets_code
ORDER BY SUM(sales_amount)DESC;
```
![Screenshot 2023-12-19 124800](https://github.com/SushantKG/Customer-Sales-Insights/assets/152982735/e3d288eb-9f29-4059-880f-b5ce66b74460)



### Q6: Show total number of transactions in Delhi NCR in year 2020 (Delhi NCR market code is Mark004)
```sql
SELECT d.year ,COUNT(*) 
FROM transactions AS t
INNER JOIN DATE AS d
ON t.order_date= d.date
WHERE market_code= "Mark004" AND d.year=2020;
```
![Screenshot 2023-12-19 121023](https://github.com/SushantKG/Customer-Sales-Insights/assets/152982735/02b3da05-1fdf-444e-9c23-1db53fc8c7c7)



### Q7: Show total revenue from Delhi NCR in year 2020
```sql
SELECT d.year, SUM(sales_amount) AS revenue_Delhi_NCR
FROM transactions AS t
INNER JOIN date AS d
ON t.order_date = d.date
WHERE market_code= "Mark004" and d.year= 2020
GROUP BY d.year;
```
![Screenshot 2023-12-19 125122](https://github.com/SushantKG/Customer-Sales-Insights/assets/152982735/e268cbbb-83c3-4728-b265-67c060a0b458)



### Q8: Which store generated highest revenue in Delhi NCR in year 2020
```sql
SELECT d.year,c.custmer_name, SUM(sales_amount) AS Total_Revenue
FROM transactions AS t
INNER JOIN date AS d
ON t.order_date=d.date
INNER JOIN customers as c
ON t.customer_code= c.customer_code
WHERE market_code= "Mark004" and d.year=2020
GROUP BY d.year, c.custmer_name
ORDER BY SUM(sales_amount)DESC;
```
![Screenshot 2023-12-19 125229](https://github.com/SushantKG/Customer-Sales-Insights/assets/152982735/7f053aa7-667f-401a-879c-9ef93b2cd365)


### Q9: Show bestselling product codes from all stores in Delhi NCR in year 2020
```sql
WITH bestsellers AS
(
SELECT distinct c.custmer_name, d.year, t.product_code, COUNT(t.product_code) AS Total_Sales,
ROW_NUMBER() OVER(PARTITION BY custmer_name ORDER BY COUNT(t.product_code) DESC) AS row_no
FROM transactions AS t
INNER JOIN customers AS c
ON t.customer_code=c.customer_code
INNER JOIN date AS d
ON t.order_date=d.date
WHERE market_code= "Mark004" and d.year=2020
GROUP BY t.customer_code, d.year, t.product_code
ORDER BY COUNT(t.product_code) DESC
)
SELECT * FROM bestsellers WHERE row_no = 1 ;
```
![Screenshot 2023-12-19 125359](https://github.com/SushantKG/Customer-Sales-Insights/assets/152982735/7956caaf-70fa-4e17-9fdf-4442ab6cfdfe)


### 10: Which store generated highest revenue in Mumbai in year 2020 
```sql
SELECT d.year,c.custmer_name, SUM(sales_amount) AS Total_revenues
FROM transactions AS t
INNER JOIN date AS d
ON t.order_date=d.date
INNER JOIN customers as c
ON t.customer_code= c.customer_code
WHERE market_code= "Mark002" and d.year=2020
GROUP BY d.year, c.custmer_name
ORDER BY SUM(sales_amount)DESC
LIMIT 5;
```
![Screenshot 2023-12-19 125448](https://github.com/SushantKG/Customer-Sales-Insights/assets/152982735/5f2c5dbe-13d0-4e2c-b96b-731f2e26d944)


### Q11: Show bestselling product codes from all stores in Mumbai in year 2020 
```sql
WITH bestsellers AS
(
SELECT distinct c.custmer_name, d.year, t.product_code, COUNT(t.product_code) AS Total_sales,
ROW_NUMBER() OVER(PARTITION BY c.custmer_name ORDER BY COUNT(t.product_code) DESC) AS row_no
FROM transactions AS t
INNER JOIN customers AS c
ON t.customer_code=c.customer_code
INNER JOIN date AS d
ON t.order_date=d.date
WHERE market_code= "Mark004" and d.year=2020
GROUP BY t.customer_code, d.year, t.product_code
ORDER BY COUNT(t.product_code) DESC
)
SELECT * FROM bestsellers WHERE row_no = 1 ;
```
![Screenshot 2023-12-19 125545](https://github.com/SushantKG/Customer-Sales-Insights/assets/152982735/0cbfc6a2-c8ef-4365-8b85-e3e0b01314d5)
