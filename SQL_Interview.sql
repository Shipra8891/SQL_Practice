create database interview;
USE interview;
CREATE TABLE employees (
      employee_id INT PRIMARY KEY,
      employee_name VARCHAR (20),
      salary DECIMAL (10,2),
      years_of_service INT 
                         ); 
DROP TABLE employees;
                         
INSERT INTO employees (employee_id,employee_name, salary, years_of_service)
 VALUES
     (1,'John Doe', 60000.00, 3),
	 (2,'Jane Smith', 75000.00, 7),
     (3,'Bob Johnson', 85000.00, 12),
     (4, 'Alice Brown', 100000.00, 18);

SELECT * FROM employees;	

-- Find highest salary.

SELECT max(salary) FROM employees;

-- second highest salary.
-- 1st approch
SELECT max(salary) as Secondhighestsalary FROM employees WHERE salary < (SELECT max(salary) FROM employees);

select employee_name , salary from employees where salary in (
SELECT max(salary) as Secondhighestsalary FROM employees WHERE salary < (SELECT max(salary) FROM employees));

-- the above solution is not a genric solution

INSERT INTO employees (employee_id,employee_name, salary, years_of_service)
 VALUES
     (5,'Jonny Doe', 60000.00, 3),
	 (6,'Adii Smith', 75000.00, 7),
     (7,'Bonny Johnson', 85000.00, 12);

-- 2nd approch

SELECT salary from employees order by salary desc;

SELECT salary as Secondhighestsalary from employees order by salary desc limit 1 offset 1;

-- 3rd approch
 
SELECT salary ,dense_rank() over (order by salary desc) as dense_rnk FROM employees;

SELECT distinct salary ,dense_rank() over (order by salary desc) as dense_rnk FROM employees;

SELECT distinct salary ,dense_rank() over (order by salary desc) as dense_rnk FROM employees LIMIT 1 OFFSET 1;

SELECT distinct salary ,dense_rank() over (order by salary desc) as dense_rnk FROM employees LIMIT 1 OFFSET 2;


-- 2.How to find duplicates in a given table?
Create table emp(
                emp_id int,
                emp_name varchar(20),
				department_id int,
				salary int,
                manager_id int);
				
drop table emp;
Insert into emp
Values(1, 'Ankit', 100,10000, 4),
	  (2, 'Mohit', 100, 15000, 5),
	  (3, 'Vikas', 100, 10000,4),
      (4, 'Rohit', 100, 5000, 2),
      (5, 'Mudit', 200, 12000, 6),
      (6, 'Agam', 200, 12000,2),
      (7, 'Sanjay', 200, 9000, 2),
	  (8, 'Ashish', 200,5000,2),
      (9, 'Saurabh',900,12000,2);
	 
SELECT * FROM emp;


-- 3. How to delete duplicates
SELECT emp_id,count(1) FROM emp group by emp_id;
SELECT emp_id,count(1) FROM emp group by emp_id having count(1) >1;
SELECT emp_id,emp_name,count(1) FROM emp group by emp_id,emp_name having count(1) >1;

SELECT *, row_number() over (partition by emp_id) as rn from emp;


-- 4. Difference between union and union all
-- union add two table

Create table emp1(
                emp_id int,
                emp_name varchar(20),
				department_id int,
				salary int,
                manager_id int);

Insert into emp1
Values(1, 'Ankit', 100,10000, 4),
	  (2, 'Mohit', 100, 15000, 5),
	  (3, 'Vikas', 100, 10000,4),
      (4, 'Rohit', 100, 5000, 2),
      (5, 'Mudit', 200, 12000, 6),
      (6, 'Agam', 200, 12000,2),
      (7, 'Sanjay', 200, 9000, 2),
	  (8, 'Ashish', 200,5000,2),
      (1, 'Saurabh',900,12000,2);


SELECT * FROM emp1;
SELECT * FROM emp;

SELECT manager_id FROM emp1
union all
SELECT manager_id FROM emp;

SELECT manager_id FROM emp1
union 
SELECT manager_id FROM emp;

-- 5. Difference between rank,row_number and dense_rank.
Create table emp2(
                emp_id int,
                emp_name varchar(20),
				department_id int,
				salary int,
                manager_id int);

Insert into emp2
Values(1, 'Ankit', 100,10000, 4),
	  (2, 'Mohit', 100, 15000, 5),
	  (3, 'Vikas', 100, 10000,4),
      (4, 'Rohit', 100, 5000, 2),
      (5, 'Mudit', 200, 12000, 6),
      (6, 'Agam', 200, 12000,2),
      (7, 'Sanjay', 200, 9000, 2),
	  (8, 'Ashish', 200,5000,2);

SELECT * FROM emp2;

SELECT emp_id,emp_name,department_id,salary,RANK() OVER (ORDER BY salary desc) as rnk FROM emp2;

SELECT emp_id,emp_name,department_id,salary,RANK() OVER (ORDER BY salary desc) as rnk,
DENSE_RANK() OVER (ORDER BY salary desc) as dense_rnk FROM emp2;

SELECT emp_id,emp_name,department_id,salary,RANK() OVER (ORDER BY salary desc) as rnk,
DENSE_RANK() OVER (ORDER BY salary desc) as dense_rnk,
ROW_NUMBER() OVER (ORDER BY salary desc) as row_no FROM emp2;

-- Difference between WHERE and HAVING clause
SELECT * FROM emp2;

SELECT avg(salary) FROM emp2;

SELECT * FROM emp2 WHERE salary>10000;

SELECT department_id ,avg(salary) FROM emp2
GROUP BY department_id HAVING avg(salary)>9500;

SELECT department_id,avg(salary) FROM emp2 WHERE salary>10000
GROUP BY department_id;

SELECT department_id,avg(salary) FROM emp2 WHERE salary>10000
GROUP BY department_id HAVING avg(salary)>12000;


-- 6. Find second highest salary in each department

SELECT emp.* ,dense_rank() over (partition by department_id order by salary desc) as rnk FROM emp;

SELECT * FROM (SELECT emp.* ,dense_rank() over (partition by department_id order by salary desc) as rnk FROM emp)
r  WHERE rnk=2;

-- Find second highest salary in specific department 

SELECT * FROM(
SELECT emp.*,dense_rank() over (partition by department_id order by salary desc) as rnk 
from emp) r WHERE Department_id = 100 AND  rnk = 1 ;






CREATE TABLE Total_Employees (
                EmployeeName VARCHAR(50),
                Department VARCHAR (50),
                salary INT);
                
INSERT INTO Total_Employees (EmployeeName, Department, salary)
VALUES
      ('Ronak Pathak', 'Sales', 30000),
      ('Manisha Pathak','Marketing',25000),
      ('Rishav Mishra', 'sales', 28000),
      ('Ritu Mishra', 'IT',29),
      ('Soha Pathak', 'Sales', 25000),
      ('Mani Pathak','Marketing',35000),
      ('Rishu Mishra', 'sales', 25000),
      ('Ritika Mishra', 'Sales',28000),
      ('Shyam Mishra', 'Marketing',25000);  

SELECT * FROM Total_Employees;


-- joins
CREATE TABLE students (
        students_name VARCHAR (50),
        selected_course INT 
                         );

INSERT INTO students (students_name, selected_course)
VALUES  
         ('Rohit' , 2 ),
         ('Virat' , 1),
         ('Shikar' , 3 ),
         ('Rahul' , 1 ),
         ('Kapil' , 1 ),
         ('Brian' , 1 ),
         ('Carl' , 1 ),
         ('Sourabh', 1 );


CREATE TABLE courses (
        course_id INT ,
        course_name VARCHAR(50),
        course_duration INT,
        course_fees INT
                         );

INSERT INTO courses (course_id, course_name, course_duration, course_fees)
VALUES
        (1, 'Big data' , 6 , 50000),
		(2, 'Web developer' , 3, 20000),
        (3, 'Data Science' , 6 , 40000),
        (4, 'Data Structure' , 4, 50000);

SELECT * FROM students;
SELECT * FROM courses;


SELECT selected_course FROM students WHERE students_name = 'Rahul';

SELECT course_name FROM courses WHERE course_id =
            (SELECT selected_course FROM students WHERE students_name = 'Rahul');

-- joins: join two table on the basis of common column 
-- common column : In students table = selected course
-- And In course table = course_id.

SELECT students.students_name,  courses.course_name FROM students join courses 
ON students.selected_course = courses.course_id;

-- by default it is a inner join
-- only the matching records are considered and non-matching records are disgarded.

-------------------------------------------------------------------------------------------------

-- Left join : All the matching records are considered + all the non matching records
-- in the left table which does not have the match in the right padded with NULL.


SELECT students.students_name, courses.course_id, courses.course_name FROM  students LEFT JOIN  courses     
ON students.selected_course = courses.course_id;

SELECT students.students_name, courses.course_id, courses.course_name FROM  students RIGHT JOIN  courses     
ON students.selected_course = courses.course_id;

-- Full outer joins

SELECT students.students_name, courses.course_id, courses.course_name FROM  students LEFT JOIN  courses     
ON students.selected_course = courses.course_id
UNION
SELECT students.students_name, courses.course_id, courses.course_name FROM  students RIGHT JOIN  courses     
ON students.selected_course = courses.course_id;

-- Making of new table with same structure of previous table

CREATE TABLE students_latest as SELECT * FROM students;
SELECT * FROM students_latest;

CREATE TABLE courses_latest as SELECT * FROM courses;
SELECT * FROM courses_latest;

-- DELETE of particular column from table.

DELETE FROM courses_latest WHERE course_id = 2;

INSERT INTO courses_latest (course_id, course_name, course_duration, course_fees)
VALUES
        (4, 'Data Structure' , 4, 50000);
        
SELECT students_latest.students_name, courses_latest.course_id, courses_latest.course_name FROM  students_latest LEFT JOIN  courses_latest     
ON students_latest.selected_course = courses_latest.course_id;

SELECT students_latest.students_name, courses_latest.course_id, courses_latest.course_name FROM  students_latest RIGHT JOIN  courses_latest     
ON students_latest.selected_course = courses_latest.course_id;

-- full outer join

SELECT students_latest.students_name, courses_latest.course_id, courses_latest.course_name FROM  students_latest LEFT JOIN  courses_latest     
ON students_latest.selected_course = courses_latest.course_id
UNION
SELECT students_latest.students_name, courses_latest.course_id, courses_latest.course_name FROM  students_latest RIGHT JOIN  courses_latest     
ON students_latest.selected_course = courses_latest.course_id;


-- The CASE expression goes through conditions and returns a value
--  when the first condition is met (like an if-then-else statement). 
-- So, once a condition is true, it will stop reading and return the result. 
-- If no conditions are true, it returns the value in the ELSE clause.
-- If there is no ELSE part and no conditions are true, it returns NULL.

CREATE TABLE CUSTOMERS (
   ID INT NOT NULL,
   NAME VARCHAR (20) NOT NULL,
   AGE INT NOT NULL,
   ADDRESS CHAR (25),
   SALARY DECIMAL (18, 2),       
   PRIMARY KEY (ID)
                        ); 
                        
INSERT INTO CUSTOMERS VALUES
(1, 'Ramesh', 32, 'Ahmedabad', 2000.00 ),
(2, 'Khilan', 25, 'Delhi', 1500.00 ),
(3, 'Kaushik', 23, 'Kota', 2000.00 ),
(4, 'Chaitali', 25, 'Mumbai', 6500.00 ),
(5, 'Hardik', 27, 'Bhopal', 8500.00 ),
(6, 'Komal', 22, 'Hyderabad', 4500.00 ),
(7, 'Muffy', 24, 'Indore', 10000.00 );

SELECT * FROM CUSTOMERS;

SELECT NAME, AGE,
CASE 
WHEN AGE > 30 THEN 'Gen X'
WHEN AGE > 25 THEN 'Gen Y'
WHEN AGE > 22 THEN 'Gen Z'
ELSE 'Gen Alpha' 
END AS Generation
FROM CUSTOMERS;

SELECT 
CASE 
WHEN AGE > 30 THEN 'Gen X'
WHEN AGE > 25 THEN 'Gen Y'
WHEN AGE > 22 THEN 'Gen Z'
ELSE 'Gen Alpha' 
END AS Generation,count(*)
FROM CUSTOMERS
group by Generation;




SELECT *, CASE 
WHEN SALARY < 4500 THEN (SALARY + SALARY * 25/100) 
END AS INCREMENT FROM CUSTOMERS;

-- select name from students where marks > 75
-- order by right(name,3),ID asc;

-- above code is for finding students name who have scored marks>75
-- names ending in the same last three characters, 
-- secondary sort them by ascending ID.\


-- converting row into columns and columns into rows
create table emp_compensation (
                       emp_id int,
                       salary_component_type varchar(20),
						val int
                               );
                               
insert into emp_compensation
values
 (1,'salary',10000),
 (1,'bonus',5000),
 (1,'hike_percent',10),
(2,'salary',15000),
(2,'bonus',7000),
(2,'hike_percent',8),
(3,'salary',12000),
(3,'bonus',6000),
(3,'hike_percent',7);

select * from emp_compensation;

-- conversion to pivot
SELECT emp_id,
CASE WHEN salary_component_type = 'salary' THEN val END AS salary,
CASE WHEN salary_component_type = 'bonus' THEN val END AS bonus,
CASE WHEN salary_component_type = 'hike_percent' THEN val END AS hike_percent
FROM emp_compensation;

SELECT emp_id,
SUM(CASE WHEN salary_component_type = 'salary' THEN val END) AS salary,
SUM(CASE WHEN salary_component_type = 'bonus' THEN val END) AS bonus,
SUM(CASE WHEN salary_component_type = 'hike_percent' THEN val END) AS hike_percent
FROM emp_compensation
GROUP BY emp_id;

-- conversion to unpivot
SELECT emp_id,
SUM(CASE WHEN salary_component_type = 'salary' THEN val END) AS salary,
SUM(CASE WHEN salary_component_type = 'bonus' THEN val END) AS bonus,
SUM(CASE WHEN salary_component_type = 'hike_percent' THEN val END) AS hike_percent
into emp_compensation_pivot
FROM emp_compensation
GROUP BY emp_id;

SELECT * FROM emp_compensation_pivot;

SELECT emp_id,
'salary' as salary_component_type, salary as val FROM emp_compensation_pivot
union all
SELECT emp_id,
'bonus' as salary_component_type, bonus as val FROM emp_compensation_pivot
union all
SELECT emp_id,
'hike_percent' as salary_component_type, hike_percent as val FROM emp_compensation_pivot;




