-- Question(1) From City table explode the data from start date and end date

select * from city;

-- seattle	10	25
-- san jose	35	55

-- Setup:
CREATE TABLE CITY
(
  CITY VARCHAR(50),
  START_IP INT,
  END_IP INT
);

INSERT INTO CITY VALUES ('seattle',10,25);
INSERT INTO CITY VALUES ('san jose',35,55);

CREATE TABLE T100 (ID INTEGER);

INSERT INTO T100 VALUES (1);
INSERT INTO T100 VALUES (2);
INSERT INTO T100 VALUES (3);
INSERT INTO T100 VALUES (4);
INSERT INTO T100 VALUES (5);
INSERT INTO T100 VALUES (6);
INSERT INTO T100 VALUES (7);
INSERT INTO T100 VALUES (8);
INSERT INTO T100 VALUES (9);
INSERT INTO T100 VALUES (10);
INSERT INTO T100 VALUES (11);
INSERT INTO T100 VALUES (12);
INSERT INTO T100 VALUES (13);
INSERT INTO T100 VALUES (14);
INSERT INTO T100 VALUES (15);
INSERT INTO T100 VALUES (16);
INSERT INTO T100 VALUES (17);
INSERT INTO T100 VALUES (18);
INSERT INTO T100 VALUES (19);
INSERT INTO T100 VALUES (20);
INSERT INTO T100 VALUES (21);
INSERT INTO T100 VALUES (22);
INSERT INTO T100 VALUES (23);
INSERT INTO T100 VALUES (24);
INSERT INTO T100 VALUES (25);
INSERT INTO T100 VALUES (26);
INSERT INTO T100 VALUES (27);
INSERT INTO T100 VALUES (28);
INSERT INTO T100 VALUES (29);
INSERT INTO T100 VALUES (30);
INSERT INTO T100 VALUES (31);
INSERT INTO T100 VALUES (32);
INSERT INTO T100 VALUES (33);
INSERT INTO T100 VALUES (34);
INSERT INTO T100 VALUES (35);
INSERT INTO T100 VALUES (36);
INSERT INTO T100 VALUES (37);
INSERT INTO T100 VALUES (38);
INSERT INTO T100 VALUES (39);
INSERT INTO T100 VALUES (40);
INSERT INTO T100 VALUES (41);
INSERT INTO T100 VALUES (42);
INSERT INTO T100 VALUES (43);
INSERT INTO T100 VALUES (44);
INSERT INTO T100 VALUES (45);
INSERT INTO T100 VALUES (46);
INSERT INTO T100 VALUES (47);
INSERT INTO T100 VALUES (48);
INSERT INTO T100 VALUES (49);
INSERT INTO T100 VALUES (50);
INSERT INTO T100 VALUES (51);
INSERT INTO T100 VALUES (52);
INSERT INTO T100 VALUES (53);
INSERT INTO T100 VALUES (54);
INSERT INTO T100 VALUES (55);
INSERT INTO T100 VALUES (56);
INSERT INTO T100 VALUES (57);
INSERT INTO T100 VALUES (58);
INSERT INTO T100 VALUES (59);
INSERT INTO T100 VALUES (60);
INSERT INTO T100 VALUES (61);
INSERT INTO T100 VALUES (62);
INSERT INTO T100 VALUES (63);
INSERT INTO T100 VALUES (64);
INSERT INTO T100 VALUES (65);
INSERT INTO T100 VALUES (66);
INSERT INTO T100 VALUES (67);
INSERT INTO T100 VALUES (68);
INSERT INTO T100 VALUES (69);
INSERT INTO T100 VALUES (70);
INSERT INTO T100 VALUES (71);
INSERT INTO T100 VALUES (72);
INSERT INTO T100 VALUES (73);
INSERT INTO T100 VALUES (74);
INSERT INTO T100 VALUES (75);
INSERT INTO T100 VALUES (76);
INSERT INTO T100 VALUES (77);
INSERT INTO T100 VALUES (78);
INSERT INTO T100 VALUES (79);
INSERT INTO T100 VALUES (80);
INSERT INTO T100 VALUES (81);
INSERT INTO T100 VALUES (82);
INSERT INTO T100 VALUES (83);
INSERT INTO T100 VALUES (84);
INSERT INTO T100 VALUES (85);
INSERT INTO T100 VALUES (86);
INSERT INTO T100 VALUES (87);
INSERT INTO T100 VALUES (88);
INSERT INTO T100 VALUES (89);
INSERT INTO T100 VALUES (90);
INSERT INTO T100 VALUES (91);
INSERT INTO T100 VALUES (92);
INSERT INTO T100 VALUES (93);
INSERT INTO T100 VALUES (94);
INSERT INTO T100 VALUES (95);
INSERT INTO T100 VALUES (96);
INSERT INTO T100 VALUES (97);
INSERT INTO T100 VALUES (98);
INSERT INTO T100 VALUES (99);
INSERT INTO T100 VALUES (100);

-- Query:
SELECT
city,
explode_data
FROM
(SELECT
   city,
   start_ip,
   end_ip,
   CASE WHEN row_num <= end_ip
     THEN row_num
   ELSE NULL END explode_data
 FROM
   (SELECT
      city,
      start_ip,
      start_ip + sum(1)
      OVER (
        PARTITION BY city
        ROWS UNBOUNDED PRECEDING ) - 1 AS row_num,
      end_ip
    FROM city
      CROSS JOIN t100) X
) Y
WHERE explode_data IS NOT NULL;


-- Output:
-- san jose	35
-- san jose	36
-- san jose	37
-- san jose	38
-- san jose	39
-- san jose	40
-- san jose	41
-- san jose	42
-- san jose	43
-- san jose	44
-- san jose	45
-- san jose	46
-- san jose	47
-- san jose	48
-- san jose	49
-- san jose	50
-- san jose	51
-- san jose	52
-- san jose	53
-- san jose	54
-- san jose	55
-- seattle	10
-- seattle	11
-- seattle	12
-- seattle	13
-- seattle	14
-- seattle	15
-- seattle	16
-- seattle	17
-- seattle	18
-- seattle	19
-- seattle	20
-- seattle	21
-- seattle	22
-- seattle	23
-- seattle	24
-- seattle	25

-- Question(2) Department and Employees
SELECT * FROM dept;
SELECT count(*) FROM emp;

-- Setup:
CREATE TABLE EMP
(EMPNO integer NOT NULL,
 ENAME VARCHAR(10),
 JOB VARCHAR(9),
 MGR integer,
 HIREDATE DATE,
 SAL integer,
 COMM integer,
 DEPTNO integer);

INSERT INTO EMP VALUES  (7369, 'SMITH',  'CLERK',     7902,   '1980-12-17',  800, NULL, 20);
INSERT INTO EMP VALUES  (7499, 'ALLEN',  'SALESMAN',  7698,   '1981-2-20', 1600,  300, 30);
INSERT INTO EMP VALUES  (7521, 'WARD',   'SALESMAN',  7698,   '1981-2-22', 1250,  500, 30);
INSERT INTO EMP VALUES  (7566, 'JONES',  'MANAGER',   7839,   '1981-4-2',  2975, NULL, 20);
INSERT INTO EMP VALUES  (7654, 'MARTIN', 'SALESMAN',  7698,   '1981-9-28', 1250, 1400, 30);
INSERT INTO EMP VALUES  (7698, 'BLAKE',  'MANAGER',   7839,   '1981-5-1',  2850, NULL, 30);
INSERT INTO EMP VALUES  (7782, 'CLARK',  'MANAGER',   7839,   '1981-6-9',  2450, NULL, 10);
INSERT INTO EMP VALUES  (7788, 'SCOTT',  'ANALYST',   7566,   '1982-12-9', 3000, NULL, 20);
INSERT INTO EMP VALUES  (7839, 'KING',   'PRESIDENT', NULL,   '1981-11-17', 5000, NULL, 10);
INSERT INTO EMP VALUES  (7844, 'TURNER', 'SALESMAN',  7698,   '1981-9-8',  1500,    0, 30);
INSERT INTO EMP VALUES  (7876, 'ADAMS',  'CLERK',     7788,   '1983-1-12', 1100, NULL, 20);
INSERT INTO EMP VALUES  (7900, 'JAMES',  'CLERK',     7698,   '1981-12-3',   950, NULL, 30);
INSERT INTO EMP VALUES  (7902, 'FORD',   'ANALYST',   7566,   '1981-12-3',  3000, NULL, 20);
INSERT INTO EMP VALUES  (7934, 'MILLER', 'CLERK',     7782,   '1982-1-23', 1300, NULL, 10);

CREATE TABLE DEPT
(DEPTNO integer,
 DNAME VARCHAR(14),
 LOC VARCHAR(13) );

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

-- Number of employees in each dept
SELECT
  dname,
  count(*)
from dept d
INNER JOIN emp e
  on d.deptno = e.deptno
GROUP BY dname;


-- Employee with not a valid dept
SELECT *
FROM emp e
LEFT JOIN dept d
  ON e.deptno = d.deptno
WHERE d.deptno IS NULL;

-- Top Salary in each dept
SELECT
dname,
max(e.sal)
FROM dept d
INNER JOIN emp e
  on d.deptno = e.deptno
GROUP BY dname;


-- Which employee has top salary in each dept

-- GROUP BY
SELECT
  e.ename,
  e.sal,
  X.dname
FROM emp e
INNER JOIN
(SELECT
d.deptno,
d.dname,
max(e.sal) max_sal
FROM dept d
INNER JOIN emp e
on d.deptno = e.deptno
GROUP BY d.deptno,d.dname) X
  ON e.deptno = X.deptno
and e.sal = X.max_sal;

-- RANK

SELECT
  e.ename,
  d.dname,
  e.sal,
  dense_rank() over(PARTITION BY d.deptno ORDER BY sal DESC) sal_rank
  FROM emp e
INNER JOIN dept d
    on e.deptno = d.deptno;

-- Salary of employee per job or per dept - if max its high, if min its low
select
  X.*,
  case
  when sal = max_sal_dept THEN 'HIGH IN DEPT'
  when sal = min_sal_dept THEN 'LOW IN DEPT'
  ELSE 'AVERAGE IN DEPT' END dept_indicator,
  case
  when sal = max_sal_job THEN 'HIGH IN JOB'
  when sal = min_sal_job THEN 'LOW IN JOB'
  ELSE 'AVERAGE IN JOB' END job_indicator

  from
(SELECT
  deptno,
  ename,
  job,
  sal,
  max(sal) OVER (PARTITION BY deptno) max_sal_dept,
  min(sal) OVER (PARTITION BY deptno) min_sal_dept,
  max(sal) OVER (PARTITION BY job) max_sal_job,
  min(sal) OVER (PARTITION BY job) min_sal_job

from emp) X;