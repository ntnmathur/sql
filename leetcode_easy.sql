-- A country is big if it has an area of bigger than 3 million square km or a population of more than 25 million.
-- Write a SQL solution to output big countries' name, population and area.

DROP table if EXISTS  world;
Create table If Not Exists World (name varchar(255), continent varchar(255), area bigint, population bigint, gdp bigint);
Truncate table World;
insert into World (name, continent, area, population, gdp) values ('Afghanistan', 'Asia', '652230', '25500100', '20343000000');
insert into World (name, continent, area, population, gdp) values ('Albania', 'Europe', '28748', '2831741', '12960000000');
insert into World (name, continent, area, population, gdp) values ('Algeria', 'Africa', '2381741', '37100000', '188681000000');
insert into World (name, continent, area, population, gdp) values ('Andorra', 'Europe', '468', '78115', '3712000000');
insert into World (name, continent, area, population, gdp) values ('Angola', 'Africa', '1246700', '20609294', '100990000000');

select * from World
where population > 25000000
or area > 30000000;


-- Table point holds the x coordinate of some points on x-axis in a plane, which are all integers.
-- Write a query to find the shortest distance between two points in these points.

CREATE TABLE If Not Exists point (x INT NOT NULL);
Truncate table point;
insert into point (x) values ('-1');
insert into point (x) values ('0');
insert into point (x) values ('2');

select
  MIN(ABS(p1.x - p2.x))
  from point p1
  inner join point p2
    on p1.x != p2.x;

-- Given a table salary, such as the one below, that has m=male and f=female values.
-- Swap all f and m values (i.e., change all f values to m and vice versa) with a single update query and no intermediate temp table.
create table if not exists salary(id int, name varchar(100), sex char(1), salary int);
Truncate table salary;
insert into salary (id, name, sex, salary) values ('1', 'A', 'm', '2500');
insert into salary (id, name, sex, salary) values ('2', 'B', 'f', '1500');
insert into salary (id, name, sex, salary) values ('3', 'C', 'm', '5500');
insert into salary (id, name, sex, salary) values ('4', 'D', 'f', '500');

update salary
set sex = CASE WHEN sex = 'm' THEN 'f'
                WHEN sex = 'f' THEN 'm' END;

SELECT  * FROM salary;

-- Given a table customer holding customers information and the referee.
-- Write a query to return the list of customers NOT referred by the person with id '2'.

CREATE TABLE IF NOT EXISTS customer (id INT,name VARCHAR(25),referee_id INT);
Truncate table customer;
insert into customer (id, name, referee_id) values ('1', 'Will', NULL);
insert into customer (id, name, referee_id) values ('2', 'Jane', NULL);
insert into customer (id, name, referee_id) values ('3', 'Alex', '2');
insert into customer (id, name, referee_id) values ('4', 'Bill', NULL);
insert into customer (id, name, referee_id) values ('5', 'Zack', '1');
insert into customer (id, name, referee_id) values ('6', 'Mark', '2');

SELECT name from customer
where referee_id !=2 or referee_id is null;

-- A pupil Tim gets homework to identify whether three line segments could possibly form a triangle.
-- However, this assignment is very heavy because there are hundreds of records to calculate.
-- Could you help Tim by writing a query to judge whether these three sides can form a triangle,
-- assuming table triangle holds the length of the three sides x, y and z.
Create table If Not Exists triangle (x int, y int, z int);
Truncate table triangle;
insert into triangle (x, y, z) values ('13', '15', '30');
insert into triangle (x, y, z) values ('10', '20', '15');

SELECT
  *,
  CASE WHEN (x+y) > z and (x+z) > y and (y+z) > x THEN 'Yes' ELSE 'No' END as triangle
FROM triangle;


-- Query the customer_number from the orders table for the customer who has placed the largest number of orders.
-- It is guaranteed that exactly one customer will have placed more orders than any other customer.
Create table If Not Exists orders (order_number int, customer_number int, order_date date, required_date date, shipped_date date, status char(15), comment char(200));
Truncate table orders;
insert into orders (order_number, customer_number) values ('1', '1');
insert into orders (order_number, customer_number) values ('2', '2');
insert into orders (order_number, customer_number) values ('3', '3');
insert into orders (order_number, customer_number) values ('4', '3');

select
  customer_number
from orders
GROUP BY customer_number
ORDER BY count(*) DESC
LIMIT 1;


-- Several friends at a cinema ticket office would like to reserve consecutive available seats.
-- Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?

Create table If Not Exists cinema (seat_id int, free bool);
Truncate table cinema;
insert into cinema (seat_id, free) values ('1', '1');
insert into cinema (seat_id, free) values ('2', '0');
insert into cinema (seat_id, free) values ('3', '1');
insert into cinema (seat_id, free) values ('4', '1');
insert into cinema (seat_id, free) values ('5', '1');

SELECT DISTINCT a.seat_id
from cinema a
inner join cinema b
  on abs(a.seat_id - b.seat_id) = 1
and a.free = TRUE and b.free = TRUE;


-- Select all employee's name and bonus whose bonus is < 1000.
Create table If Not Exists Employee (EmpId int, Name varchar(255), Supervisor int, Salary int);
Create table If Not Exists Bonus (EmpId int, Bonus int);
Truncate table Employee;
insert into Employee (EmpId, Name, Supervisor, Salary) values ('3', 'Brad', Null, '4000');
insert into Employee (EmpId, Name, Supervisor, Salary) values ('1', 'John', '3', '1000');
insert into Employee (EmpId, Name, Supervisor, Salary) values ('2', 'Dan', '3', '2000');
insert into Employee (EmpId, Name, Supervisor, Salary) values ('4', 'Thomas', '3', '4000');
Truncate table Bonus;
insert into Bonus (EmpId, Bonus) values ('2', '500');
insert into Bonus (EmpId, Bonus) values ('4', '2000');

SELECT
  e.Name,
  b.Bonus
  from Employee e
left JOIN bonus b
    on e.EmpId = b.EmpId
where b.Bonus < 1000 or b.Bonus is null;


-- Given three tables: salesperson, company, orders.
-- Output all the names in the table salesperson, who didn’t have sales to company 'RED'.
Create table If Not Exists salesperson (sales_id int, name varchar(255), salary int,commission_rate int, hire_date varchar(255));
Create table If Not Exists company (com_id int, name varchar(255), city varchar(255));
drop table if EXISTS orders;
Create table If Not Exists orders (order_id int, date varchar(255), com_id int, sales_id int, amount int);
Truncate table company;
insert into company (com_id, name, city) values ('1', 'RED', 'Boston');
insert into company (com_id, name, city) values ('2', 'ORANGE', 'New York');
insert into company (com_id, name, city) values ('3', 'YELLOW', 'Boston');
insert into company (com_id, name, city) values ('4', 'GREEN', 'Austin');
Truncate table salesperson;
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('1', 'John', '100000', '6', '4/1/2006');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('2', 'Amy', '12000', '5', '5/1/2010');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('3', 'Mark', '65000', '12', '12/25/2008');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('4', 'Pam', '25000', '25', '1/1/2005');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('5', 'Alex', '5000', '10', '2/3/2007');
Truncate table orders;
insert into orders (order_id, date, com_id, sales_id, amount) values ('1', '1/1/2014', '3', '4', '10000');
insert into orders (order_id, date, com_id, sales_id, amount) values ('2', '2/1/2014', '4', '5', '5000');
insert into orders (order_id, date, com_id, sales_id, amount) values ('3', '3/1/2014', '1', '1', '50000');
insert into orders (order_id, date, com_id, sales_id, amount) values ('4', '4/1/2014', '1', '4', '25000');


select s.*
  from salesperson s
    where s.sales_id not in
(SELECT
  o.sales_id
  from orders o
inner join company c
    on o.com_id = c.com_id
where c.name = 'RED');


-- Write a SQL query to find all duplicate emails in a table named Person.

Create table If Not Exists Person (Id int, Email varchar(255));
Truncate table Person;
insert into Person (Id, Email) values ('1', 'a@b.com');
insert into Person (Id, Email) values ('2', 'c@d.com');
insert into Person (Id, Email) values ('3', 'a@b.com');

select Email
from person
GROUP BY Email
HAVING count(*)  > 1;

-- Write a SQL query for a report that provides the following information for each person in the Person table,
-- regardless if there is an address for each of those people:
-- FirstName, LastName, City, State
DROP table if EXISTS Person;
Create table If Not Exists Person (PersonId int, FirstName varchar(255), LastName varchar(255));
Create table If Not Exists Address (AddressId int, PersonId int, City varchar(255), State varchar(255));
Truncate table Person;
insert into Person (PersonId, LastName, FirstName) values ('1', 'Wang', 'Allen');
Truncate table Address;
insert into Address (AddressId, PersonId, City, State) values ('1', '1', 'New York City', 'New York');

SELECT * from Address;
SELECT * from Person;

select
  p.FirstName, p.LastName, a.City, a.State
  from Person p
INNER JOIN Address a
    on p.PersonId = a.PersonId;


-- In social network like Facebook or Twitter, people send friend requests and accept others’ requests as well.
-- Write a query to find the overall acceptance rate of requests rounded to 2 decimals, which is the number of acceptance divide the number of requests.

Create table If Not Exists friend_request ( sender_id INT NOT NULL, send_to_id INT NULL, request_date DATE NULL);
Create table If Not Exists request_accepted ( requester_id INT NOT NULL, accepter_id INT NULL, accept_date DATE NULL);
Truncate table friend_request;
insert into friend_request (sender_id, send_to_id, request_date) values ('1', '2', '2016/06/01');
insert into friend_request (sender_id, send_to_id, request_date) values ('1', '3', '2016/06/01');
insert into friend_request (sender_id, send_to_id, request_date) values ('1', '4', '2016/06/01');
insert into friend_request (sender_id, send_to_id, request_date) values ('2', '3', '2016/06/02');
insert into friend_request (sender_id, send_to_id, request_date) values ('3', '4', '2016/06/09');
Truncate table request_accepted;
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '2', '2016/06/03');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '3', '2016/06/08');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('2', '3', '2016/06/08');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/09');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/10');

select
round(abs(
    (SELECT CAST(count(*) AS DECIMAL(25,2)) FROM (SELECT DISTINCT
                            requester_id,
                            accepter_id
                          FROM request_accepted) B)/
    (SELECT count(*) FROM (SELECT DISTINCT
                             sender_id,
                             send_to_id
                           FROM friend_request) A)
),2);

-- The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.
-- Given the Employee table, write a SQL query that finds out employees who earn more than their managers.
-- For the above table, Joe is the only employee who earns more than his manager.
DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (Id int, Name varchar(255), Salary int, ManagerId int);
Truncate table Employee;
insert into Employee (Id, Name, Salary, ManagerId) values ('1', 'Joe', '70000', '3');
insert into Employee (Id, Name, Salary, ManagerId) values ('2', 'Henry', '80000', '4');
insert into Employee (Id, Name, Salary, ManagerId) values ('3', 'Sam', '60000', NULL);
insert into Employee (Id, Name, Salary, ManagerId) values ('4', 'Max', '90000', NULL);

SELECT
  emp.Name employee_name,
  mgr.Name mgr_name,
  emp.Salary employee_sal,
  mgr.Salary mgr_sal
  from Employee emp
 left join Employee mgr
    on emp.ManagerId = mgr.id
Where emp.Salary > mgr.Salary;


-- Table number contains many numbers in column num including duplicated ones.
-- Can you write a SQL query to find the biggest number, which only appears once.

Create table If Not Exists number (num int);
Truncate table number;
insert into number (num) values ('8');
insert into number (num) values ('8');
insert into number (num) values ('3');
insert into number (num) values ('3');
insert into number (num) values ('1');
insert into number (num) values ('4');
insert into number (num) values ('5');
insert into number (num) values ('6');

select max(num)
  from
(select num
from number
GROUP BY num
HAVING count(*) = 1) X;

-- Suppose that a website contains two tables, the Customers table and the Orders table.
-- Write a SQL query to find all customers who never order anything.
Create table If Not Exists Customers (Id int, Name varchar(255));
drop table if exists orders;
Create table If Not Exists Orders (Id int, CustomerId int);
Truncate table Customers;
insert into Customers (Id, Name) values ('1', 'Joe');
insert into Customers (Id, Name) values ('2', 'Henry');
insert into Customers (Id, Name) values ('3', 'Sam');
insert into Customers (Id, Name) values ('4', 'Max');
Truncate table Orders;
insert into Orders (Id, CustomerId) values ('1', '3');
insert into Orders (Id, CustomerId) values ('2', '1');


select
  c.name
from Customers c
left join orders o
  on c.id = o.CustomerId
where o.id is null;

-- Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.
Create table If Not Exists Weather (Id int, Date date, Temperature int);
Truncate table Weather;
insert into Weather (Id, Date, Temperature) values ('1', '2015-01-01', '10');
insert into Weather (Id, Date, Temperature) values ('2', '2015-01-02', '25');
insert into Weather (Id, Date, Temperature) values ('3', '2015-01-03', '20');
insert into Weather (Id, Date, Temperature) values ('4', '2015-01-04', '30');

select
  w2.id
  from Weather w1
inner join Weather w2
    on w1.date = w2.date - 1
where w1.Temperature < w2.Temperature;

-- Please list out all classes which have more than or equal to 5 students.

Create table If Not Exists courses (student varchar(255), class varchar(255));
Truncate table courses;
insert into courses (student, class) values ('A', 'Math');
insert into courses (student, class) values ('B', 'English');
insert into courses (student, class) values ('C', 'Math');
insert into courses (student, class) values ('D', 'Biology');
insert into courses (student, class) values ('E', 'Math');
insert into courses (student, class) values ('F', 'Computer');
insert into courses (student, class) values ('G', 'Math');
insert into courses (student, class) values ('H', 'Math');
insert into courses (student, class) values ('I', 'Math');

SELECT class
from courses
GROUP BY class
HAVING count(*) >= 5;


-- Write a SQL query to get the second highest salary from the Employee table.
drop table if exists Employee;
Create table If Not Exists Employee (Id int, Salary int);
Truncate table Employee;
insert into Employee (Id, Salary) values ('1', '100');
insert into Employee (Id, Salary) values ('2', '200');
insert into Employee (Id, Salary) values ('3', '300');

select * from Employee
order by Salary desc
limit 1
offset 1;