CREATE database SQL_cls5;
USE SQL_cls5;

-- CTE common table expression
-- Query 1

CREATE TABLE emp (
        emp_ID INT,
        emp_name VARCHAR (50),
        salary INT
				);
                
INSERT INTO emp (emp_ID, emp_name, salary)
VALUES
      (101, 'Mohan', 40000),
      (102, 'James', 50000),
      (103, 'Robin', 60000),
      (104, 'Carol', 70000),
      (105, 'Alice', 80000),
      (106, 'Jimmy', 90000);
      
SELECT * FROM emp;

-- average salary
 SELECT AVG(salary) AS average_salary from emp;
 
-- Find employee who earns more than average salaray

-- with subquery
SELECT * FROM emp
WHERE salary >(select avg(salary) FROM emp);

-- with CTE
with avg_salary as
( SELECT AVG(salary) as avg_salary FROM emp)
SELECT * FROM emp inner join avg_salary on salary > avg_salary;

-- query 2
CREATE TABLE sales (
        store_id INT,
        store_name VARCHAR (100),
        product VARCHAR (100),
        quantity INT,
        cost INT 
				  );
                  
INSERT INTO sales (store_id, store_name, product, quantity, cost)
VALUES
(1, 'Apple Originals 1','iPhone 12 Pro', 1, 1000),
(1, 'Apple Originals 1','MacBook pro 13', 3, 2000),
(1, 'Apple Originals 1','AirPods Pro', 2, 280),
(2, 'Apple Originals 2','iPhone 12 Pro', 2, 1000),
(3, 'Apple Originals 3','iPhone 12 Pro', 1, 1000),
(3, 'Apple Originals 3','MacBook pro 13', 1, 2000),
(3, 'Apple Originals 3','MacBook Air', 4, 1100),
(3, 'Apple Originals 3','iPhone 12', 2, 1000),
(3, 'Apple Originals 3','AirPods Pro', 3, 280),
(4, 'Apple Originals 4','iPhone 12 Pro', 2, 1000),
(4, 'Apple Originals 4','MacBook pro 13', 1, 2500);

SELECT * FROM sales;

-- Find total sales as per each store- Total_Sales
SELECT store_id, sum(cost) FROM sales group by store_id;

-- Find average sales with respect to all stores-Average_Sales
SELECT AVG(total_sales_per_store) as avg_sale_for_all_store
FROM (SELECT store_id, sum(cost) as total_sales_per_store
FROM sales s group by store_id) x;

-- Find stores who's sales where better than the average sales accross all stores
SELECT * FROM
(SELECT store_id, sum(cost) as total_sales_per_store
from sales group by store_id)
total_sales join (SELECT AVG(total_sales_per_store) as avg_sale_for_all_store
FROM (SELECT store_id, sum(cost) as total_sales_per_store
FROM sales group by store_id)x)avg_sales
on total_sales.total_sales_per_store > avg_sales.avg_sale_for_all_store;

-- using with clause
WITH total_sales as
      (SELECT store_id, sum(cost) as total_sales_per_store
	  FROM sales group by store_id),
avg_sales as 
      (SELECT AVG(total_sales_per_store) as avg_sale_for_all_store
	  FROM total_sales)
SELECT * FROM total_sales
join avg_sales
ON total_sales.total_sales_per_store > avg_sales.avg_sale_for_all_store;

-- with recursive

with recursive num as 
    (select 1 as n
    union 
    select n + 1 as n
    from num where n < 10
    )
select * from num;

-- views
CREATE TABLE employees (
      EmployeeID INT PRIMARY KEY,
      FirstName VARCHAR (50),
      LastName VARCHAR (50),
      Department VARCHAR (50),
      Salary DECIMAL (10,2)
                         );
                         
INSERT INTO employees (EmployeeID, FirstName, LastName, Department, Salary)
VALUES
    (1, 'John', 'Doe', 'HR', 50000.00),
    (2, 'Jane', 'Smith', 'IT', 60000.00),
    (3, 'Bob', 'Johnson', 'Finance', 55000.00),
    (4, 'Alice', 'Williams', 'Marketing', 52000.00),
    (5, 'Eve', 'Anderson', 'IT', 62000.00);
    
SELECT * FROM employees;

-- create a view
CREATE VIEW EmployeeName AS
SELECT EmployeeID, FirstName, LastName
FROM employees;

SELECT * FROM EmployeeName;

-- CREATE OR REPLACE A VIEW
CREATE OR REPLACE VIEW EmployeeName AS
SELECT EmployeeID, FirstName, LastName, Department
FROM employees;

SELECT * FROM EmployeeName;

-- drop a view
DROP VIEW EmployeeName;

-- procedure
CREATE PROCEDURE GetEmployeesByDepartment (IN DepartmentName VARCHAR(50))
BEGIN
   SELECT EmployeeID, FirstName, LastName
   FROM employees
   WHERE Department = DepartmentName
   END //
   
   DELIMITER ;
   
   CALL GetEmployeesByDepartment(HR);


-- INDEXES

DROP TABLE customer_orders;
CREATE TABLE customer_orders (
         order_id INT AUTO_INCREMENT PRIMARY KEY,
         order_date DATE,
         customer_id INT,
         order_total DECIMAL (10,2)
                                );
INSERT INTO customer_orders (order_date, customer_id, order_total)
VALUES
    ('2023-09-01', 101, 150.50),
    ('2023-09-02', 102, 200.25),
    ('2023-09-03', 101, 75.80),
    ('2023-09-04', 103, 120.60),
    ('2023-09-05', 102, 180.90);
    
SELECT * FROM customer_orders;

CREATE INDEX idx_customer_id ON customer_orders(customer_id);

SHOW INDEX FROM customer_orders;

-- window function
CREATE TABLE employee (
    emp_ID INT,
    emp_Name VARCHAR (50),
    dept_Name VARCHAR (50),
    salary INT 
                        );

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

SELECT * FROM employee;
SELECT max(salary) FROM employee;
SELECT dept_name, max(salary) FROM employee
GROUP BY dept_name;
SELECT e. *,
max(salary) over() as max_salary from employee e;

SELECT e. *,
max(salary) over(partition by dept_name) as max_salary
from employee e;

SELECT *,
row_number() over() as rn from employee;

select *,
row_number() over(partition by dept_name) as rn
from employee;

-- Fetch the first 2 employees from each department to join the company.
SELECT * FROM (
      SELECT * ,
      row_number() over (partition by dept_name order by emp_id) as rn
	  FROM employee) x
where x.rn < 3;

select *,
rank() over(partition by dept_name order by salary desc) as rnk
from employee;

-- dense rank
SELECT * ,
rank() over(partition by dept_name order by salary desc) as rnk,
dense_rank()over(partition by dept_name order by salary desc) as dense_rnk
from employee;

-- Checking the different between rank, dense_rnk and row_number window functions:
SELECT * ,
rank() over(partition by dept_name order by salary desc) as rnk,
dense_rank()over(partition by dept_name order by salary desc) as dense_rnk,
row_number() over (partition by dept_name order by salary desc) as rn
from employee;


-- lead and lag
SELECT *,
lag (salary) over (partition by dept_name order by emp_id) as prev_empl_sal
from employee;

select *,
lag(salary,2,0) over(partition by dept_name order by emp_id) as prev_empl_sal
from employee;

SELECT *, 
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal,
lead(salary) over(partition by dept_name order by emp_id) as next_empl_sal
from employee;

-- fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee.
select *,
lag(salary) over(partition by dept_name order by emp_id) as prev_empl_sal,
case when salary > lag(salary) over(partition by dept_name order by emp_id) then 'Higher than previous employee'
     when salary < lag(salary) over(partition by dept_name order by emp_id) then 'Lower than previous employee'
	 when salary = lag(salary) over(partition by dept_name order by emp_id) then 'Same than previous employee' end as sal_range
from employee;

-- Script to create the Product table and load data into it.
CREATE TABLE product (
			product_category VARCHAR (200),
            brand VARCHAR (200),
            product_name VARCHAR (200),
            price INT 
                      );
INSERT INTO product (product_category, brand, product_name, price)
VALUES
('Phone', 'Apple', 'iPhone 12 Pro Max', 1300),
('Phone', 'Apple', 'iPhone 12 Pro', 1100),
('Phone', 'Apple', 'iPhone 12', 1000),
('Phone', 'Samsung', 'Galaxy Z Fold 3', 1800),
('Phone', 'Samsung', 'Galaxy Z Flip 3', 1000),
('Phone', 'Samsung', 'Galaxy Note 20', 1200),
('Phone', 'Samsung', 'Galaxy S21', 1000),
('Phone', 'OnePlus', 'OnePlus Nord', 300),
('Phone', 'OnePlus', 'OnePlus 9', 800),
('Phone', 'Google', 'Pixel 5', 600),
('Laptop', 'Apple', 'MacBook Pro 13', 2000),
('Laptop', 'Apple', 'MacBook Air', 1200),
('Laptop', 'Microsoft', 'Surface Laptop 4', 2100),
('Laptop', 'Dell', 'XPS 13', 2000),
('Laptop', 'Dell', 'XPS 15', 2300),
('Laptop', 'Dell', 'XPS 17', 2500),
('Earphone', 'Apple', 'AirPods Pro', 280),
('Earphone', 'Samsung', 'Galaxy Buds Pro', 220),
('Earphone', 'Samsung', 'Galaxy Buds Live', 170),
('Earphone', 'Sony', 'WF-1000XM4', 250),
('Headphone', 'Sony', 'WH-1000XM4', 400),
('Headphone', 'Apple', 'AirPods Max', 550),
('Headphone', 'Microsoft', 'Surface Headphones 2', 250),
('Smartwatch', 'Apple', 'Apple Watch Series 6', 1000),
('Smartwatch', 'Apple', 'Apple Watch SE', 400),
('Smartwatch', 'Samsung', 'Galaxy Watch 4', 600),
('Smartwatch', 'OnePlus', 'OnePlus Watch', 220);

SELECT * FROM product;

-- Write query to display the most expensive product under each category (corresponding to each record) 
SELECT *,
first_value(product_name) over() as most_exp_product
from product;

select *,
first_value(product_name) over(partition by product_category order by price desc) as most_exp_product
from product;

-- Write query to display the least expensive product under each category (corresponding to each record)
SELECT *,
last_value(product_name) over(partition by product_category order by price desc) as least_exp_product
from product;

select *,
first_value(product_name) over(partition by product_category order by price desc) as most_exp_product,
last_value(product_name) over(partition by product_category order by price desc
                              range between unbounded preceding and current row) as least_exp_product    
from product;


-- Changing frame clause for correct values
select *,
first_value(product_name) over(partition by product_category order by price desc) as most_exp_product,
last_value(product_name) over(partition by product_category order by price desc
                              range between unbounded preceding and unbounded following) as least_exp_product    
from product;

-- Alternate way to write SQL query using Window functions
select *,
first_value(product_name) over w as most_exp_product,
last_value(product_name) over w as least_exp_product    
from product
WHERE product_category ='Phone'
window w as (partition by product_category order by price desc
            range between unbounded preceding and unbounded following);
            
-- NTH_VALUE 
-- Write query to display the Second most expensive product under each category.
select *,
nth_value(product_name, 2) over w as second_most_exp_product
from product
window w as (partition by product_category order by price desc
            range between unbounded preceding and unbounded following);



