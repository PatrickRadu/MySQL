SELECT  first_name
FROM parks_and_recreation.employee_demographics
WHERE first_name='Leslie';

SELECT  *
FROM parks_and_recreation.employee_salary
WHERE salary<=50000;

select *
FROM parks_and_recreation.employee_demographics
WHERE gender!='Female';

select *
FROM parks_and_recreation.employee_demographics
WHERE birth_date>'1985-01-01';

# AND OR NOT - Operatori logici
select *
FROM parks_and_recreation.employee_demographics
WHERE birth_date>'1985-01-01' AND gender="Male";

select *
FROM parks_and_recreation.employee_demographics
WHERE birth_date>'1985-01-01' OR gender="Male";

select *
FROM parks_and_recreation.employee_demographics
WHERE birth_date>'1985-01-01' OR NOT gender="Male";

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE (first_name='Leslie' AND age=44) OR age>55;

#LIKE 
# % or _   
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'Jer%';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE '%er%';

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'A__';
