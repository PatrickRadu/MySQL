SELECT dem.employee_id, age, occupation
from employee_demographics dem
inner JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
;

SELECT dem.employee_id, age, occupation
from employee_demographics dem
Right JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
;

SELECT dem.employee_id, age, occupation
from employee_demographics dem
Left JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
;

#SELF JOIN
Select s1.employee_id as santa, s1.first_name santa_first_name, s1.last_name santa_last_name, s2.first_name ,s2.last_name
from employee_salary s1
Join employee_salary s2
on s1.employee_id+1=s2.employee_id
;

select * 
FROM parks_departments;

SELECT *
from employee_demographics dem
inner JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
inner Join parks_departments pd
	on sal.dept_id=pd.department_id
;

SELECT first_name,last_name
FROM employee_demographics
Union
select first_name,last_name
from employee_salary
;

SELECT first_name,last_name, 'Old lady' as label
FROM employee_demographics
where age>40 and gender='Female'
UNION
SELECT first_name,last_name, 'Old man' as label
FROM employee_demographics
where age>50 and gender='Male'
UNION
SELECT first_name,last_name, 'Highly paid' as label
FROM employee_salary
where salary>70000
order by first_name,last_name;


SELECT length("Skyfall");
 
 SELECT first_name,Length(first_name) lungime
 from employee_demographics
 order by lungime;
 
 SELECT first_name,Upper(first_name) 
 from employee_demographics;
 
 Select first_name,left(first_name,4)
 from employee_demographics;
 
 Select first_name,substring(first_name,3,2), birth_date,substring(birth_date,6,2) as month
 from employee_demographics;

Select first_name,Replace(first_name,'a','z')
from employee_demographics;

Select first_name,Locate('An',first_name)
from employee_demographics;

Select first_name,last_name, Concat(first_name,' ',last_name) as full_name
from employee_demographics;

Select first_name,last_name,age,
CASE 
	WHEN age<=30 THEN 'Young' 
    WHEN age between 31 and 50 THEN 'Old'
    when age>=51 then 'Very old'
END AS age_bracket
from employee_demographics;

Select first_name,last_name,salary,
CASE
 when salary < 50000 THEN salary+ salary*5/100
 when salary > 50000 Then salary + salary*7/100
END as new_salary
from employee_salary;

select sal.first_name,sal.last_name,sal.salary,dep.department_name,
CASE
 when sal.salary < 50000 THEN sal.salary+ sal.salary*5/100
 when sal.salary > 50000 Then sal.salary + sal.salary*7/100
 when dep.department_name='Finance' then sal.salary+sal.salary*10/100
 when sal.salary <=50000 then sal.salary
END as new_salary
from employee_salary sal
inner Join parks_departments dep
	ON sal.dept_id=dep.department_id
;

create table tabel_test as 
select sal.first_name,sal.last_name,sal.salary,dep.department_name,
CASE
 when sal.salary < 50000 THEN sal.salary+ sal.salary*5/100
 when sal.salary > 50000 Then sal.salary + sal.salary*7/100
 when dep.department_name='Finance' then sal.salary+sal.salary*10/100
 when sal.salary <=50000 then sal.salary
END as new_salary
from employee_salary sal
inner Join parks_departments dep
	ON sal.dept_id=dep.department_id;
    
select sal.first_name,sal.last_name,dem.department_name,
Case
When sal.salary>50000 then "High pay"
When sal.salary<=50000 then "average pay"
End as state
From employee_salary sal
inner Join parks_departments dem
	on sal.dept_id=dem.department_id

	;
    
    
SELECT * 
from employee_demographics
where employee_id IN (
			Select employee_id
			From employee_salary
			Where dept_id=1
)
;

SELECT first_name,salary,
(SELECT AVG(salary)
FROM employee_salary)
FROM employee_salary
;

SELECT gender, avg(age),max(age),min(age),count(age)
FROM employee_demographics
Group by gender;

SELECT avg(max_age) 
from
(SELECT gender, avg(age),max(age) as max_age,min(age),count(age)
FROM employee_demographics
Group by gender) as AGG_table
;


SELECT first_name, avg(salary)
from employee_salary
group by first_name;



select dem.first_name, gender,avg(salary) as avg_salary
from employee_demographics dem
JOIN employee_salary sal
	on dem.employee_id=sal.employee_id
group by dem.first_name, gender
    ;
    
select gender,avg(salary) OVER()
from employee_demographics dem
JOIN employee_salary sal
	on dem.employee_id=sal.employee_id
    ;

select dem.first_name,dem.last_name gender,salary,avg(salary) OVER(partition by gender)
from employee_demographics dem
JOIN employee_salary sal
	on dem.employee_id=sal.employee_id
    ;
    
select dem.first_name,dem.last_name gender,salary,avg(salary) OVER(partition by gender)
from employee_demographics dem
JOIN employee_salary sal
	on dem.employee_id=sal.employee_id
    ;

select dem.first_name,dem.last_name gender,SUM(salary) 
OVER(partition by gender order by dem.employee_id) as rolling_total
from employee_demographics dem
JOIN employee_salary sal
	on dem.employee_id=sal.employee_id
    ;
select dem.first_name,dem.last_name gender,SUM(salary) 
OVER(order by dem.employee_id) as rolling_total	
from employee_demographics dem
JOIN employee_salary sal
	on dem.employee_id=sal.employee_id
    ;

select dem.employee_id ,dem.first_name,dem.last_name, gender, sal.salary,
row_number() over(partition by gender order by salary DESC),
RANK() over (partition by gender order by salary desc),
dense_rank() over (partition by gender order by salary desc)
from employee_demographics dem
JOIN employee_salary sal
	on dem.employee_id=sal.employee_id
    ;

WITH CTE_EXAMPLE AS
(
select gender,avg(salary) avg_sal, 
max(salary) max_sal,count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id
group by gender
)

select avg(avg_sal)
from CTE_EXAMPLE
;

select avg(avg_sal)
from CTE_EXAMPLE
;

WITH CTE_EXAMPLE2 AS(
select employee_id,gender,birth_date 
from employee_demographics dem
where birth_date>'1985-01-01'
),
CTE_EXAMPLE AS
(
Select employee_id
FROM employee_salary
where salary>50000
)
SELECT * 
from CTE_EXAMPLE2
join CTE_EXAMPLE
	ON CTE_EXAMPLE2.employee_id=CTE_EXAMPLE.employee_id
;

-- Temp table
Create TEMPORARY TABLE temp_table
(
first_name varchar(50),
last_name varchar(50),
fav_movie varchar(100)
);

SELECT * FROM temp_table;

INSERT INTO temp_table
VALUES('PATRICK','STANCA','ShawShank Redemption')
;
SELECT * FROM temp_table;

SELECT * 
from employee_salary;

CREATE temporary table SALARY_OVER_50K
as 
select salary
from employee_salary
where salary>50000;

SELECT * FROM SALARY_OVER_50K;


-- Procedures
create procedure large_salaries() 
SELECT * FROM employee_salary
WHERE salary>=50000;

CALL large_salaries();

DELIMITER $$
create procedure large_salaries2() 
BEGIN
	SELECT * 
	FROM employee_salary
	WHERE salary>=50000;
	SELECT * 
	FROM employee_salary
	WHERE salary>=100000;
END $$
DELIMITER ;

CALL large_salaries2();

DELIMITER $$
create procedure large_salaries3(employee_id INT) 
BEGIN
	SELECT salary
	FROM employee_salary sal
    WHERE sal.employee_id=employee_id
    ;
END $$
DELIMITER ;

CALL large_salaries3(1);

DELIMITER $$
create procedure large_salaries4(sal INT) 
BEGIN
	SELECT first_name,last_name,salary
	FROM employee_salary 
    WHERE salary>=sal
    ;
END $$
DELIMITER ;

CALL large_salaries4(50000);



SELECT *
FROM employee_salary;


DELIMITER $$
create trigger employee_insertion
	AFTER INSERT ON employee_salary
    FOR EACH ROW 
BEGIN
	INSERT INTO employee_demographics (employee_id,
    first_name,last_name)
    VALUES (NEW.employee_id,NEW.first_name,NEW.last_name);
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id,first_name,last_name,
occupation,salary,dept_id)
VALUES (13,'Patrick','Stanca','Entertainment',100000,NULL);

SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics;

-- EVENT

DELIMITER $$
CREATE EVENT delete_retierees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
	FROM emloyee_demographics
    WHERE age>=60;
END $$
DELIMITER ;


select * 
from employee_demographics;

SHOW VARIABLES like 'event%';

DELIMITER $$
CREATE EVENT delete_retierees3
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
	FROM employee_demographics
    WHERE age>=60;
END $$
DELIMITER ;

select * 
from employee_demographics;