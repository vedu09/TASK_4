-- CREATION OF DATABASE 
create database ecommerce;

-- USE DATABASE 
use ecommerce;

-- INSERT CSV FILE INTO TABLE (superstore)

-- RETRIVE DATA FROM TABLE
select * from superstore;


-- QUERIES

-- Q1. Which 10 products generated the highest sales revenue? 
select Product_ID, Product_Name, sum(sales) as Total_Sales
from superstore
group by Product_ID,Product_Name 
order by  Total_Sales desc
limit 10;

-- Q2. Who were 10 cutomers those generated the highest sales revenue? 
SELECT Cust_ID,Cust_Name,sum(Sales) as Total_Sales
FROM superstore
group by Cust_ID,Cust_Name
ORDER BY Total_Sales Desc
limit 10;


-- Q3. Which region generated highest sales revenue?
select Region,sum(Sales) as Total_Sales, sum(Profit) as Total_Profit
from superstore
group by Region
order by Total_Sales desc;

-- Q4. List all orders from the "Corporate" segment placed after '2024-01-01'
select *
from superstore
where Segment = "Corporate" and Order_Date >= '2024-01-01';

--  Q5. Which product categories have the highest profit? --  
select Category,sum(Profit) as Total_Profit
from superstore
group by Category
order by Total_Profit desc;


-- Q6. Which cities had total sales greater than ₹50,000 -- 
select City, sum(Sales) as Total_Sales
from superstore
group by City
having Total_Sales > 50000
order by Total_Sales desc;



-- Q7. List all orders with a discount greater than 20%, ordered by profit/loss.
SELECT Order_ID, Order_Date, Cust_ID, Cust_Name, Sales, Discount, Profit
FROM superstore
WHERE Discount > 0.20
ORDER BY Profit DESC;


-- Q8. List Customers with Above-Average Sales  
SELECT Cust_ID, Cust_Name, SUM(Sales) AS total_sales
FROM superstore
GROUP BY Cust_ID, Cust_Name
HAVING SUM(Sales) > (
    SELECT AVG(total_sales)
    FROM (
        SELECT SUM(Sales) AS total_sales
        FROM superstore
        GROUP BY Cust_ID
    ) t
);


-- Q9. List categories where total profit is higher than the profit of the ‘Furniture’ category.
SELECT Category, SUM(Profit) AS total_profit
FROM superstore
GROUP BY Category
HAVING SUM(Profit) > (
    SELECT SUM(Profit)
    FROM superstore
    WHERE Category = 'Furniture'
)
ORDER BY total_profit DESC;
 
 
 -- Q10. List Category by its Average Discount
SELECT Category, AVG(Discount) AS avg_discount
FROM superstore
GROUP BY Category;


-- Q11. Calculate total sales, no. of orders, and total profit for each region.
select Region, sum(Sales) as Total_Sales, count(Order_ID) as Total_Orders, sum(Profit) as Total_Profit
from superstore
group by Region;



-- Q12. View -> state_profit_summary 
-- showing each state, total sales, total profit, and profit margin.
CREATE VIEW state_profit_summary AS
SELECT
    State,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    -- Profit Margin as percentage of sales
    CASE
        WHEN SUM(Sales) = 0 THEN 0
        ELSE (SUM(Profit) / SUM(sales)) * 100
    END AS profit_margin_percent
FROM superstore
GROUP BY State;

select * from state_profit_summary;

