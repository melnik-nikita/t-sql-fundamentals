USE TSQLV4;

SELECT
    empid, ordermonth, val,
    SUM(val) OVER(PARTITION BY empid
ORDER BY ordermonth
ROWS BETWEEN UNBOUNDED PRECEDING
AND CURRENT ROW) AS runval
FROM Sales.EmpOrders;

-- Ranking window functions
SELECT
    orderid, custid, val,
    ROW_NUMBER() OVER(ORDER BY val) AS rownum,
    RANK() OVER(ORDER BY val) AS rank,
    DENSE_RANK() OVER(ORDER BY val) AS dense_rank,
    NTILE(100) OVER(ORDER BY val) AS ntile
FROM Sales.OrderValues
ORDER BY val;

SELECT
    orderid, custid, val,
    ROW_NUMBER() OVER(PARTITION BY custid ORDER BY val) AS rownum
FROM Sales.OrderValues
ORDER BY custid, val;

SELECT DISTINCT val,
    ROW_NUMBER() OVER(ORDER BY val) AS rownum
FROM Sales.OrderValues;

SELECT val,
    ROW_NUMBER() OVER(ORDER BY val) AS rownum
FROM Sales.OrderValues
GROUP BY val;

-- offset window functions
SELECT
    custid, orderid, val,
    LAG(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid) AS prevval,
    LEAD(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid) AS nextval
FROM Sales.OrderValues
ORDER BY custid, orderdate, orderid;

SELECT custid, orderid, val,
    FIRST_VALUE(val) OVER(PARTITION BY custid
ORDER BY orderdate, orderid
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS firstval,
    LAST_VALUE(val) OVER(PARTITION BY custid
ORDER BY orderdate, orderid
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS lastval
FROM Sales.OrderValues
ORDER BY custid, orderdate, orderid;
