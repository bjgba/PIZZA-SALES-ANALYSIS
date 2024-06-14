select *
from pizza


alter table pizza
alter column order_date date

--total revenue 
select sum(cast(total_price as decimal(10,2))) as totalrevenue
from pizza 
--avg order value
select round(sum(total_price)/count(distinct(order_id)),2) as Avgordervalue
from pizza
---total pizaa sold
select sum(quantity) as totalpizzasold
from pizza
--total orders
select count(distinct(order_id)) as totalorders 
from pizza
--AVG pizza per order
select round(sum(quantity)/count(distinct(order_id)),2) as avgpizzasold
from pizza
---chart requirement
---daily trend of total order
select datename(weekday,order_date)as day,count(order_id) as totalorder
from pizza
group by datename(weekday,order_date)
order by 1
--monthly trend of total order 
select datename(month,order_date) as month,COUNT(distinct(ORDER_ID)) as totalorder
from pizza
group by datename(month,order_date)

--percentage of sales by pizza category
with cte as
(
select pizza_category,sum(unit_price*total_price) as sales,(select  sum(unit_price*total_price) from pizza) as m
from pizza
group by pizza_category
)

select pizza_category,round((sales/m),2)*100  as percentage_of_pizza_sales
from cte

----percentage of sales by pizza size
select pizza_size,round(sum(total_price),3) as revenue,round((sum(total_price)/(select sum(total_price) from pizza))*100,3) as percentage_sales_by_pizza_size
from pizza 
group by pizza_size
--decimal convertion
select cast(sum(total_price) as decimal(10,2))
from pizza
----total pizza sold by pizza_category
select pizza_category,sum(quantity) as totalpizzasold
from pizza
group by pizza_category

---top 5 best seller by revenue 
select pizza_name_id,cast(sum(total_price) as decimal(10,2)) AS TOTALREVENUE
FROM PIZZA 
GROUP BY pizza_name_id
order by TOTALREVENUE 
offset 86 rows
fetch next 5 rows only
---top 5 best seller by total quantity
select top 5 pizza_name_id,sum(quantity) as totalunits
from pizza
group by pizza_name_id
order by totalunits desc

--top 5 best seller by total order
select top 5 pizza_name_id,count(DISTINCT(order_id)) as totalorder
from pizza
group by pizza_name_id
order by totalorder desc 

---bottom 5 best seller by revenue 
select top 5 pizza_name_id,cast(sum(total_price) as decimal(10,2)) AS TOTALREVENUE
FROM PIZZA 
GROUP BY pizza_name_id
order by TOTALREVENUE asc

---bottom 5 best seller by total quantity
select top 5 pizza_name_id,sum(quantity) as totalunits
from pizza
group by pizza_name_id
order by totalunits asc

--bottom 5 best seller by total order
select  top 5 pizza_name_id,count(distinct(order_id)) as totalorder
from pizza
group by pizza_name_id
order by totalorder asc

---hourly trend  of totalorder

select datepart(hour,order_time) as hour,count(DISTINCT(order_id)) as totalorder
from pizza 
group by datepart(hour,order_time)
order by hour asc


select *
from pizza

alter table pizza
alter column order_time time

