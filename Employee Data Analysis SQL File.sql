create database employee_db;

use employee_db;

select *
from employeetable;

#Q1. Fetch the names of all asians who has experience more than 1 year.



Select Country,Avg(AnnualSalaryInDollar)
From employeetable as e inner join fraudtable as f
on e.Employee_ID =f.Employee_ID
Group by Country;

select Name
From fraudtable
where Ethnicity='Asian' and Experience>1;

#Q2 Compare the annual income trend of IT,Sales and Finance department with age more than 40.

Select Department, Age,AnnualSalary
From employeetable as e inner join fraudtable as f
on e.Employee_ID =f.Employee_ID
where Age>40 and Department In ('IT','Sales','Finance')
order by Age asc;

#Q3 Annual income trend of analyst and analyst 2 of United states and china.

Select distinct Job_title,Country,AnnualSalaryinDollar as Avgsalary
From Employeetable as e inner join fraudtable as f
on e.Employee_ID=f.employee_ID
Where Country in('United states','China') and Job_title in ('Analyst','Analyst II')
Order by AnnualSalaryinDollar desc;

#Q4 Fetch the ratio of male and female employees IT department  who are from United states.

Select Department,Country, Gender,Count(Gender) as Gendercount
From employeetable as e inner join fraudtable as f
on e.Employee_ID=f.Employee_ID
Where Department in  ('IT')and Country in('United states')
Group by Gender;

#Q5 open the trend of fraud level of the employees from different departments with names.

Select distinct Department, f.FullName,Fraud_level
From employeetable as e inner join fraudtable as f
on e.Employee_ID=f.Employee_ID;

#Q6 Which department has highest level of fraud?(High level frauds are High and extreme high)

Select distinct Ethnicity,count(Fraud_level) as TotalFrauds
from fraudtable
Group by Ethnicity;

/*Q7 open the trend of work/leave score of all the employees from united states
who has the score >35 and has done mild level of fraud with the company*/

Select f.FullName, Work_leave_score,Fraud_level,Country
From employeetable as e inner join fraudtable as f
on e.Employee_ID=f.Employee_ID
Where Fraud_level='Mild' and Country='United States'
Having Work_leave_score>35;

/*Work Efficiency based on cities*/

/*New added Q7 */

Select distinct Round(Avg(Work_leave_score),2) as AverageEfficiency,City
From employeetable as e inner join fraudtable as f
on e.Employee_ID=f.Employee_ID
Group by City;

/*Country wise fraud level*/

Select distinct Country,Fraud_level
From employeetable as e inner join fraudtable as f
on e.Employee_ID=f.Employee_ID;

/*Business wise fraud level analysis*/

Select distinct Business,Count(Fraud_level) as TotalFrauds
From employeetable as e inner join fraudtable as f
on e.Employee_ID=f.Employee_ID
Group by Business;

/*Q8 Number of male and female employees from corporate sector having experiennce level >2 years*/

Select Business,Experience, Gender
From employeetable as e inner join fraudtable as f
on e.Employee_ID=f.Employee_ID
Where Business='Corporate' and Experience>2;

/*Number of employees in each sector*/

Select count(Gender) ,Business
From employeetable
group by Business;

/*Gender in each sector*/

Select count(Gender) as MaleEmployees ,Business
From employeetable
Where Gender IN ('Male')
group by Business;

Select count(Gender) as FemaleEmployees ,Business
From employeetable
Where Gender IN ('Female')
group by Business;

/*Q9 Fetch all the names from each department with mild level of fraud.
Show the trend*/

Select f.FullName,Department,Fraud_Level
From employeetable as e inner join fraudtable as f
on e.Employee_ID=f.Employee_ID
Where Fraud_Level='Mild';

/*Q 10 Fetch the names of employees who were hired after 01-01-2015 
and has annual salary>$40000 and has work/leave score >45 */

Select FullName,AnnualSalary, Hire_date,Work_leave_score
From fraudtable
Where Hire_date>'01-01-2015' and work_leave_score>45
Having AnnualSalary>'$40000'
Order by AnnualSalary asc;

/*Q11 Compare the fraud levels of employees based on their ethnicity*/

Select distinct Ethnicity, Fraud_Level
From fraudtable;

/* Q 12 Compare average annual salary of Employees from United states,China and Brazil*/

Select Country,ROUND(avg(AnnualSalaryInDollar),2) Avgsalary
From employeetable as e inner join fraudtable as f
on e.Employee_ID=f.Employee_ID
Group by Country;

/*Q13 Query the fraud levels of top 5  Male employees who has more than 6 years of experience*/

Select f.FullName,Gender,AnnualSalaryInDollar,Experience,Fraud_level
From employeetable as e inner join fraudtable as f
on e.Employee_ID=f.Employee_ID
Where Gender='Male'
Having Experience>5
Order by 5;


/*Q14 
Which department has the most number of frauds happen?show the trend genderwise?*/

Select Department,count(Fraud_level) as FraudCount
From employeetable as e inner join fraudtable as f
on e.Employee_ID=f.Employee_ID
Group by Department;

/*Age vs AnnualSalary Trend*/

SELECT e.Agerange as Age_range,
   count(*) as Number_of_employees,
   Round( AVG(AnnualSalaryInDollar),2) AS "Average Salary In Dollar",  
   Round(100 * COUNT(*) / SUM(COUNT(*)) OVER (),2) AS "% of employees"
   FROM
 (SELECT AnnualSalaryInDollar,
    CASE  
      WHEN age >60  THEN '60 And Up'
      WHEN age >=41 and age <=60 THEN '41-60'
      WHEN age >=21 and age <=40 THEN '21-40'
      WHEN age <=20 THEN '20 And Below' 
    END as agerange
  from employeetable as e inner join fraudtable as f
on e.Employee_ID=f.Employee_ID
 ) as e
group by e.Agerange; 

/*THE END*/