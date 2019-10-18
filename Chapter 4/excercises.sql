USE TSQLV4;

-- Ex1
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = (SELECT MAX(O1.orderdate)
FROM Sales.Orders AS O1)

-- Ex2
SELECT custid, orderid, orderdate, empid
FROM Sales.Orders
WHERE custid = (SELECT TOP 1 WITH TIES
    O1.custid
FROM Sales.Orders AS O1
GROUP BY O1.custid
ORDER BY COUNT(*) DESC );

-- Ex3
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE empid NOT IN (
SELECT O1.empid
FROM Sales.Orders AS O1
WHERE O1.orderdate >= '20160501');

-- Ex4
SELECT DISTINCT country
FROM Sales.Customers
WHERE country NOT IN (
    SELECT E1.country
FROM HR.Employees AS E1
)
ORDER BY country;

-- Ex5
-- Don't forget to ALWAYS make aliases when making a
-- subquery for the same table
SELECT custid, orderid, orderdate, empid
FROM Sales.Orders AS O
WHERE orderdate = (SELECT
    MAX(O1.orderdate)
FROM
    Sales.Orders AS O1
WHERE O1.custid = O.custid)
ORDER BY custid;


-- Ex6
SELECT C1.custid, C1.companyname
FROM Sales.Customers AS C1
WHERE C1.custid IN (
    SELECT O2.custid
    FROM Sales.Orders AS O2
    WHERE YEAR(O2.orderdate) = 2015
) AND C1.custid NOT IN (
    SELECT O1.custid
    FROM Sales.Orders AS O1
    WHERE YEAR(O1.orderdate) = 2016
)
ORDER BY C1.custid;

-- Ex7
SELECT custid, companyname
FROM Sales.Customers AS C1
WHERE C1.custid IN (SELECT O1.custid
FROM Sales.Orders AS O1
WHERE O1.orderid IN (SELECT OD1.orderid
FROM Sales.OrderDetails AS OD1
WHERE OD1.productid = 12));

-- Ex8
SELECT CO1.custid, CO1.ordermonth, CO1.qty,
    (SELECT SUM(CO2.qty)
    FROM Sales.CustOrders AS CO2
    WHERE CO2.custid = CO1.custid AND CO2.ordermonth <= CO1.ordermonth) AS runqty
FROM Sales.CustOrders AS CO1
ORDER BY CO1.custid, CO1.ordermonth;

-- Ex9
-- Difference between IN and EXISTS is in handling NULLS
-- EXISTS can result only in TRUE or FALSE
-- IN can be TRUE, FALSE, NULL, UNKNOWN
-- As a result IN will return nothing if the 
-- searched set contains nulls

-- Ex10
SELECT O1.custid, O1.orderdate, O1.orderid,
    DATEDIFF(day, (SELECT TOP (1)
        O2.orderdate
    FROM Sales.Orders AS O2
    WHERE O2.orderdate < O1.orderdate
        AND O2.custid = O1.custid
    ORDER BY O2.orderdate DESC)  ,O1.orderdate)  AS diff
FROM Sales.Orders AS O1
ORDER BY O1.custid, O1.orderdate;
