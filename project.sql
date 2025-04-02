create database project;


 select * from bank_churn;
 
 -- total number of customers
 select count(Surname) as sum_customers from bank_churn;
 select count(Gender) from bank_churn
 where Gender= "female";
 
 select count(Gender) from bank_churn
 where Gender= "male";
 
 select distinct Geography from bank_churn;
 select CustomerId, concat(sum(Balance),"$") as customer_balance from bank_churn
 group by CustomerId;
 select concat(round(sum(Balance),2),"$") from bank_churn;
 select concat(round(sum(EstimatedSalary),2),"$") from bank_churn;
 
 select CustomerId, concat(sum(EstimatedSalary),"$") as customers_salary from bank_churn
 group by CustomerId;
 
 -- Ensuring that all data was imported into SQL
  select  count(*) from bank_churn;
  -- 1. to check for duplicate
  
  select CustomerId, Surname, CreditScore, Geography, Gender,Age, count(*) from bank_churn
  group by CustomerId, Surname, CreditScore, Geography, Gender,Age
  having count(*) >=1;

  
  -- 2. attributes of   credit score, balance, tenure, number of products to the churn rate
  select min(CreditScore) from bank_churn;
  select max(CreditScore) from bank_churn;
  
 with cte as  (Select*, ntile(3) over (partition by Balance order by CreditScore desc) as bucket_score, 
case
												when CreditScore <= 400 then "low"
                                                when CreditScore <= 600 then "mid"
                                                else "high"
                                                end as creditscore_category from bank_churn)
  select CreditScore_category, concat(round(count(exited) *100/(select count(*) from cte where exited = 1),2), "% ")	 as percentage_credit from cte
  where exited = 1
  group by CreditScore_category;
  
  alter table  bank_churn
  add column Creditscore_Segment text;
set sql_safe_updates=0;

update bank_churn
set Creditscore_Segment= case           
                               when CreditScore <= 400 then "low"
							   when CreditScore <= 600 then "mid"
							   else "high" end;
                               
                               select* from bank_churn;
  
 -- Gender
select Gender,concat(round(count(Exited)*100/(select count(*)from bank_churn where Exited=1),2), "% ") as Gender_Exited from bank_churn 
where Exited=1
group by gender;

  
 select Balance, count(Exited) as balance_exited from bank_churn
 where Exited = 1
 group by Balance order by balance_exited desc;
 
 select Balance,concat(round(count(Exited)*100/(select count(*)from bank_churn where Exited=1),2), "% ") as Balance_Exited from bank_churn 
where Exited=1
group by Balance order by Balance_Exited;
 
 select Tenure,concat(round(count(Exited)*100/(select count(*)from bank_churn where Exited=1),2), "% ") as Tenure_Exited from bank_churn 
where Exited=1
group by Tenure order by Tenure_Exited desc;
 
 
 
select NumOfProducts ,concat(round(count(Exited)*100/(select count(*)from bank_churn where Exited=1),2), "% ") as NumOfProduct_Exited from bank_churn 
where Exited=1
group by NumOfProducts order by NumOfProduct_Exited desc;



select HasCrCard , count(HasCrCard) from bank_churn
 where Exited =1
 group by HasCrCard;
 
 select HasCrCard  ,concat(round(count(Exited)*100/(select count(*)from bank_churn where Exited=1),2), "% ") as HasCrCard_Exited from bank_churn 
where Exited=1
group by HasCrCard order by HasCrCard_Exited desc;
 
 -- 3. What is the overall churn rate? How does it vary across demographics?
 select Exited, count(Exited) as no_exited from bank_churn
 where Exited =1 
 group by Exited;
 -- overall churn rate
 with cte as (select count(*) as total_count, sum(exited) as total_churn from bank_churn)
 select concat("%",(total_churn*100/total_count)) as percentage_churn from cte;
 
 select Exited, count(Exited) as total_retained from bank_churn
 where Exited =0 
 group by Exited;
 
 -- REMAING CUSTOMERS BY GENDER
 select Gender,count(Exited) as gender_remaining from bank_churn
 where Exited =0
 group by Gender;
 
 with cte as (select count(*) as total_count, sum(exited) as total_retained from bank_churn where Exited =0)
 select concat("%",(total_retained*100/total_count)) as percentage_retained from cte;
 
 -- Geography
 
 select Geography, concat(round(count(Exited)*100/(select count(*) from bank_churn where Exited=1),2),"% ") as overall_churn_rate from bank_churn
 where Exited =1
 group by Geography order by overall_churn_rate DESC;
 
 
 
 -- 4 Grouping of customers into segment based on their banking behaviour(high balance,multiple product)
 -- Balance
 select min(Balance) from bank_churn;
 select max(Balance) from bank_churn;
 select  Balance , 
                               case when Balance <=100000 then "low"
                               else "high" end as products_balance from bank_churn;
  select min(NumOfProducts) from bank_churn;
  select max(NumOfProducts) from bank_churn;
 -- Balance 
with cte as (Select*, ntile(4) over( order by Balance asc) as numer from bank_churn)
select Balance,  case
												when Balance= 0 then "low_income_customer"
                                                when Balance =1 then "average_income_customer"
                                                when Balance =2 then"normal_income_customer"
                                                when Balance =3 then "good_income_customer"
                                                else "high_income_customer"
                                                end as customer from cte;
                                                
-- NumOfProduct                                                
  with cte as (Select*, ntile(4) over( order by NumOfProducts asc) as numer from bank_churn)
select NumOfProducts,  case
												when NumOfProducts= 0 then "low_income_customer"
                                                when NumOfProducts =1 then "average_income_customer"
                                                when NumOfProducts=2 then"normal_income_customer"
                                                when NumOfProducts=3 then "good_income_customer"
                                                else "high_income_customer"
                                                end as NumOfProducts from cte;
                                                
-- Isactive member
   with cte as (Select*, ntile(2) over( order by IsActiveMember asc) as numer from bank_churn)
select IsActiveMember,  case
												when IsActiveMember= 0 then "low_income_customer"
                                                else "high_income_customer"
                                                
                                                end as IsActiveMember from cte;


select * from bank_churn;
 alter table bank_churn
 add column customers_grade text;
  update bank_churn
  set customers_grade = NumOfProducts + HasCrCard +IsActiveMember;

-- with cte as (select * , 
-- 			   ntile(4) over (order by Balance asc) as Score_Balance,
--             ntile(4) over (order by Tenure  asc) as Score_Tenure,
--             ntile(4) over (order by customers_grade asc) as customers_score from bank_churn)
-- -- 	select *, Score_Balance+Score_Tenure+customers_score as customers_segment_1 from cte
  


UPDATE bank_churn
JOIN (
    SELECT 
        CustomerId,
        (NTILE(4) OVER (ORDER BY Balance ASC) + 
         NTILE(4) OVER (ORDER BY Tenure ASC) + 
         NTILE(4) OVER (ORDER BY customers_grade ASC)) AS customers_segment_1
    FROM bank_churn
) AS cte ON bank_churn.CustomerId = cte.CustomerId
SET bank_churn.Customers_Segment_1 = cte.customers_segment_1;
 -- 4      
select Customers_Segment_2, count(Customers_Segment_2) as score_count from bank_churn
group by Customers_Segment_2;


select * from bank_churn;     

alter table bank_churn
drop column Customers_Segment ;     


alter table bank_churn
add column Customers_Segment_1  text;    
      
alter table bank_churn
 add Customers_Segment_2 text;    

select * from bank_churn;

 update bank_churn
 set  Customers_Segment_2 = 
                                case
                                  when customers_Segment_1 <=5 then "low_customer"
                                 when customers_Segment_1 between 6 and 9 then "moderate_customer" 
                                  else "good_customer" end;
                                  
  select * from  bank_churn;                              
                                  
 select min(Customers_Segment) from bank_churn;
 select max(Customers_Segment) from bank_churn;
 select * from bank_churn; 
 -- 4b What proportion of churned customers had multiple products vs. single products?                              
 select NumOfProducts, concat(round(count(Exited)*100/(select count(*) from bank_churn where Exited=1),2),"%") as customer_no_products from bank_churn
 where Exited =1
 group by NumOfProducts order by customer_no_products desc;
 
 
 --- 5a.How does churn rate differ by country (France, Spain, Germany)?
 select Geography,concat(round(count(Exited)*100/(select count(*)from bank_churn where Exited =1),2),"%") as geography_exited from bank_churn
 where Exited =1
 group by Geography  order by geography_exited desc;
 
 
 -- 5b. Do older customers have a lower churn rate compared to younger customers?
 
 select min(Age) from bank_churn;
 select max(Age) from bank_churn;
 select Age,
            case 
            when Age <=30 then "young"
            when Age <=60 then "mid_age"
            else "old"
            end as age from bank_churn;
  alter table bank_churn
  add column Age_segment text;
            
            
set sql_safe_updates=0;          
 update bank_churn
 set Age_segment = case 
            when Age <=30 then "young"
            when Age <=60 then "mid_age"
            else "old" end;
    select  * from bank_churn;       
 select Age_segment, concat(round(sum(Exited)*100/(select count(*) from bank_churn where Exited =1),2),"%") as Age_exited from bank_churn
 where Exited =1
 group by Age_segment order by Age_exited desc;
 
--  5c.Is there a significant difference in churn between male and female customers?

select  Gender, count(Exited) as Gender_exited from bank_churn
 where Exited =1
 group by Gender order by Gender_exited desc;


-- 6. Customer Engagement & Activity Levels
-- 6a.Do inactive members have a higher churn rate than active members?
select 
                    case 
                    when IsActiveMember= 1 then "active"
                     else "not_active" end 
 ,concat(round(count(IsActivemember)*100/(select count(*) from bank_churn where exited = 1),2),"%") as activemember_exited from bank_churn
where Exited =1
group by IsActiveMember ;


-- 6b.What is the relationship between credit score and churn?
select Creditscore_Segment, count(Exited) as creditscore_Exited from bank_churn
where Exited =1
group by  Creditscore_Segment order by creditscore_Exited desc;

 
-- 6c.Are customers with credit cards less likely to churn?
 
 select HasCrCard , count(HasCrCard) from bank_churn
 where Exited =1
 group by HasCrCard;

-- 7. Financial & Revenue Insights
-- 7a What is the average balance and salary of churned vs. retained customers?
select concat(round(avg(Balance),2),"$") , concat(round(avg(EstimatedSalary),2),"$") as avg_balance_salary from bank_churn
where Exited =1;
select concat(round(avg(Balance),2),"$") , concat(round(avg(EstimatedSalary),2),"$") as avg_balance_salary from bank_churn
where Exited =0;


-- 7b Are customers with lower credit scores more likely to churn?
 select Creditscore_Segment, concat(round(sum(Exited)*100/(select count(*) from bank_churn where Exited =1),2),"%") as creditscore_exited from bank_churn
 where Exited =1
 group by Creditscore_Segment order by creditscore_exited desc; 



-- 7c Does tenure (years with the bank) influence churn rates?
select Tenure,concat(round(sum(Exited)*100/(select count(*) from bank_churn where Exited =1),2),"%") as tenure_exited from bank_churn
 where Exited =1
 group by Tenure order by tenure_exited desc; 







