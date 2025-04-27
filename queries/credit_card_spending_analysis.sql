
-- 1 write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 

    WITH city_spend_summary AS (
    SELECT 
        city, 
        SUM(amount) AS total_spend_by_city
    FROM credit_card_transcations
    GROUP BY city
),
city_spend_with_percentage AS (
    SELECT 
        city, 
        total_spend_by_city,
        ROUND((total_spend_by_city * 100.0 / SUM(total_spend_by_city) OVER()), 2) AS spend_percentage_numeric,
        CONCAT(ROUND((total_spend_by_city * 100.0 / SUM(total_spend_by_city) OVER()), 2), '%') AS spend_percentage_formatted
    FROM city_spend_summary
)
SELECT 
    city,
    total_spend_by_city,
    spend_percentage_formatted AS spend_percentage
FROM city_spend_with_percentage
ORDER BY total_spend_by_city DESC
LIMIT 5;

-- *** Second Method ***

with cte1 as (
select city,sum(amount) as total_spend
from credit_card_transcations
group by city)
,total_spent as (select sum(amount) as total_amount from credit_card_transcations)
select cte1.*, round(total_spend*1.0/total_amount * 100,2) as percentage_contribution from 
cte1 inner join total_spent on 1=1
order by total_spend desc
limit 5;



-- 2- write a query to print highest spend month and amount spent in that month for each card type

WITH card_type_monthly_spend AS (
    SELECT 
        card_type, 
        YEAR(transaction_date) AS spend_year,
        MONTH(transaction_date) AS spend_month,
        SUM(amount) AS total_spend
    FROM credit_card_transcations
    GROUP BY 
        card_type, 
        YEAR(transaction_date), 
        MONTH(transaction_date)
)

SELECT *
FROM (
    SELECT 
        *, 
        RANK() OVER(PARTITION BY card_type ORDER BY total_spend DESC) AS spend_rank
    FROM card_type_monthly_spend
) ranked_spend
WHERE spend_rank = 1;

-- 3- write a query to print the transaction details (all columns from the table) for each card type when it reaches 
--   a cumulative of 1000000 total spends (We should have 4 rows in the o/p one for each card type)
WITH transaction_cumulative_spend AS (
    SELECT 
        *, 
        SUM(amount) OVER(PARTITION BY card_type ORDER BY transaction_date, transaction_id) AS total_spend    
    FROM credit_card_transcations
),
ranked_transactions AS (
    SELECT 
        *, 
        RANK() OVER(PARTITION BY card_type ORDER BY total_spend ASC) AS rnk 
    FROM transaction_cumulative_spend
    WHERE total_spend >= 1000000
)
SELECT 
    *
FROM 
    ranked_transactions
WHERE 
    rnk = 1;

-- 4- write a query to find city which had lowest percentage spend for gold card type.

WITH city_card_summary AS (
    SELECT 
        city,
        card_type,
        SUM(amount) AS city_card_type_amount,
        SUM(CASE WHEN card_type = 'Gold' THEN amount END) AS gold_amount
    FROM credit_card_transcations
    GROUP BY 
        city, 
        card_type
)

SELECT 
    city,
    SUM(gold_amount) * 1.0 / SUM(city_card_type_amount) AS gold_ratio
FROM 
    city_card_summary
GROUP BY 
    city
HAVING 
    SUM(gold_amount) IS NOT NULL
ORDER BY 
    gold_ratio ASC
LIMIT 1;
  
-- 5- write a query to print 3 columns: city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)

WITH city_expense_summary AS (
    SELECT 
        city,
        exp_type,
        SUM(amount) AS total_amount
    FROM 
        credit_card_transcations
    GROUP BY 
        city, 
        exp_type
)

SELECT 
    city,
    MIN(CASE WHEN asc_rnk = 1 THEN exp_type END) AS lowest_exp_type,
    MAX(CASE WHEN desc_rnk = 1 THEN exp_type END) AS highest_exp_type
FROM (
    SELECT 
        *,
        RANK() OVER(PARTITION BY city ORDER BY total_amount ASC) AS asc_rnk,
        RANK() OVER(PARTITION BY city ORDER BY total_amount DESC) AS desc_rnk
    FROM 
        city_expense_summary
) ranked_data
GROUP BY 
    city;

-- 6- write a query to find percentage contribution of spends by females for each expense type

SELECT 
    exp_type,
    SUM(CASE WHEN gender = 'F' THEN amount ELSE 0 END) * 100.0 / SUM(amount) AS female_percentage_contribution
FROM 
    credit_card_transcations
GROUP BY 
    exp_type
ORDER BY 
    female_percentage_contribution DESC;

-- 7- which card and expense type combination saw highest month over month percantage growth in Jan-2014.

WITH cte AS (
    SELECT 
        card_type,
        exp_type,
        YEAR(transaction_date) AS year_num,
        MONTH(transaction_date) AS month_num,
        SUM(amount) AS total_spend
    FROM 
        credit_card_transcations
    GROUP BY 
        card_type, 
        exp_type, 
        YEAR(transaction_date), 
        MONTH(transaction_date)
)

SELECT 
    *,
    (total_spend - prev_month_spend) * 100.0 / prev_month_spend AS mom_growth
FROM (
    SELECT 
        *, 
        LAG(total_spend, 1) OVER(PARTITION BY card_type, exp_type ORDER BY year_num, month_num) AS prev_month_spend
    FROM 
        cte
) AS a
WHERE 
    prev_month_spend IS NOT NULL 
    AND year_num = 2014 
    AND month_num = 1
ORDER BY 
    mom_growth DESC
LIMIT 1;

-- 8- during weekends which city has highest total spend to total no of transcations ratio 

select city,
	   sum(amount)*1.0/count(*) as transcation_ratio
from credit_card_transcations
where dayofweek(transaction_date) in (1,7)
group by city
order by transcation_ratio desc
limit 1;

-- 9- which city took least number of days to reach its 500th transaction after the first transaction in that city
WITH transaction_ranks AS (
    SELECT 
        *, 
        ROW_NUMBER() OVER(PARTITION BY city ORDER BY transaction_date) AS rnk
    FROM credit_card_transcations
)
SELECT 
    city,
    DATEDIFF(MAX(transaction_date), MIN(transaction_date)) AS day_difference
FROM (
    SELECT *
    FROM transaction_ranks
    WHERE rnk = 1 OR rnk = 500
) city_transactions
GROUP BY city
HAVING COUNT(*) > 1
ORDER BY day_difference 
LIMIT 1;

