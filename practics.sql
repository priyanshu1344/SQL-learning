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

-- **SQL project with data cleaning**

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

