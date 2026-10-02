use orders_db;
select * from orders limit 10;
-- select * from orders;
-- select count(distinct Order_ID) from orders;
-- select Category, sum(Sales) as total_sales,
-- sum(Profit) as total_profit,(sum(Profit)/sum(Sales))*100 as profit_margin
-- from orders 
-- group by Category;

-- Check for missing/NULL values in key numeric columns
-- SELECT
--     SUM(Sales IS NULL) AS null_sales,
--     SUM(Profit IS NULL) AS null_profit,
--     SUM(Discount IS NULL) AS null_discount,
--     SUM(Quantity IS NULL) AS null_quantity
-- FROM orders;

-- Overall business summary (in millions where useful)
-- SELECT
--     COUNT(DISTINCT Order_ID)                       AS total_orders,
--     COUNT(DISTINCT Customer_ID)                    AS total_customers,
--     ROUND(SUM(Sales), 2)                           AS total_sales,
--     ROUND(SUM(Sales) / 1000000, 2)                 AS total_sales_millions,
--     ROUND(SUM(Profit), 2)                          AS total_profit,
--     ROUND(SUM(Profit) / SUM(Sales) * 100, 2)       AS profit_margin_pct,
--     ROUND(AVG(Discount), 2)                        AS avg_discount_pct,
--     SUM(Quantity)                                  AS total_units_sold
-- FROM orders;
 
-- Average order value (per distinct Order_ID)
-- SELECT ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2) AS avg_order_value
-- FROM orders;





-- Yearly sales & profit Trends
-- elect year(Order_Date) as order_year,
-- round(sum(Sales),2) as total_Sales,
-- round(sum(Profit),2) as total_profit,
-- count(distinct Order_ID) as num_order 
-- from orders
-- group by year(Order_Date)
-- order by order_year;

-- Monthly Sales trend(across all years)
-- select
-- date_format(Order_Date,'%Y-%m') as order_month,
-- round(sum(Sales),2) as total_Sales,
-- round(sum(Profit),2) as total_profit
-- from orders
-- group by date_format(Order_Date,'%Y-%m')
-- order by order_month;
 
-- --Seasonality: average sales by calendar month (Jan-Dec, all years combined)
-- Select
-- monthname(Order_Date) as month_name,
-- month(Order_Date) as month_num,
-- round(sum(Sales),2) as total_sales
-- from orders
--   group by monthname(Order_Date),month(Order_Date)
--   order by month_num

-- Year-over-year growth (using window function)
-- Select
--    order_year,
--    total_sales,
--    LAG(total_sales)  OVER(ORDER by order_year) as prev_year_sales,
--    Round((total_sales - LAG(total_sales)  OVER(ORDER by order_year))/
--          LAG(total_sales)  OVER(ORDER by order_year)* 100,2) as YOY_growth_pct
-- from(
--      SELECT YEAR(Order_Date) as order_year, sum(Sales) as total_sales
--      from orders
--      group by YEAR(Order_Date)
-- 	) yearly;
 
###CATEGORY & SUB-CATEGORY PERFORMANCE
-- Sales & profit by category
-- SELECT
--     Category,
--     ROUND(SUM(Sales), 2)   AS total_sales,
--     ROUND(SUM(Profit), 2)  AS total_profit,
--     ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct,
--     SUM(Quantity)          AS units_sold
-- FROM orders
-- GROUP BY Category
-- ORDER BY total_sales DESC;

-- Sales & profit by sub-category
-- SELECT
--     Category,Sub_Category,
--     ROUND(SUM(Sales), 2)   AS total_sales,
--     ROUND(SUM(Profit), 2)  AS total_profit
-- FROM orders
-- GROUP BY Category,Sub_Category
-- ORDER BY total_sales DESC;


-- Sub-categories that are LOSING money overall
--  SELECT
--     Sub_Category,
--     ROUND(SUM(Sales), 2)   AS total_sales,
--     ROUND(SUM(Profit), 2)  AS total_profit
-- FROM orders
-- GROUP BY Sub_Category
-- having sum(Profit)<0
-- ORDER BY total_Profit ASC;


#### REGIONAL / GEOGRAPHIC PERFORMANCE
-- Sales & profit by region
-- SELECT
--     Region,
--     Sum(Sales) as total_sales,
--     sum(Profit) as total_profit
-- from orders
-- group by Region
-- order by total_sales desc;

-- Top 10 states by sales
-- SELECT 
--     State_Province,
--     sum(Sales) as total_sales,
--     sum(Profit) as total_profit
-- from orders
-- group by State_Province
-- order by total_sales desc limit 10;

-- Top 10 cities by sales & profit
-- SELECT 
--     City,
--     sum(Sales) as total_sales,
--     sum(Profit) as total_profit
-- from orders
-- group by City
-- order by total_sales desc limit 10;


-- States with negative overall profit (problem areas)
-- SELECT 
--     State_Province,
--     sum(Sales) as total_sales,
--     sum(Profit) as total_profit
-- from orders
-- group by State_Province
-- having sum(Profit)<0
-- order by total_sales ASC;

###CUSTOMER ANALYSIS
-- Top 10 customers by total sales
-- SELECT
--    Customer_ID,
--    Customer_Name,
--    Round(Sum(Sales),2) as total_sales,
--    Round(sum(Profit),2) as total_profit
-- from orders
-- group by Customer_ID,Customer_Name
-- order by total_sales desc
-- limit 10;

-- Sales & profit by customer segment
-- SELECT
--     Segment,
--    Round(Sum(Sales),2) as total_sales,
--    Round(sum(Profit),2) as total_profit,
--    COUNT(distinct Customer_ID) as num_customers
-- from orders
-- group by Segment
-- order by total_sales desc

-- Customer purchase frequency (number of orders per customer)
-- SELECT
--     Customer_ID,
--     Customer_Name,
--     count(distinct Order_ID) as order_num,
--    Round(Sum(Sales),2) as total_sales,
--    Round(sum(Profit),2) as total_profit
-- from orders
-- group by Customer_ID,Customer_Name
-- order by order_num desc
-- limit 10;

-- One-time buyers vs repeat customers(In this We use CASE Method)
-- SELECT
--     CASE WHEN order_count=1 THEN 'One-Time Buyers' ELSE 'Repeated Customers' 
--     END as customer_type,
--     count(*) AS customer_nums
-- from(
--     SELECT Customer_ID,count(distinct Order_ID) as order_count
-- from orders
-- group by Customer_ID
-- ) t
-- group by customer_type

###PRODUCT ANALYSIS
-- Top 10 best-selling products by sales
-- SELECT 
--     Product_ID,
--     Product_Name,
--     Round(Sum(Sales),2) as total_sales,
--     count(Quantity) as unit_sold,
--      Round(Sum(Profit),2) as total_profit
-- from orders
-- group by Product_ID,Product_Name
-- order by total_sales desc
-- limit 10;

-- -- Top 10 most profitable products
-- SELECT 
--     Product_ID,
--     Product_Name,
--     Round(Sum(Profit),2) as total_profit,
--     Round(Sum(Sales),2) as total_sales,
--     count(Quantity) as unit_sold
-- from orders
-- group by Product_ID,Product_Name
-- order by total_profit desc
-- limit 10;

-- Bottom 10 products (biggest losses)
-- SELECT 
--     Product_ID,
--     Product_Name,
--     Round(Sum(Profit),2) as total_profit,
--     Round(Sum(Sales),2) as total_sales
-- from orders
-- group by Product_ID,Product_Name
-- having sum(Profit)<0
-- order by total_profit ASC
-- limit 10;

-- Most frequently ordered products (by number of orders, not quantity)
-- SELECT 
--     Product_ID,
--     Product_Name,
--     count(distinct Order_ID) as times_ordered
-- from orders
-- group by Product_ID,Product_Name
-- order by times_ordered DESC
-- limit 10;


###DISCOUNT IMPACT ANALYSIS
-- Average discount and its relationship to profit, bucketed
-- SELECT 
--     CASE
-- 		WHEN Discount=0 THEN '0%'
--         WHEN Discount<=20 THEN '1-20%'
--         WHEN Discount<=40 THEN '21-40%'
--         WHEN Discount<=60 THEN '41-60%'
--         ELSE '60%+'
--      END AS discount_band,
--      COUNT(*) as num_lines_item,
--      Round(Sum(Sales),2) as total_sales,
--      Round(Sum(Profit),2) as total_profit,
--      Round(AVG(Profit),2) as avg_profit_per_item
-- from orders
-- group by discount_band
-- order by discount_band;

-- Orders that sold at a loss (negative profit), and whether discount was involved
-- SELECT
--    Order_ID,Product_Name,Sales,
--    Discount,Profit
-- from orders
-- Where Profit<0
-- order by Profit ASC
-- limit 20;

-- Correlation check: does higher discount generally mean lower profit margin?
-- SELECT
--     Discount,
--     Round(AVG(Profit / NULLIF(Sales,0)) * 100, 2) as avg_margin_pct 
-- from orders
-- group by Discount
-- order by Discount;


###SHIPPING ANALYSIS
-- Orders and average delivery time by ship mode
-- SELECT 
--     Ship_Mode,
--     COUNT(distinct Order_ID) as order_num,
--     Round(AVG(DATEDIFF(Ship_Date, Order_Date)),1)  as avg_days_to_ship,
--     Round(sum(Sales),2)  as total_sales
-- from orders
-- group by Ship_Mode
-- order by order_num desc;

-- Distribution of shipping delay (days between order and ship date)
-- SELECT 
--     DATEDIFF(Ship_Date, Order_Date) as days_to_ship,
--     count(*) as order_num,
--     Round(Sum(Profit),2) as total_profit
-- from orders
-- group by DATEDIFF(Ship_Date, Order_Date)
-- order by days_to_ship ;

    
###ADVANCED / WINDOW FUNCTION EXAMPLES
-- Running total of sales over time (monthly)
-- SELECT
--      order_month,
--      monthly_sales,
--      sum(monthly_sales) OVER (ORDER BY order_month) as running_total_sales
-- From(
--     SELECT  DATE_FORMAT(Order_Date , '%Y-%m') as order_month,
--            sum(Sales) as monthly_sales
--     from orders 
--     group by DATE_FORMAT(Order_Date , '%Y-%m')
-- ) monthly;

-- Rank sub-categories by sales within each category
-- SELECT 
--      Category,
--      Sub_Category,
--      Round(Sum(Sales),2) as total_sales,
--      Round(sum(profit),2) as total_profit,
--      RANK() OVER(PARTITION BY Category ORDER BY sum(Sales) DESC) as rank_in_category
-- from orders
-- group by Category,Sub_Category
-- order by  Category,rank_in_category

-- Each customer's contribution % to total company sales
-- SELECT 
--      Customer_ID,
--      Customer_Name,
--      Round(Sum(Sales),2) as customer_sales,
--      Round(sum(Sales) / (SELECT sum(Sales) from orders) *100 ,3) as pct_of_total_sales,
--      Round(sum(Profit) / (SELECT sum(Profit) from orders) *100 ,3) as pct_of_total_profit
-- from orders
-- group by Customer_ID, Customer_Name
-- order by  customer_sales desc
-- limit 10;

-- Top-selling product within each category (using window function)
SELECT Category,Product_Name,total_sales
from(
     SELECT
           Category,
            Product_Name,
     Round(Sum(Sales),2) as total_sales,
     RANK() OVER(PARTITION BY Category ORDER BY sum(Sales) DESC) as rn
from orders
group by Category,Product_Name
)ranked
WHERE rn=1
