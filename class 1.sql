----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Leacture 1

-- Data - collection of raw information
-- database - where we stored the data
-- relational database - where we stored the data in the form of table
-- dbms/rdbms
-- MySQL
-- sql

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Leacture 2

-- case rule
-- 1)camel case = iPhone, iBall
-- 2)pascal case = PhonePay, GooglePay
-- 3)snake case = emp_info

-- Data type
-- 1)char : fixed length strings up to 255
-- 2)varchar : A variable length strings up to 65,535 - it include all specical char and integer
-- 3)int : stored integer
-- 4)enum : set of named, predefined constants, enum('m','f')
-- 5)decimal : it store decimal value like (8,2) = 958367.96
-- 6)Date : store the date -  yyyy-mm-dd

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Leacture 3

-- SQL command
-- 1) DDL - (data defination lang.)
-- (create, alter, drop, rename, truncate )

-- 2) DML - (data manipulation lang.)
-- (insert, update, delete)

-- 3) DQL - (data query lang.)
-- (select)

-- 4) DCL - (data control lang.)
-- (grant, revoke )

-- 5) TCL - (tranctional control lang.)
-- (commit, rollback, savepoint)


create database Emp_info;
use Emp_info;

create table employee(
	emp_no int,
    birth_date date,
    first_naem varchar(40),
    last_naem varchar(40),
    Gender enum('m','f'),
    hire_date date
    );

drop database emp_info;

-- constraints (rules)
-- 1) primary key
-- 2) forign key
-- 3) unique key
-- 4) null
-- 5) not null
-- 6) default
-- 7) check 

-----------------------------------------------

-- Home Work

create database sales_info;
use sales_info;

-- without key

CREATE TABLE sales (
    purchase_number INT,
    Date_of_purchase DATE,
    customer_id INT,
    item_code INT
);

CREATE TABLE customer (
    customer_id INT,
    first_name varchar(20),
    last_name varchar(20),
    email_address varchar(50),
    number_of_complaints int
);

CREATE TABLE items (
    item_code int,
    item varchar(100),
    unit_price int,
    company_id INT
);

CREATE TABLE companies (
    companies_id INT,
    companies_name varchar(50),
    headquarters_phone_number varchar(20)
);


-- with key

CREATE TABLE customer_key (
    customer_id INT primary key,
    first_name varchar(20),
    last_name varchar(20),
    email_address varchar(50),
    number_of_complaints int
);

CREATE TABLE companies_key (
    company_id INT primary key,
    company_name varchar(50),
    headquarters_phone_number varchar(20)
);

CREATE TABLE items_key (
    item_code int primary key,
    item varchar(100),
    unit_price int,
    company_id INT,
    foreign key (company_id) references companies_key(company_id)
);

CREATE TABLE sales_key (
    purchase_number INT primary key,
    Date_of_purchase DATE,
    customer_id INT,
    item_code INT,
    foreign key (customer_id) references customer_key (customer_id),
    foreign key (item_code) references items_key(item_code)
);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Leacture 4

use sales_info;

-- alter statement

-- 1) add primary key

alter table customer
add primary key (customer_id);

alter table companies
add primary key (companies_id);

alter table items
add primary key (item_code);

alter table sales 
add primary key (purchase_number);

-- 2) foreign key

alter table items
add foreign key (company_id) references companies (companies_id);

															-- just wasting time	-- select i.item, c.companies_name
																					-- from items i join companies c on i.company_id=c.companies_id;

alter table sales
add foreign key (customer_id ) references customer(customer_id),
add foreign key(item_code) references items(item_code);


-- insert statements

insert into customer(customer_id, first_name, last_name, email_address, number_of_complaints)
values( 101, 'priyanshu' , 'suryawanshi', 'priyanshu@gmail.com', 0);

select * from customer;

insert into customer values(102, 'om', 'ghate', 'om@gmail.com' ,5);

insert into customer values(103, 'apeksha', 'gadpayal', 'om@gmail.com' ,1);

-- 3) add unique key = add uk

alter table customer
add unique key (email_address);

delete from customer
where customer_id = 103;

insert into customer values(103, 'apeksha', 'gadpayal', 'apeksha@gmail.com' ,1);


-- 4) add column = add new column

alter table customer
add column gender char(1);

ALTER TABLE customer
ADD COLUMN middle_name varchar(40) first;

alter table customer
add column middle_name varchar(40) after first_name;

-- 5) drop column = delete column

alter table customer
drop column gender;

alter table customer
drop column middle_name;

-- 6) rename column = change name of column

alter table customer
rename column number_of_complaints to complaninsts;

-- 7) modify column = change data type of column

alter table  customer
modify column complaninsts varchar(10);

-- 8) change column

alter table customer
change column complaninsts number_of_complaints int default 0;


insert into customer value(104, 'rohit','' ,'rohit@gmail.com', 5);

select * from customer;

insert into customer (customer_id)
value(105); 

-- add pk , add fk, add uk, add column, drop column, modify column, change column, drop pk and fk


-- 9) drop pk and fk

-- alter table customer
-- add column customer_id int first;

-- alter table customer
-- drop column customer_id;

alter table customer
drop primary key;

alter table  sales
drop foreign key sales_ibfk_1; 

alter table customer
drop index email_address;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Leatcure 5

use employees;
select* from employees;
select * from dept_emp;
select * from dept_manager;
select * from departments;
select * from salaries;
select * from titles;

-- extract all the reocrd from empoyee

select * from employees;

select emp_no from employees;

select * from employees where first_name = 'saniya';

select * from employees where gender = 'f';

select * from employees where first_name= 'saniya' or  first_name  = 'parto';

-- what is difference between or and and
-- what is the use of where 

SELECT * FROM employees
WHERE gender = 'm' OR first_name = 'parto';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Leature 6

select emp_no, first_name, last_name, gender
from employees
where gender = 'M' and first_name = 'chirstian';

-- extract all the records from employees table who's first_name is saniya, parto, chirstian
-- georgi

select *
from employees
where first_name = 'Parto' or first_name = 'Saniya' or 
first_name = 'Chirstian' or first_name = 'Georgi';

select * from employees
where first_name in ('saniya', 'parto', 'chirstian','georgi');

select * from employees
where first_name not in ('saniya', 'parto', 'chirstian','georgi');

-- and, or, in, not in

-- extract all the records from employees table who's first_name 
-- start with A 

select emp_no, first_name, last_name, gender
from employees
where first_name like ('A%');


select emp_no, first_name, last_name, gender
from employees
where first_name like ('A%A');

-- As

select emp_no, first_name, last_name, gender
from employees
where first_name like ('As%');

-- A h

select emp_no, first_name, last_name, gender
from employees
where first_name like ('A_h%');
 
-- A h  6

select emp_no, first_name, last_name, gender
from employees
where first_name like ('A_h__h');

select emp_no, first_name, last_name, gender
from employees
where first_name not like ('A%');

-- >, <, <=, >=, <>, !=

-- find the employees records who's salary is higher than 80000.

select *
from salaries
where salary > 80000;

-- salary lower than 80000

select *
from salaries
where salary < 80000;

-- 80000 and higher

select *
from salaries
where salary >= 80000;

-- 80000 and 120000

select *
from salaries
where salary > 80000 and salary < 120000;

-- between and

select *
from salaries
where salary between 80000 and 120000;   -- between means(matlab) salary>=80000 and salary<=120000;

select *
from salaries
where salary <> 80000;

-- where (and, or, in, not in, like, not like, >,<,>=,<=,<> !=, between and)

-- extract all the female employees records from employees table
-- who's first_name is saniya or parto

select * from employees
where gender = 'F' and first_name in ('saniya', 'parto');

select * from employees
where gender = 'F' and (first_name = 'saniya' or first_name = 'parto');

------------------------------------

-- Revision

-- lecture 1
-- 1) Data - collection of raw info
-- 2) database - where we stored the data
-- 3) relational database - where we stored data in the form of tables
-- 4) dbms / rdbms 
-- 5) MySQL 
-- 6) SQL 
-- 7) MySQL vs SQL

-- lecture 2
-- Data types
-- int, decimal, char, varchar, date, enum
-- char vs varchar
-- SQL commands
-- 1) DDL - create, alter, drop, rename, truncate
-- 2) DML - insert into, update, delete
-- 3) DQL - select
-- 4) DCL - Grant, revoke
-- 5) TCL - commit, rollback, savepoint

-- Lecture 3
-- constraints
-- 1) Primary key 
-- 2) foreign key
-- 3) unique key
-- 4) default
-- 5) null
-- 6) not null
-- 7) check

-- create statements (database, table) 

-- lecture 4 
-- alter (add primary key, add foeign key, add unique key, add column, drop column
-- drop primary key, drop foreign key, drop index, rename column, modify column, change column)

-- Lecture 5
-- employees database load
-- employees database
-- select (column_name), from (table_name), where(condition)
-- and, or

-- Lecture 6
-- select, from, where
-- where (and, or, in, not in, like, not like, >,<,>=,<=,<> !=, between and)

---------------------------------------------

-- Home Work

create database sales_db;

use sales_db;

create table customers ( 
    customer_id INT PRIMARY KEY ,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(10),
    country VARCHAR(50)
    );
    
create table products (
    product_id INT PRIMARY KEY ,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2),
    stock_quantity INT,
    supplier VARCHAR(100)
);

create table sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    sale_date DATE,
    total_amount DECIMAL(10,2),
    foreign key (customer_id) references customers (customer_id)
);
use sales_db;
select * from sales;

create table sales_items ( 
    sales_item_id INT PRIMARY KEY,
    sale_id INT ,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2),
    foreign key (sale_id) references sales (sale_id)
);

alter table sales_items
add foreign key (product_id) references products (product_id);

CREATE TABLE payments (
    payment_id INT primary key,
    sale_id INT,
    payment_date DATE,
    amount DECIMAL(10 , 2 ),
    payment_method varchar(50),
    foreign key (sale_id) references sales (sale_id)
);


INSERT INTO customers (customer_id, first_name, last_name, email, phone, address, city, state, postal_code, country)
VALUES
(1, 'Rahul', 'Sharma', 'rahul.sharma@example.com', '9876543210', '123 MG Road', 'Mumbai', 'Maharashtra', '400001', 'India'),
(2, 'Priya', 'Mehta', 'priya.mehta@example.com', '9123456789', '45 Park Street', 'Pune', 'Maharashtra', '411001', 'India'),
(3, 'Amit', 'Verma', 'amit.verma@example.com', '9988776655', '78 Ring Road', 'Delhi', 'Delhi', '110001', 'India'),
(4, 'Sneha', 'Patil', 'sneha.patil@example.com', '9812345678', '22 Baner Road', 'Pune', 'Maharashtra', '411045', 'India'),
(5, 'Rohit', 'Kapoor', 'rohit.kapoor@example.com', '9765432109', '56 Andheri East', 'Mumbai', 'Maharashtra', '400059', 'India');

select * from customers;

INSERT INTO products (product_id, product_name, category, unit_price, stock_quantity, supplier)
VALUES
(101, 'Laptop HP', 'Electronics', 55000.00, 10, 'HP India'),
(102, 'iPhone 14', 'Electronics', 75000.00, 5, 'Apple India'),
(103, 'Office Chair', 'Furniture', 8000.00, 20, 'Godrej'),
(104, 'Coffee Maker', 'Appliances', 4500.00, 15, 'Philips'),
(105, 'Samsung TV 43"', 'Electronics', 40000.00, 8, 'Samsung India');

select * from products;

INSERT INTO sales (sale_id, customer_id, sale_date, total_amount)
VALUES
(1001, 1, '2025-09-01', 59500.00),
(1002, 2, '2025-09-05', 8000.00),
(1003, 3, '2025-09-07', 79500.00),
(1004, 4, '2025-09-10', 4500.00),
(1005, 5, '2025-09-12', 95000.00);

select * from sales;

INSERT INTO sales_items (sales_item_id, sale_id, product_id, quantity, unit_price, total_price)
VALUES
(1, 1001, 101, 1, 55000.00, 55000.00),
(2, 1001, 104, 1, 4500.00, 4500.00),
(3, 1002, 103, 1, 8000.00, 8000.00),
(4, 1003, 102, 1, 75000.00, 75000.00),
(5, 1003, 103, 1, 4500.00, 4500.00);

select * from sales;

INSERT INTO payments (payment_id, sale_id, payment_date, amount, payment_method)
VALUES
(1, 1001, '2025-09-01', 59500.00, 'UPI'),
(2, 1002, '2025-09-05', 8000.00, 'Cash'),
(3, 1003, '2025-09-07', 40000.00, 'Card'),
(4, 1003, '2025-09-08', 39500.00, 'UPI'),
(5, 1004, '2025-09-10', 4500.00, 'Cash');

select * from payments;
 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Leacture 7
-- Aggregate functions
-- sum, min,max,avg,count

use employees;

select * from salaries;

select emp_no, sum(salary) as total_salary 
from salaries
where emp_no = 10001;

select emp_no, max(salary) as max_salary 
from salaries
where emp_no = 10001;

select emp_no, min(salary) as min_salary 
from salaries
where emp_no = 10001;

select emp_no, count(salary) as count_salary_no
from salaries
where emp_no = 10001;

-- GROUP BY

select emp_no, sum(salary)
from salaries
group by emp_no;

SELECT EMP_NO, SUM(SALARY)
FROM SALARIES
WHERE EMP_NO > 11000
group by EMP_NO;

select emp_no, sum(salary)
from salaries
where emp_no> 10010 
group by emp_no
having sum(salary) > 1200000;

-- HAVING

SELECT EMP_NO, SUM(SALARY) AS TOTAL_SALARY
FROM SALARIES
WHERE EMP_NO > 10010
group by EMP_NO
HAVING TOTAL_SALARY > 1200000;

-- diiference between where and having
-- WHERE                                              HAVING
-- Filters rows before grouping                       Filters groups after grouping
-- Works On Individual rows                           Groups created by GROUP BY

-- can we use where insted of having or vise viersa
-- No, we cannot use WHERE instead of HAVING
-- YES, HAVING can do everything WHERE does, but doing this is bad practice and 
-- slower because HAVING works after grouping, not before.

select emp_no ,avg(salary)
from salaries
group by  emp_no
having avg(salary) > 75000;

select emp_no ,avg(salary)
from salaries
group by  emp_no
having avg(salary) > 75000
order by AVG(SALARY) DESC
LIMIT 3;

-- SQL QUEARY WRITING SEQUENCE
-- SELECT , FROM, JOIN, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT

-- SQL QUEARY EXCEUTION SEQUENCE
-- FROM, JOIN, WHERE, GROUP BY, HAVING, SELECT, DISTINCT, ORDER BY, LIMIT

select emp_no ,avg(salary)
from salaries
group by  emp_no
having emp_no > 10010 and avg(salary) > 75000;

-------------------------------------------------------------

-- my work in free time just wast of time

use sales_info;

create table shop_in
(
   cust_id int primary key,
   cust_name varchar (100),
   cust_email varchar (100) unique,
   gender char (1),
   phone int (12) unique
   );
   
insert into shop_in values
(101, 'priyanshu', 'priyanshu@123', 'm', 12345);  
   
insert into shop_in values
(102,'' , 'om@123', 'm', 134589);
   
insert into shop_in values
(103,'arti' , ' ', 'm', 1234589);   

insert into shop_in values
(104,'arti' , null, 'm', 123458564);

insert into shop_in values
(105,'arti' , ' ', 'm', 1234578589);
 
insert into shop_in values
(106,'arti' , null, 'm', 458548564);

insert into shop_in values
(107,'arti' , '', 'm', 94578589);

insert into shop_in () values
(108,'arti' , '', 'm', 4578589);

insert into shop_in values
(109,'arti' , '', 'm', 4578589);

-- we can insert multiple NULL values in a UNIQUE column because NULL means unknown.
-- But we cannot insert multiple empty strings ('') because an empty string is a real value.

select * from shop_in;
   
drop table shop_in;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Leacture 8

use employees;

-- limit 1 offset 2 = top 3rd salary

select emp_no , avg(salary)
from salaries
where emp_no > 11000
group by emp_no
order by avg(salary) desc
limit 1 offset 2;

select emp_no , avg(salary)
from salaries
where emp_no > 11000
group by emp_no;


-- JOINS
-- INNER JOIN, LEFT JOIN, RIGHT JOIN, SELF JOIN, CROSS JOIN


-- OUTER JOINS
-- LEFT OUTER JOIN = LEFT JOIN
-- RIGHT OUTER JOIN = RIGHT JOIN


-- LEFT JOIN = all the data from left table and common data from right table
-- RIGHT JOIN= all the data from right table and common data from left table
-- INNER JOIN = common data from both the table



-- Leacture 9

-- JOINS
use employees;
select * from employees;
select * from salaries;


select emp_no, sum(salary)
from salaries
group by emp_no;



-- on delete cascade

select m.emp_no, sum(s.salary)
from dept_manager as m left join salaries as s on m.emp_no = s.emp_no
group by m.emp_no;



select m.emp_no, e.first_name, e.last_name ,sum(s.salary)
from dept_manager as m left join salaries  as s on m.emp_no = s.emp_no
join employees as e on e.emp_no = m.emp_no
group by m.emp_no;



select e.emp_no, e.first_name, e.last_name , m.dept_no, d.dept_name
from employees as e join dept_emp as m on e.emp_no = m.emp_no
join departments as d on m.dept_no = d.dept_no;


-- 1) find how many employees working in each department
-- 2) find the department who have more than 50000 employees working

select count(e.emp_no) as total_employees, d.dept_name 
from employees as e join dept_emp as m on e.emp_no = m.emp_no
join departments as d on d.dept_no = m.dept_no
group by d.dept_name;

select d.dept_name , count(e.emp_no)
from employees as e join dept_emp as m on e.emp_no = m.emp_no
join departments as d on d.dept_no = m.dept_no
group by d.dept_name
having count(e.emp_no) > 50000;






-- Lecture 10   -- sir notes from (10,11,12,13,14) 


-- select, from, where, group by, having, order by, limit
-- from, where, group by, having, select, order by, limit

-- 1) find how many employees working in each departments.

select * from departments;

select * from dept_emp;

select d.dept_no, d.dept_name, count(de.emp_no) as no_of_employees
from dept_emp de join departments d on de.dept_no = d.dept_no
group by d.dept_no
having no_of_employees > 50000;


-- 2) find the departments who have more than 50000 employees working.






-- DDL - Create, alter, drop, rename, truncate
-- DML - insert, update, delete
-- DQL - select
-- DCL - grant, revoke
-- TCL - Commit, rollback, savepoint

-- update, drop, delete, truncate, commit, rollback, savepoint

rename table employees to employee_info;
rename table employee_info to employees;

-- DDL - create, alter, drop, rename, truncate
-- DML - insert, update, delete
-- DQL - select
-- DCL - grant, revoke
-- TCL - commit, rollback

-- select, from, where, group by, having, order by, limit
-- from, where, group by, having, select, order by, limit

-- update

select * from employees;

-- update table_name
-- set values
-- where condition 

update employees
set first_name = 'Om'
where emp_no = 10001;

select * from employees;

-- commit, rollback

commit;

update employees
set first_name = 'Georgi'
where emp_no = 10001;

select * from employees;

rollback;

update employees
set first_name = 'Georgi'
where emp_no = 10001;

commit;

select * from employees;

update employees
set first_name = 'Om';

rollback;
commit;

select * from employees;

commit;

update employees 
set first_name = 'Om'
where emp_no = 10001;

update employees
set first_name = 'Sai'
where emp_no = 10002;


select * from employees;
rollback;
commit;

select * from employees;

update employees 
set first_name = 'Om'
where emp_no = 10001;

savepoint sp1;

update employees
set first_name = 'Sai'
where emp_no = 10002;

savepoint sp2;

rollback to sp1;

select * from employees;

update employees 
set first_name = 'Georgi'
where emp_no = 10001;

commit;

select * from employees;

-- Drop, delete, truncate

commit;

create table emp_100 as
select * from employees limit 100;

select * from emp_100;

commit;

-- delete 

-- delete from table_name
-- where condition

select * from emp_100;

delete from emp_100
where emp_no = 10001;

rollback;
commit;

delete from emp_100
where emp_no < 10011;

select * from emp_100;

rollback;
commit;

select * from emp_100;

delete from emp_100;

rollback;
commit;

-- truncate

-- truncate table table_name

select * from emp_100;

truncate table emp_100;

rollback;
commit;

-- auto increment

-- drop
select * from emp_100;

-- drop table table_name
drop table emp_100;
select * from emp_100;

rollback;
commit;

-- school_db

create database school_db;

use school_db;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(40),
    email VARCHAR(40),
    city VARCHAR(40)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_title VARCHAR(40),
    category VARCHAR(40),
    price DECIMAL
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE,
    FOREIGN KEY (student_id)
        REFERENCES students (student_id),
    FOREIGN KEY (course_id)
        REFERENCES courses (course_id)
);

CREATE TABLE progress (
    progress_id INT PRIMARY KEY,
    enrollment_id INT,
    completion_percent DECIMAL,
    last_access_date DATE,
    FOREIGN KEY (enrollment_id)
        REFERENCES enrollments (enrollment_id)
);

INSERT INTO Students (student_id, student_name, email, city) VALUES
(1, 'Alice Johnson', 'alice@example.com', 'Mumbai'),
(2, 'Bob Smith', 'bob@example.com', 'Pune'),
(3, 'Charlie Brown', 'charlie@example.com', 'Delhi'),
(4, 'Diana Prince', 'diana@example.com', 'Bangalore'),
(5, 'Ethan Lee', 'ethan@example.com', 'Hyderabad');

INSERT INTO Courses (course_id, course_title, category, price) VALUES
(101, 'Python for Beginners', 'Programming', 1999.00),
(102, 'Advanced Excel', 'Data Analysis', 1499.00),
(103, 'Web Development Bootcamp', 'Web Development', 2499.00),
(104, 'Machine Learning Basics', 'AI/ML', 2999.00),
(105, 'Digital Marketing 101', 'Marketing', 1799.00);

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enroll_date) VALUES
(1001, 1, 101, '2025-07-01'),
(1002, 1, 103, '2025-07-10'),
(1003, 2, 102, '2025-07-05'),
(1004, 3, 104, '2025-07-08'),
(1005, 4, 105, '2025-07-15'),
(1006, 5, 101, '2025-07-20'),
(1007, 5, 104, '2025-07-25');

INSERT INTO Progress (progress_id, enrollment_id, completion_percent, last_access_date) VALUES
(2001, 1001, 100.00, '2025-08-01'),
(2002, 1002, 60.00, '2025-08-05'),
(2003, 1003, 80.00, '2025-08-03'),
(2004, 1004, 45.00, '2025-08-04'),
(2005, 1005, 100.00, '2025-08-02'),
(2006, 1006, 20.00, '2025-08-06'),
(2007, 1007, 35.00, '2025-08-06');

-- Q1: List all students with the course titles they are enrolled in.

-- student_id, name, course_title

select s.student_id, s.student_name, c.course_title
from students s left join enrollments e on s.student_id = e.student_id
join courses c on c.course_id = e.course_id;

-- Q2: Show the names of students from the city 'Mumbai' 
-- who are enrolled in any course.

select s.student_id, s.student_name, c.course_title
from students s left join enrollments e on s.student_id = e.student_id
join courses c on c.course_id = e.course_id
where s.city = 'Mumbai';

-- Q3: Count how many students are enrolled in each course.

select c.course_title, count(s.student_id) as no_of_students
from students s left join enrollments e on s.student_id = e.student_id
join courses c on c.course_id = e.course_id
group by c.course_title;

-- Q4: Find all courses with more than 1 student enrolled.
select c.course_title, count(s.student_id) as no_of_students
from students s left join enrollments e on s.student_id = e.student_id
join courses c on c.course_id = e.course_id
group by c.course_title
having no_of_students > 1;

-- Q5: Find the average completion percentage for each student.
-- student_id, name, avg_per

select s.student_id, s.student_name, avg(p.completion_percent) as avg_complition_percent
from students s  join enrollments e on s.student_id = e.student_id
join progress p on p.enrollment_id = e.enrollment_id
group by s.student_id;

-- Q6: List students who accessed their course progress after '2025-08-04'. 

select s.student_id, s.student_name
from students s  join enrollments e on s.student_id = e.student_id
join progress p on p.enrollment_id = e.enrollment_id
where last_access_date > '2025-08-04';

-- Q7: Find the total price of all courses each student is enrolled in.

select c.course_id, c.course_title, sum(c.price) as total_price
from courses c join enrollments e on c.course_id = e.course_id
group by c.course_id;




-- lecture 13




-- self join and cross join

-- cross join

select * from departments;
select * from dept_manager;

select * from departments cross join dept_manager;

create table info (emp_id int,emp_name varchar(40),manager_id int);

insert into info values (1,'shiv',5),
(2,'om',4),
(3,'sakshi',2),
(4,'rahul',1),
(5,'sham',3);

select * from info;

-- self join

select a.emp_id, a.emp_name,a.manager_id, b.emp_name as manager_name
from info a join info b on a.manager_id = b.emp_id;

-- Sales Database

select * from customers;
select * from payments;
select * from products;
select * from sales;
select * from sales_items;


-- 1)Write a query to find the total sales amount made by each customer.

select c.customer_id, c.first_name, c.last_name, sum(s.total_amount) as total_sales
from customers c join sales s on c.customer_id = s.customer_id
group by c.customer_id;

-- 2)Find how many products are available in each product category.

select category, count(product_name) as no_of_products_available
from products
group by category;

-- 3)Display customer names and their total purchase amounts,
-- but only for those who spent more than ₹50,000.

select c.customer_id, c.first_name, c.last_name, sum(s.total_amount) as total_purchase_amount
from customers c join sales s on c.customer_id = s.customer_id
group by c.customer_id
having total_purchase_amount > 50000;

-- 4)Find the product name that generated the highest total 
-- sales amount (quantity × unit_price).

select p.product_id, p.product_name, sum(s.quantity * s.unit_price) as highest_sales_amount
from products p join sales_items s on p.product_id = s.product_id
group by p.product_id
order by highest_sales_amount desc
limit 1;

-- 5)Identify sales where customers made payments in more than one transaction.

-- 6) Show each customer with the list of product names they purchased

select c.customer_id, c.first_name, c.last_name, p.product_name
from customers c join sales s on c.customer_id = s.customer_id
join sales_items s1 on s.sale_id = s1.sale_id
join products p on p.product_id = s1.product_id;

-- 7) Calculate the total sales amount per month.

select monthname(sale_date) as month_name, sum(total_amount) as total_sales
from sales
group by month_name;

-- 8) List customers who purchased more than one distinct product in their orders.

-- 9) Find sales where the total payments received are less than the total_amount in sales.

-- 10) Show each customer with their average sale value.





-- Leacture 14

-- Subquery

-- find the employees records who's salary is higher than avg_salary of all employees.

select avg(salary) as avg_salary from salaries; -- 63761.2043

select * from salaries
where salary > 63761.2043;

select * from salaries
where salary > (select avg(salary) as avg_salary from salaries);

insert into salaries values (10001,1000000000,'2024-01-01','2025-01-01');

-- subquery - query inside another query

-- ways to write subquery
-- 1) subquery inside select
-- 2) subquery inside from
-- 3) subquery inside where

-- types of subquery
-- 1) single row subquery
-- 2) multiple row subquery
-- 3) scalar subquery
-- 4) correlated subquery
-- 5) nested subquery

-- find the all manager's emp_no, first_name, last_name, gender

select dm.emp_no, e.first_name, e.last_name, e.gender
from employees e join dept_manager dm on e.emp_no = dm.emp_no;

select emp_no, first_name, last_name, gender
from employees 
where emp_no in (select emp_no from dept_manager); 

-- in = compares a value to a list of values
-- exists = checks only whether at least one row exists in the subquery

select emp_no, first_name, last_name, gender
from employees e
where exists (select emp_no,dept_no from dept_manager dm where e.emp_no = dm.emp_no); 



select emp_no, first_name, last_name, gender
from employees 
where emp_no in (select emp_no from dept_manager
where emp_no in (select emp_no from titles where title = 'Manager')); 

-- find the total_salary of each manager.

select dm.emp_no, first_name, last_name, sum(s.salary) as total_salary
from salaries s join dept_manager dm on s.emp_no = dm.emp_no
join employees e on e.emp_no = s.emp_no
group by emp_no;


select emp_no, sum(salary)
from salaries
where emp_no in (select emp_no from dept_manager)
group by emp_no;




-- Stored Routine 




-- Leacture 15





