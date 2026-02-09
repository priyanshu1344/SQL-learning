create database priyanshu;
use priyanshu;

select * from globalsuperstore;

alter table globalsuperstore
change column `Order id` order_id varchar(20);

alter table globalsuperstore
change column `Order date` order_date date;

select `Postal Code` from globalsuperstore;

select state, count(distinct(`postal code`))
from globalsuperstore
group by state;

select count(`postal code`) from globalsuperstore
where `postal code` is null;

select count(`postal code`) from globalsuperstore
where `postal code` = "";

alter table globalsuperstore
modify column `postal code` int;

alter table globalsuperstore
change column  `Order Date` Order_Date date;


create database priyanshu;

select count(*) from globalsuperstore;

select * from globalsuperstore;

alter table globalsuperstore
change column `order date` order_date date;


select country, state, count(`postal code`) as code
from globalsuperstore
group by country, state
order by country;

commit;

select * from globalsuperstore;


select state, count(distinct(`postal code`)) -- 890
from globalsuperstore
group by state;

select state, count(distinct(`postal code`)) -- 43
from globalsuperstore
group by state
having (count(distinct(`postal code`))) >1;

-- 890 - 43 = 847

commit;

select state, `postal code`
from globalsuperstore
where state in (select state 
      from globalsuperstore
      group by state
      having (count(distinct(`postal code`))) >1) ;


with abc as
(
)
select `postal code`, 
case
    when `postal code` = "" then abc
    else `postal code`
end as code
from globalsuperstore;

drop database priyanshu;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- **SQL Practics project for learning data cleaning**

create database Global_Super_Store ; -- crete database

use Global_Super_Store; -- use that database

-- ** Start data import**

-- Import 4 .csv file (Order, People, Returns, Customer)
-- i am not able to import excel file so i convert it into 4 .csv file

rename table `order` to orders; -- rename because order is a pre-define keyword in mysql
rename table `returns` to return_s;  -- rename because returns is also pre-define keyword in mysql

select * from orders; -- 50990 records
select * from customer; -- 1590 records
select * from people; -- 999 records
select * from return_s;  -- 1173 records

-- ------------------------------------------------------

-- **now start data cleaning**

-- i have seen many table have blank record so firstly clear that all rows which are null

select count(*)
from orders
where `row id` = ""; -- 0 record, i have chose row ID because i not be null

select count(*)
from customer
where `customer id` = ""; -- 0 record , customer id it not be null

select count(*)
from people
where person  = "" and region = ""; -- 986 record found, i have use column because i dont have any unique column

select count(*)
from return_s
where `order id` = ""; -- 0 record, order id is not null

-- so i will delect record form people table which are null

delete from people
where person  = "" and region = "";  -- to run this queary i have uncheck safe mode

commit; -- for some time i have tunoff auto commit

select * from people; -- 13 record = 999 - 986

-- now my data have all rows which have data 

savepoint sp1;

-- now rename and modify(data type) column using change column

select * from people; -- only change datatype because column name is perfect

alter table people
modify column person varchar(40),
modify column region varchar(20);

savepoint sp2;

select * from return_s;

alter table return_s
modify column Returned enum('Yes','no'),
modify column Market varchar(20),
change column `Order ID` Order_ID varchar(40);

savepoint sp3;

select * from orders; -- i have no idea how to change date so before loading i have change date in yyyy-mm-dd format sorry for doing that

update orders
set `postal code` = null
where `postal code` = "";

savepoint sp4;

commit; 

alter table orders
rename column `row id` to Row_ID,
change column `Order ID` Order_ID varchar(30),
change column `Order Date` Order_Date date,
change column `Ship Date` Ship_Date date,
change column `Ship Mode` Ship_Mode varchar(20),
change column `Customer ID` Customer_ID varchar(20),
modify column Segment varchar(20),
modify column City varchar(40),
modify column State varchar(40),
modify column Country varchar(35),
change column `Postal Code` Postal_Code int,
modify column Market varchar(20),
modify column Region varchar(20),
change column `Product ID` Product_ID varchar(20),
modify column Category varchar(20),
change column `Sub-Category` Sub_Category varchar(20),
change column `Product Name` Product_Name varchar(150),
modify column Sales decimal(12,4),
modify column Quantity int,
modify column Discount decimal(6,2),
modify column Profit decimal (12,4),
change column `Shipping Cost` Shipping_Cost decimal(10,2),
change column `Order Priority` Order_Priority varchar(20);

select * from orders;

savepoint sp5;

select * from customer;

drop table customer; -- drop table customer because i am not able to clean date column in mysql or i have use excel

-- import customer table

select * from customer;

alter table customer
change column `Customer ID` Customer_ID varchar(10),
change column `Customer Name` Customer_Name varchar(30),
change column `Date of Birth` Date_of_Birth Date,      -- format in excel in  yyyy-mm-dd
change column `Marital Status` Marital_Status enum('M','S'),
change column `Date of First Purchase` Date_of_First_Purchase date,  -- use excel to clean it (=DATE(1970,1,1) + (A2/86400)) reason below after that queary
modify column Gender enum('M','F'),
change column `Yearly Income` Yearly_Income int;

-- Values like 1482969600 are UNIX timestamps. I convert them using the 1970 epoch before importing into MySQL
-- UNIX timestamps count seconds from 1 January 1970, so we use DATE(1970,1,1) as the base when converting to human-readable dates.

select * from orders;          -- 50990
select * from customer;        -- 1590
select * from people;          -- 13
select * from return_s;        -- 1173

select count(postal_code)         -- 9694
from orders
where Postal_Code = null;         -- 0 why 

-- String / Text Cleaning
-- TRIM(), LTRIM(), RTRIM(), REPLACE(), REGEXP_REPLACE(), LOWER(), UPPER(), INITCAP() (Oracle/Postgres), SUBSTRING() / SUBSTR(), 
-- LEFT(), RIGHT(), CONCAT(), CONCAT_WS(), LENGTH() / CHAR_LENGTH()

-- NULL Handling
-- IFNULL(), COALESCE(), NULLIF()

-- Type & Value Cleaning
-- CAST(), CONVERT(), ROUND(), CEILING(), FLOOR(), ABS()

-- Date Cleaning
-- STR_TO_DATE(), DATE_FORMAT(), DATEDIFF(), DATE_ADD(), DATE_SUB(), YEAR(), MONTH(), DAY()

-- Duplicate Handling
-- DISTINCT, ROW_NUMBER(), RANK(), DENSE_RANK()

-- Conditional Cleaning
-- CASE WHEN, IF()

-- Pattern Matching
-- LIKE, REGEXP, REGEXP_LIKE()

-- Other Useful
-- REVERSE(), LPAD(), RPAD(), POSITION() / LOCATE()

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- emp who not have manager

with z as
(
with current_manager as
(
-- current manager
select dm.emp_no, d.dept_name, d.dept_no 
from dept_manager as dm join departments as d 
on dm.dept_no = d.dept_no
where dm.to_date in (select max(to_date)
				  from salaries)
),
current_emp_and_dept as
(
-- current emp and there dept
select e.emp_no, d.dept_name, de.dept_no
from employees as e join dept_emp as de on e.emp_no = de.emp_no
join departments as d on d.dept_no = de.dept_no
where de.to_date  in (select max(to_date)
                       from salaries)
order by e.emp_no
)
select x.emp_no, x.dept_no, y.emp_no as r
from current_emp_and_dept as x join current_manager as y
on x.dept_no = y.dept_no
order by x.emp_no
)
select e.emp_no
from employees as e
where e.emp_no not in (select z.emp_no from z);


-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

create table test(
	s_no int primary key auto_increment,
    full_name varchar(30),
    gender enum('m','f'),
    aadhar_no int unique
    );
    
select * from test;

alter table test
drop index aadhar_no;

insert into test (full_name, gender, aadhar_no) values
   ('a','m',456698552),
   ('b','f',894561674),
   ('c','f',564875643),
   ('d','m',545678889),
   ('d','m',545678889),
   ('d','m',545678889)
   ;	
   
select distinct aadhar_no
from test;

delete from test
where aadhar_no not in (select distinct aadhar_no
						from test);

with a as
(select distinct aadhar_no
from test)
delete from test
where aadhar_no not in (select *
						from a);
                        
select * from test;

select * from test;

delete from test
where s_no not in (select min(s_no) from test group by full_name,gender,aadhar_no);

DELETE FROM test
WHERE s_no NOT IN (
    SELECT s_no FROM (
        SELECT MIN(s_no)
        FROM test
        GROUP BY full_name, gender, aadhar_no
    ) AS temp
);

select * from test;

SELECT full_name, gender, aadhar_no, COUNT(*) AS cnt
FROM test
GROUP BY full_name, gender, aadhar_no
HAVING COUNT(*) > 1;

DELETE FROM test
WHERE s_no NOT IN (
    SELECT s_no FROM (
        SELECT MIN(s_no) AS s_no
        FROM test
        GROUP BY aadhar_no
    ) x
);

-- -------------------------------------------------------------------------------------------------------------------------------------------------------
create table Test_2 (
	_no varchar(10) primary key,
    full_name varchar(30),
    gender enum('m','f'),
    aadhar_no int unique,
    sdf int
    );

select * from test_2;

insert into test_2
select * from test;

drop table test_2;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------

-- emp who have more salary then there manager

with current_manager_dept_salary as
(
	select emp_no, dept_name, max(salary) as salary
	from
		(select dm.emp_no, dm.dept_no, d.dept_name, s.salary
		from salaries as s join dept_manager as dm on s.emp_no = dm.emp_no
		join departments as d on d.dept_no = dm.dept_no
		where dm.to_date in (select max(s2.to_date)
							 from salaries as s2)
		) x
	group by emp_no, dept_name
),
current_emp_dept_salary as
(
	select emp_no, dept_name, max(salary) as salary
	from
	(
		select s3.emp_no, de.dept_no, d2.dept_name, s3.salary
		from salaries as s3 join dept_emp as de on s3.emp_no = de.emp_no
		join departments as d2 on de.dept_no = d2.dept_no
		where s3.to_date in (select max(s4.to_date)
							 from salaries as s4)
	) y
	group by emp_no, dept_name
)
select a.emp_no, a.salary 
from current_emp_dept_salary as a join current_manager_dept_salary as b
on a.dept_name = b.dept_name
where a.salary > b.salary;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------

-- find employee who currently working in more than one departemnt

select e.emp_no , count(dept_no)
from employees as e join dept_emp as de 
on e.emp_no = de.emp_no
where de.to_date in
				(select max(de2.to_date)            -- (select max(s.to_date)
                from dept_emp as de2)               --  from salaries as s)
group by e.emp_no
having count(dept_no) > 1;


-- find employess who salary never change seens joining

select emp_no
from salaries
group by emp_no
having min(salary) = max(salary);

select emp_no
from (
    select emp_no, salary,
	salary - lag(salary) over(partition by emp_no order by from_date) as increment
    from salaries
) x
group by emp_no
having max(increment) = 0 
or max(increment) = null;

-- find top 3 hightest grouth percentage employee

select emp_no, ((max(salary)-min(salary))/min(salary)) * 100 as inc_gro_per
from salaries
group by emp_no
order by inc_gro_per desc
limit 3;

-- rank employess , department wise based on there current salary

select s.emp_no, s.salary, d.dept_name,
rank() over(partition by de.dept_no order by s.salary desc) as rank_
from salaries as s join dept_emp as de 
on s.emp_no = de.emp_no
join departments as d on d.dept_no = de.dept_no
where de.to_date in (select max(s2.to_date)
					 from salaries as s2);

-- ----------------------------------------------------------------------------------------------------------------------------------------------------




