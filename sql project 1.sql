create database sql_project1;


#Database Setup


create table sq_analysis(
 transactions_id int,
 sale_date date,
 sale_time time,
 customer_id int,
 gender varchar(50),
 age int,
 category varchar(50),
 quantiy int,
 price_per_unit float,
 cogs float,
total_sale float





);
 select count(*) from  sq_analysis;
 
 #Data Exploration & Cleaning
 
 
SELECT * FROM sq_analysis
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
     
     
delete from sq_analysis;   


select * from sq_analysis  ;

select count(distinct transactions_id) from sq_analysis;
select distinct category  from sq_analysis;

-- data analyze finding

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from sq_analysis
where 
sale_date='2022-11-05';

-- 2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022


SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4;
    
-- 3 Write a SQL query to calculate the total sales (total_sale) for each category.    
    
select  category,
sum(total_sale) as net_sale,
count(*) as total_sale
from
sq_analysis
group by 1;

-- 4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),2) as avg_age
from sq_analysis
where category="Clothing";

-- 5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select total_sale from sq_analysis
where total_sale>1000;

-- 6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
  
 select category,
 gender,
 count(*) as transation_id
 from
 sq_analysis
 group by
 category,gender
 order by 1;
 
 -- 7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
 select
 year,
 month,
 avg_sale
 from
 
 (
   select
   extract(year from sale_date) as year,
   extract(month from sale_date) as month,
   avg(total_sale) as avg_sale,
   rank() over (partition by extract(year from sale_date)order by avg(total_sale) desc) 
   from sq_analysis
   group by 1,2
   ) as t1;
   
   -- 8 **Write a SQL query to find the top 5 customers based on the highest total sales **
   
   select customer_id,
   sum(total_sale) as total_sale
   from sq_analysis
   group by
   1 order by 2 desc
   limit 5;
   
-- 9 Write a SQL query to find the number of unique customers who purchased items from each category
   
select catagory,count(distinct customer_id) 
from sq_analysis
group by category;
   
-- 10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales;

SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;
   

select extract(hour from current_time);


