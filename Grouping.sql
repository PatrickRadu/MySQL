SELECT gender,max(age),avg(age)
FROM parks_and_recreation.employee_demographics
group by gender;

SELECT gender,max(age),avg(age),count(age)
FROM parks_and_recreation.employee_demographics
group by gender;

SELECT * 
FROM parks_and_recreation.employee_salary
order by salary, occupation;


Select gender, avg(age)
from parks_and_recreation.employee_demographics
Group by gender
Having avg(age)>40;

select occupation , avg(salary)
from employee_salary
Where occupation LIKE '%manager%'
group by occupation
Having AVG(salary)>50000
Order by occupation;

select gender, avg(age) as average_age
from employee_demographics
group by gender
;
