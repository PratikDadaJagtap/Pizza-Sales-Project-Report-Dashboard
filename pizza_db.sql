------------------------------------------ Q . Total Revenue ------------------------------------------
select 
	sum(total_price)
from 
	pizza_sales

------------------------------------------ Q . average order value ------------------------------------------
select 
	sum(total_price) /  count(distinct order_id) as Avg_Order_Value
from 
	pizza_sales

------------------------------------------ Q . Total pizzas sold ------------------------------------------
select 
	sum(quantity) as Total_pizzas_sold 
from
	pizza_sales

------------------------------------------ Q . Total Orders ------------------------------------------
select
	 count(distinct order_id) as Total_Orders
from 
	pizza_sales

------------------------------------------ Q . average pizzas per orders ------------------------------------------
select
	cast(cast(sum(quantity) as decimal(10,2)) / cast(count(distinct order_id)as decimal(10,2))as decimal(10,2)) as avg_pizza_per_order
from 
	pizza_sales

------------------------------------------ Q . daily trend for total orders ------------------------------------------
select 
	DATENAME(DW, order_date) as order_day, count(distinct order_id)as total_orders
from
	pizza_sales
group by 
	DATENAME(DW, order_date)

------------------------------------------Q . Hourly trend for total orders ------------------------------------------
select 
	datepart(HOUR, order_time) as order_time, count(distinct order_id)as total_orders
from
	pizza_sales
group by 
	datepart(HOUR, order_time)
order by
	order_time

------------------------------------------ Q . percentage of sells by pizza category ------------------------------------------
select 
	pizza_category, 
	sum(total_price) as total_sales,
	sum(total_price) * 100/ (select sum(total_price) from pizza_sales ) as Total_Sales
from	
	pizza_sales
group by 
	pizza_category

------------------------------------------ Q . percentage of sells by pizza Size  ------------------------------------------
select 
	pizza_size, 
	cast(sum(total_price) * 100/ (select sum(total_price) from pizza_sales ) as decimal(10,2)) as percentage_by_sales
from	
	pizza_sales
group by 
	pizza_size

------------------------------------------ Q . total pizza sold by pizza category  ------------------------------------------
select 
	pizza_category,
	sum(quantity) as total_pizza_sold
from 
	pizza_sales
group by 
	pizza_category

------------------------------------------ Q . Top 5 best Sellers by Total pizzas sold  ------------------------------------------
select top 5
	pizza_name,
	sum(quantity) as total_pizza_sold
from 
	pizza_sales
group by 
	pizza_name 
order by 
	total_pizza_sold desc

------------------------------------------ Q . Bottom 5 worst sellers by total pizza sold  ------------------------------------------
select top 5
	pizza_name,
	sum(quantity) as total_pizza_sold
from 
	pizza_sales
group by 
	pizza_name 
order by 
	total_pizza_sold asc