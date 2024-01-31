SELECT*FROM public."custChurn"
select * from public."custChurn" limit 5;

SELECT * FROM public."custChurn" WHERE credit_score IS NULL;
SELECT * FROM public."custChurn" WHERE age IS NULL;
SELECT * FROM public."custChurn" WHERE balance IS NULL;
SELECT * FROM public."custChurn" WHERE estimated_salary IS NULL;
SELECT * FROM public."custChurn" WHERE tenure IS NULL;
SELECT * FROM public."custChurn" WHERE country IS NULL;
SELECT * FROM public."custChurn" WHERE gender IS NULL;
SELECT * FROM public."custChurn" WHERE products_number IS NULL;
SELECT * FROM public."custChurn" WHERE credit_card IS NULL;
SELECT * FROM public."custChurn" WHERE active_member IS NULL;
SELECT * FROM public."custChurn" WHERE churn IS NULL;

select distinct gender,count(gender) as total_num from public."custChurn" group by gender; 
select distinct country, count(country) as total_num from public."custChurn" group by country;

select
	'credit_score' as numeric_column_name,
	avg(credit_score) as mean,
	(select credit_score from public."custChurn" group by credit_score order by count(*) desc limit 1) as mode,
	stddev_samp(credit_score) as sd,
	min(credit_score) as min,
	max(credit_score) as max
from public."custChurn"
union all
select
	'age' as numeric_column_name,
	avg(age) as mean,
	(select age from public."custChurn" group by age order by count(*)desc limit 1) as mode,
	stddev_samp(age) as sd,
	max(age) as max,
	min(age) as min
from public."custChurn"
union all
select 
	'balance' as numreric_column_name,
	avg(balance) as mean,
	(select balance from public."custChurn" group by balance order by count(*)desc limit 1)as mode,
	stddev_samp(balance) as sd,
	max(balance) as max,
	min(age) as min
from public."custChurn"
union all
select 
	'tenure' as numeric_column_name,
	avg(tenure) as mean,
	(select tenure from public."custChurn" group by tenure order by count(*)desc limit 1)as mode,
	stddev_samp(tenure) as sd,
	max(tenure) as max,
	min(age) as min
from public."custChurn"
union all
SELECT
    'estimated_salary' AS numeric_column_name,
    AVG(estimated_salary) AS mean,
    (SELECT estimated_salary FROM public."custChurn" GROUP BY estimated_salary ORDER BY COUNT(*) DESC LIMIT 1) AS mode,
    STDDEV_SAMP(estimated_salary) AS sd,
    MAX(estimated_salary) AS max,
    MIN(estimated_salary) AS min
FROM public."custChurn";

select
case
	when credit_score between 100 and 200 then '100-200'
	when credit_score between 200 and 300 then '200-300'
	when credit_score between 300 and 400 then '300-400'
	when credit_score between 400 and 500 then '400-500'
	when credit_score between 500 and 600 then '500-600'
	when credit_score between 600 and 700 then '600-700'
	when credit_score between 700 and 800 then '700-800'
	when credit_score between 800 and 900 then '800-900'
	when credit_score between 900 and 1000 then '900-1000'
	else 'others'
	end as credit_score_range,
	country,
	count(*) as count_all
from public."custChurn"
group by credit_score_range,country
order by country,count_all desc;

select count(*) from public."custChurn"

select percentile_disc(0.5) within group (order by credit_score) as median from public."custChurn"

select
	gender,
	/* avg(estimated_salary) as average_salary,*/
	avg(balance) as average_bal,
	case
	when churn=0 then 'stayed'
	when churn =1 then 'not stayed'
	end as churn_status,
	count(*) as total_customer
from public."custChurn"
group by churn_status,gender;

select churn,credit_card,
	case
	when age between 10 and 20 then '10-20'
	when age between 20 and 30 then '20-30'
	when age between 30 and 40 then '30-40'
	when age between 40 and 50 then '40-50'
	when age between 50 and 60 then '50-60'
	when age between 60 and 70 then '60-70'
	when age between 70 and 80 then '70-80'
	when age between 80 and 90 then '80-90'
	when age between 90 and 100 then '90-100'
	else 'others'
	end as age_range,
	count(*) as frequency
from public."custChurn"
group by age_range,churn,credit_card
order by credit_card,churn,frequency desc;

select churn, active_member,country, 
count(*) as total_number	
from public."custChurn"
group by churn, active_member, country
order by country, total_number desc;

select * from(
	select
	customer_id, credit_score,churn,
	(balance/estimated_salary) as balance_to_salary_ratio
	from public."custChurn"
	where estimated_salary>600 and balance>0
	order by credit_score) t
	order by t.balance_to_salary_ratio asc
limit 10;

select * from (
	select 
	customer_id,credit_score , churn,
	(balance/estimated_salary) as balance_to_salary_ratio 
	from public."custChurn" 
	where credit_score>600 and balance > 0 
	order by credit_score desc) t
where t.balance_to_salary_ratio > 10
order by t.balance_to_salary_ratio desc
limit 15;

select avg(churn) as overall_churn_rate
from public."custChurn"

select gender,country,avg(churn) as churn_rate
from public."custChurn"
group by country,gender;

select products_number,avg(churn) as churn_rate
from public."custChurn"
group by products_number;

select tenure, avg(churn) as churn_rate
from public."custChurn"
group by tenure
order by churn_rate,tenure;



