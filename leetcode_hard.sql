-- Row to Column:
drop table if exists student;
Create table If Not Exists student (name varchar(50), continent varchar(7));
Truncate table student;
insert into student (name, continent) values ('Jane', 'America');
insert into student (name, continent) values ('Pascal', 'Europe');
insert into student (name, continent) values ('Xi', 'Asia');
insert into student (name, continent) values ('Jack', 'America');

Select * from
(select
  CASE WHEN continent = 'America' THEN name ELSE NULL END America,
  CASE WHEN continent = 'Europe' THEN name ELSE NULL END Europe,
  CASE WHEN continent = 'Asia' THEN name ELSE NULL END Asia
from student) X;

select A.America,
  B.Asia,
  C.Europe
from
(select ROW_NUMBER() OVER() as id, name as America
from student
where continent = 'America') A
left join
(select ROW_NUMBER() OVER() id, name as Asia
from student
where continent = 'Asia') B
  on A.id = B.id
left join
( SELECT ROW_NUMBER() OVER() id, NAME AS Europe
FROM student
WHERE continent = 'Europe'
) C
on B.id = C.id;

-- Find Median
Create table If Not Exists Numbers (Number int, Frequency int);
Truncate table Numbers;
insert into Numbers (Number, Frequency) values ('0', '7');
insert into Numbers (Number, Frequency) values ('1', '1');
insert into Numbers (Number, Frequency) values ('2', '3');
insert into Numbers (Number, Frequency) values ('3', '1');

select * from Numbers; -- Incomplete

-- Median Salary of each Company
drop table if exists Employee;
Create table If Not Exists Employee (Id int, Company varchar(255), Salary int);
Truncate table Employee;
insert into Employee (Id, Company, Salary) values ('1', 'A', '2341');
insert into Employee (Id, Company, Salary) values ('2', 'A', '341');
insert into Employee (Id, Company, Salary) values ('3', 'A', '15');
insert into Employee (Id, Company, Salary) values ('4', 'A', '15314');
insert into Employee (Id, Company, Salary) values ('5', 'A', '451');
insert into Employee (Id, Company, Salary) values ('6', 'A', '513');
insert into Employee (Id, Company, Salary) values ('7', 'B', '15');
insert into Employee (Id, Company, Salary) values ('8', 'B', '13');
insert into Employee (Id, Company, Salary) values ('9', 'B', '1154');
insert into Employee (Id, Company, Salary) values ('10', 'B', '1345');
insert into Employee (Id, Company, Salary) values ('11', 'B', '1221');
insert into Employee (Id, Company, Salary) values ('12', 'B', '234');
insert into Employee (Id, Company, Salary) values ('13', 'C', '2345');
insert into Employee (Id, Company, Salary) values ('14', 'C', '2645');
insert into Employee (Id, Company, Salary) values ('15', 'C', '2645');
insert into Employee (Id, Company, Salary) values ('16', 'C', '2652');
insert into Employee (Id, Company, Salary) values ('17', 'C', '65');


select
avg(Salary)
  from Employee;


-- Write a SQL query to find employees who earn the top three salaries in each of the department.
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
*
  from Employee e1
    JOIN
    Department d ON e1.DepartmentId = d.Id
  WHERE

  (SELECT count(DISTINCT e2.Salary)
    from Employee e2
    where e2.Salary > e1.Salary
    and e1.DepartmentId = e2.DepartmentId
  ) < 3;