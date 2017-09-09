-- From City table explode the data from start date and end date

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


