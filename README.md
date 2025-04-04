



![bank picture](https://github.com/user-attachments/assets/6763c41a-8581-4c6d-b8cd-e2dedc1219e3)








## TABLE OF CONTENTS

-INTRODUCTION

-PROJECT OVERVIEW

-PROJECT OBJECTIVE

-DATA CLEANING

-DATA EXPLORATION

-DATA MINING



                          DATA DOCUMENTATION
INTRODUCTION:
This is a bank_churn dataset comprising of 10,000 customers in a bank firm
PROJECT OVERVIEW : This dataset is comprised of 13 columns and 10,000 rows in  the following sequence;



Field	Description	

Customer_ID:A unique identifier for each customer	

Surname: The customer's last name			

CreditScore: A numerical value representing the customer's credit score

Geography:	The country where the customer resides (France, Spain or Germany)

Gender:	The customer's gender (Male or Female)	

Age: The customer's age		

Tenure:	The number of years the customer has been with the bank

Balance: The customer's account balance	

NumOfProducts: The number of bank products the customer uses (e.g., savings account, credit card)

HasCrCard:	Whether the customer has a credit card (1 = yes, 0 = no)

IsActiveMember:	Whether the customer is an active member (1 = yes, 0 = no)

EstimatedSalary: The estimated salary of the customer		

Exited:	Whether the customer has churned (1 = yes, 0 = no)	


PROJECT OBJECTIVE: 
1. What attributes (e.g., credit score, balance, tenure, number of products) are most common among churners?
What is the overall churn rate? How does it vary across demographics?
Creditscore high creditscore  -67.35%
            medium creditscore -31.71%
            Low creditscore    -0.93%

 Tenure 1 - 11.39%
        2 - 9.8%
        3 - 10.46%
        4 - 9.97%
        5 - 10.26%
        6 - 9.62%
        7 - 8.69%
        8 - 9.62%
        9 - 10.46%
        10 - 4.96%

Number of products
        1 - 69.17%
        2 - 2.95%
        3 - 17.08%
        4 - 10.80%

Gender
Female - 55.92%
Male - 44.08%


Creditcard
       1 -69.91%
       0 - 30.09%


Age_segment
mid_age -  87.09%
young - 7.27%
old - 5.65%





3. Are customers with higher balances more likely to stay or leave?
customers with high balance are less likely to churn
Balance - 
     high_balance - 0.93%
     low_balance - 40.55%
     medium_balance - 58.52%




4. Customer Segmentation & Behavioral Analysis
 Can customers be grouped into different segments based on their banking behavior?
How do high-value customers (e.g., high balance, multiple products) compare to low-value customers?
 What proportion of churned customers had multiple products vs. single products?
low_customers - 1559
good_customers - 1455
moderate_customers - 6986


Number of products
        1 - 69.17%
        2 - 2.95%
        3 - 17.08%
        4 - 10.80%



6. Geographic & Demographic Trends
 How does churn rate differ by country (France, Spain, Germany)?
Do older customers have a lower churn rate compared to younger customers?
Is there a significant difference in churn between male and female customers?

Germany - 39.96%
France - 39.76%
Spain - 20.27%


8. Customer Engagement & Activity Levels
 Do inactive members have a higher churn rate than active members?
 What is the relationship between credit score and churn?
 Are customers with credit cards less likely to churn?

Active_members - 36.08%
Non_active_members - 63.92%




10. Financial & Revenue Insights
 What is the average balance and salary of churned vs. retained customers?
 Are customers with lower credit scores more likely to churn?
 Does tenure (years with the bank) influence churn rates?


Average_balance of churned customers - $91108.54
Average_salary of churned customers - $101465.68

Average_balance of retained customers - $72745.3
Average_salary of retained customers - $99738.39




________________________________________
Technical SQL Applications Required:
✔ Basic SQL: Aggregate functions (SUM, AVG, COUNT, MAX, MIN), CASE statements
✔ Intermediate SQL: Joins, subqueries, filtering (WHERE, GROUP BY, HAVING)
✔ Advanced SQL:
•	Common Table Expressions (CTEs): To break down complex queries
•	Window Functions: To calculate rankings, moving averages, and churn trends over time
•	Nested Queries: To compare active vs. inactive customers
________________________________________



Final Deliverables:
📌 Database Setup: Creating tables and loading data into a database
📌 SQL Queries & Insights: Extracting meaningful insights using SQL
📌 Data Visualization: Interactive Power BI dashboard to present findings
📌 Summary Report: A well-documented report explaining key trends, insights, and recommendations



DATA CLEANING:
In the course of analyzing this dataset, the column headings with data type abnormality was altered to the normal data type in SQL. 
-	6 new columns were also added to the table making a sum of 19 columns
-	The data was changed to set sql_safe_updates=0;
-	The data set was checked for duplicates

  

DATA  EXPLORATION : 
The followings were deduced from this analysis
1.A total of 2037 customers ( 20.37%) was churned while 7963 (79.63%) customers are still remaining with the bank. This is significant and suggests a need for addressing retention strategies.
2.The middle aged group had the highest churn rate with 87.09% .This could indicate a specific issue with this group, such as dissatisfaction with services or financial products, that should be investigated further
3. Non- active members exited more than the active members .It might suggest that the bank isn’t sufficiently engaging or providing value to these customers, and outreach strategies could help reduce churn in this group.
4. customers with high credit score exited the company more than other category, this could be as a result of high interest rate on loans and other benefits.
5. Customers with credit card exited more than those without credit card, may indicate issues with credit card services,
6. 55.92% of female customers exited, while 44.04% males exited from the bank. It's worth exploring whether there are specific services or products that are less appealing to female customers, or if there are more personalized outreach efforts needed to retain them.
7. Customers with one product exited more than those with multiple products.his could indicate that customers with only one product are not finding enough value in the bank to stay. Offering additional products that fit their needs could help increase loyalty.
8. 4559(57.25%) male customers are still remaining while 3404(42.75%) females are still remaining with the bank.




RECOMMENDATION: 
1.This firm should regularly solicit and act on customer feedback to continually improve the users experience.
2.This company must continously innovate and differenciate their products and services, providing unique value propositions that competitors can't easily replicate.
3.The company should consider implementing pricing strategies that cater for different customer segments. Offering different pricing options can make the products or services more accessible and reduce the likelihood of customers leaving.
4.continous product improvement and prompt resolution of any issues can maintain customers satisfaction and prevent churn. 
5.The middle-aged customers should be engaged with regular updates, informative and mouth-watering packages to captivate their minds. Offering better loan terms, or other products that appeal to this group, could help retain them.
6.Their should be a robust feed back from all the customers to ascertain their expectations so to know areas and services for improvement.
7.Re-engagement for Non-Active Members: Running campaigns or offering incentives to bring back non-active members could reduce churn in that group.


![bank-churn dashboard_page-0001](https://github.com/user-attachments/assets/d4155e4c-9c13-46b1-9ced-368aab88cd8e)


![bank-churn dashboard_page-0002](https://github.com/user-attachments/assets/4a63a922-b6ab-4251-b924-ce3805497f01)

