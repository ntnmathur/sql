-- Question(1) From City table explode the data from start date and end date

select * from city;

-- seattle	10	25
-- san jose	35	55


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

