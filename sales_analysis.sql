-- selecting the database

use piza_sales_project;

-- 1. What are top 3 values of total invoice?

SELECT *
FROM invoice
ORDER BY total DESC
LIMIT 3;

--2. Total Revenue: Calculates the total revenue generated from pizza orders

SELECT SUM(total_price) AS total_revenue
FROM pizza_sales;

--3. Most Popular Pizza Names: Find the top 5 most ordered pizza names

SELECT TOP 5 pizza_name, COUNT(pizza_name) AS order_count
FROM pizza_sales
GROUP BY pizza_name
ORDER BY order_count DESC;

--4. Average Order Quantity: Calculate the average quantity of pizzas per order

SELECT AVG(quantity) AS avg_order_quantity
FROM pizza_sales;


--5. Frequently Used Ingredients: Find the top 5 most frequently used pizza ingredients

SELECT TOP 5 pizza_ingredients, COUNT(pizza_ingredients) AS ingredient_count
FROM pizza_sales
GROUP BY pizza_ingredients
ORDER BY ingredient_count DESC;


--6. Total Revenue per Pizza Category

SELECT pizza_category, SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_category;

--7. Average Order Value by Pizza Size

SELECT pizza_size, AVG(total_price) AS avg_order_value
FROM pizza_sales
WHERE YEAR(order_date) = 2015
GROUP BY pizza_size;

--8.Daily Order Trends: Analyze daily order volume for the last 30 days

SELECT CAST(order_date AS DATE) AS order_day, COUNT(order_id) AS order_count
FROM pizza_sales
WHERE order_date >= '2015-12-01' AND order_date < '2016-01-01'
GROUP BY CAST(order_date AS DATE)
ORDER BY order_day;

--9.Revenue Growth by Month

SELECT YEAR(order_date) AS year, MONTH(order_date) AS month,
    SUM(total_price) AS monthly_revenue,
    LAG(SUM(total_price)) OVER (ORDER BY YEAR(order_date), MONTH(order_date)) AS previous_month_revenue
FROM pizza_sales
WHERE YEAR(order_date) = 2015
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);


--10.List the top 10 pizza names with the highest total sales (quantity * unit price)

SELECT pizza_name, total_sales
FROM (
    SELECT
        pizza_name,
        SUM(quantity * unit_price) AS total_sales,
        ROW_NUMBER() OVER (ORDER BY SUM(quantity * unit_price) DESC) AS row_num
    FROM pizza_sales
    GROUP BY pizza_name
) AS ranked
WHERE row_num <= 10;

