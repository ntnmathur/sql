-- The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.
-- Given the Employee table, write a SQL query that finds out managers with at least 5 direct report.
drop table if exists Employee;
Create table If Not Exists Employee (Id int, Name varchar(255), Department varchar(255), ManagerId int);
Truncate table Employee;
insert into Employee (Id, Name, Department, ManagerId) values ('101', 'John', 'A', NULL);
insert into Employee (Id, Name, Department, ManagerId) values ('102', 'Dan', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId) values ('103', 'James', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId) values ('104', 'Amy', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId) values ('105', 'Anne', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId) values ('106', 'Ron', 'B', '101');

select
  m.Name,
  count(*)
  from Employee e
inner join Employee m
    on e.ManagerId = m.id
group by m.Name
having count(*) >= 5;

-- Given a table tree, id is identifier of the tree node and p_id is its parent node's id.
-- Each node in the tree can be one of three types:
-- Leaf: if the node is a leaf node.
-- Root: if the node is the root of the tree.
-- Inner: If the node is neither a leaf node nor a root node.
-- Write a query to print the node id and the type of the node. Sort your output by the node id.

Create table If Not Exists tree (id int, p_id int);
Truncate table tree;
insert into tree (id, p_id) values ('1',NULL);
insert into tree (id, p_id) values ('2', '1');
insert into tree (id, p_id) values ('3', '1');
insert into tree (id, p_id) values ('4', '2');
insert into tree (id, p_id) values ('5', '2');

select
  id,
  CASE WHEN p_id IS NULL THEN 'Root'
    WHEN id in (SELECT p_id from tree) THEN 'INNER'
    ELSE 'Leaf' END Type
from tree; --doesnot work

select
  distinct
  parent.id,
  CASE WHEN parent.p_id IS NULL THEN 'Root'
       WHEN child.id is NOT NULL THEN 'Inner'
      ELSE 'Leaf' END as Type
from tree parent
left join tree child
    on child.p_id = parent.id
order by parent.id; -- table and join orders are different

-- Table point_2d holds the coordinates (x,y) of some unique points (more than two) in a plane.
-- Write a query to find the shortest distance between these points rounded to 2 decimals.
CREATE TABLE If Not Exists point_2d (x INT NOT NULL, y INT NOT NULL);
Truncate table point_2d;
insert into point_2d (x, y) values ('-1', '-1');
insert into point_2d (x, y) values ('0', '0');
insert into point_2d (x, y) values ('-1', '-2');

select
  MIN(SQRT(POWER((p1.x-p2.x),2) + POWER((p1.y-p2.y),2)))
from point_2d p1
INNER JOIN point_2d p2
  on p1.x != p2.x OR p1.y != p2.y;

-- Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.
-- The column id is continuous increment.
-- Mary wants to change seats for the adjacent students.
-- Can you write a SQL query to output the result for Mary?

Create table If Not Exists seat(id int, student varchar(255));
Truncate table seat;
insert into seat (id, student) values ('1', 'Abbot');
insert into seat (id, student) values ('2', 'Doris');
insert into seat (id, student) values ('3', 'Emerson');
insert into seat (id, student) values ('4', 'Green');
insert into seat (id, student) values ('5', 'Jeames');

select
*
  from seat s1
inner join seat s2
    on s1.id = s2.id+1; -- Incomplete - will do later

-- Write a query to print the sum of all total investment values in 2016 (TIV_2016), to a scale of 2 decimal places,
-- for all policy holders who meet the following criteria:
-- Have the same TIV_2015 value as one or more other policyholders.
-- Are not located in the same city as any other policyholder (i.e.: the (latitude, longitude) attribute pairs must be unique).

CREATE TABLE IF NOT EXISTS insurance (PID INTEGER, TIV_2015 NUMERIC(15,2), TIV_2016 NUMERIC(15,2), LAT NUMERIC(5,2), LON NUMERIC(5,2) );
Truncate table insurance;
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('1', '10', '5', '10', '10');
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('2', '20', '20', '20', '20');
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('3', '10', '30', '20', '20');
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('4', '10', '40', '40', '40');

SELECT
  SUM(insurance.TIV_2016) AS TIV_2016
FROM
  insurance
WHERE
  insurance.TIV_2015 IN
  (
    SELECT
      TIV_2015
    FROM
      insurance
    GROUP BY TIV_2015
    HAVING COUNT(*) > 1
  )
  AND CONCAT(LAT, LON) IN
      (
        SELECT
          CONCAT(LAT, LON)
        FROM
          insurance
        GROUP BY LAT , LON
        HAVING COUNT(*) = 1
      );

-- In social network like Facebook or Twitter, people send friend requests and accept others' requests as well.
-- Table request_accepted holds the data of friend acceptance, while requester_id and accepter_id both are the id of a person
-- Write a query to find the the people who has most friends and the most friends number.
Create table If Not Exists request_accepted ( requester_id INT NOT NULL, accepter_id INT NULL, accept_date DATE NULL);
Truncate table request_accepted;
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '2', '2016/06/03');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '3', '2016/06/08');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('2', '3', '2016/06/08');
insert into request_accepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/09');


select a,count(*) from
(SELECT requester_id a from request_accepted
UNION ALL
select accepter_id from request_accepted) X
group by a
order by count(*) desc
limit 1;


-- Write a query to print the respective department name and number of students majoring in each department
-- for all departments in the department table (even ones with no current students).


CREATE TABLE IF NOT EXISTS student (student_id INT,student_name VARCHAR(45), gender VARCHAR(6), dept_id INT);
CREATE TABLE IF NOT EXISTS department (dept_id INT, dept_name VARCHAR(255));
Truncate table department;
insert into department (dept_id, dept_name) values ('1', 'Engineering');
insert into department (dept_id, dept_name) values ('2', 'Science');
insert into department (dept_id, dept_name) values ('3', 'Law');
Truncate table student;
insert into student (student_id, student_name, gender, dept_id) values ('1', 'Jack', 'M', '1');
insert into student (student_id, student_name, gender, dept_id) values ('2', 'Jane', 'F', '1');
insert into student (student_id, student_name, gender, dept_id) values ('3', 'Mark', 'M', '2');

select
  d.dept_name,
  COALESCE(count(s.student_id),0)
from department d
left join student s
  on d.dept_id = s.dept_id
GROUP BY d.dept_name;

-- Write a sql to find the name of the winning candidate.

Create table If Not Exists Candidate (id int, Name varchar(255));
Create table If Not Exists Vote (id int, CandidateId int);
Truncate table Vote;
insert into Vote (id, CandidateId) values ('1', '2');
insert into Vote (id, CandidateId) values ('2', '4');
insert into Vote (id, CandidateId) values ('3', '3');
insert into Vote (id, CandidateId) values ('4', '2');
insert into Vote (id, CandidateId) values ('5', '5');
Truncate table Candidate;
insert into Candidate (id, Name) values ('1', 'A');
insert into Candidate (id, Name) values ('2', 'B');
insert into Candidate (id, Name) values ('3', 'C');
insert into Candidate (id, Name) values ('4', 'D');
insert into Candidate (id, Name) values ('5', 'E');

select
  c.Name
  from vote v
  inner join Candidate c
    on v.CandidateId = c.id
GROUP BY c.Name
order by count(*) DESC
limit 1;


-- Write a SQL query to rank scores. If there is a tie between two scores, both should have the same ranking.
-- Note that after a tie, the next ranking number should be the next consecutive integer value.
-- In other words, there should be no "holes" between ranks.


Create table If Not Exists Scores (Id int, Score DECIMAL(3,2));
Truncate table Scores;
insert into Scores (Id, Score) values ('1', '3.5');
insert into Scores (Id, Score) values ('2', '3.65');
insert into Scores (Id, Score) values ('3', '4.0');
insert into Scores (Id, Score) values ('4', '3.85');
insert into Scores (Id, Score) values ('5', '4.0');
insert into Scores (Id, Score) values ('6', '3.65');

select
  score,
  (Select count(distinct Score) from scores where score > s.Score)+1 rank
from Scores s
order by score desc;

-- Write a SQL query to find all numbers that appear at least three times consecutively.
Create table If Not Exists Logs (Id int, Num int);
Truncate table Logs;
insert into Logs (Id, Num) values ('1', '1');
insert into Logs (Id, Num) values ('2', '1');
insert into Logs (Id, Num) values ('3', '1');
insert into Logs (Id, Num) values ('4', '2');
insert into Logs (Id, Num) values ('5', '1');
insert into Logs (Id, Num) values ('6', '2');
insert into Logs (Id, Num) values ('7', '2');

select l1.num
from Logs l1
inner join logs l2
  on l1.id = l2.id-1
inner join logs l3
  on l2.id = l3.id-1
and l1.num = l2.num
and l2.num = l3.num;


-- In facebook, there is a follow table with two columns: followee, follower.
-- Please write a sql query to get the amount of each follower’s follower if he/she has one.

Create table If Not Exists follow (followee varchar(255), follower varchar(255));
Truncate table follow;
insert into follow (followee, follower) values ('A', 'B');
insert into follow (followee, follower) values ('B', 'C');
insert into follow (followee, follower) values ('B', 'D');
insert into follow (followee, follower) values ('D', 'E');


select
  f1.follower,count(f2.follower)
  from follow f1
inner join follow f2
    on f1.follower = f2.followee
group by f1.follower;

-- Write a SQL query to find employees who have the highest salary in each of the departments.
drop table if exists Employee;
Create table If Not Exists Employee (Id int, Name varchar(255), Salary int, DepartmentId int);
drop table if exists Department;
Create table If Not Exists Department (Id int, Name varchar(255));
Truncate table Employee;
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '70000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Henry', '80000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Sam', '60000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Max', '90000', '1');
Truncate table Department;
insert into Department (Id, Name) values ('1', 'IT');
insert into Department (Id, Name) values ('2', 'Sales');

select
  X.Name,
  e.Name,
  X.max_sal
  from
(select
d.Name,
max(e.Salary) max_sal
from Employee e
inner join Department d
on e.DepartmentId = d.id
GROUP BY d.Name) X
inner join Employee e
on e.Salary = X.max_sal;


-- nth highest salary:

SELECT
  salary
from Employee
order by salary DESC
limit 1
OFFSET 2; -- n-1 in offset

SELECT salary
  from
(select
  salary,
  ROW_NUMBER() OVER (ORDER BY salary DESC) rn
from Employee) X
where rn = 3;