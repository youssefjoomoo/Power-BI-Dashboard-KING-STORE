--select *
--from dbo.[gold.fact_sales]


select new_date ,
 total_sales_amount ,
 SUM(total_sales_amount) over (order by new_date) as runing_salse ,
  SUM(total_sales_amount) over (partition by year(new_date)
  order by new_date) as runing_salse

from
(
select DATETRUNC(MONTH,order_date) as [new_date],
      -- year(order_date) as year ,--
      -- month(order_date) as month ,--
       sum (sales_amount)  as [total_sales_amount],
       sum (quantity)      as [total_quantity],
       COUNT (DISTINCT( customer_key)) as [count of customer]
from dbo.[gold.fact_sales]
where order_date is not null
group by DATETRUNC(MONTH,order_date)
)t