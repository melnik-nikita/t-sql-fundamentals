USE TSQLV4;

-- Ex1
-- Union takes everything from 2 queries and eliminates duplicates
-- Union all doesn't eliminate duplicates
-- They are equivalent when both queries doesn't contain duplicate rows,
-- in this case UNION ALL is preferred to use, as it will be faster

-- Ex2
    SELECT 1 AS n
UNION ALL
    SELECT 2
UNION ALL
    SELECT 3
UNION ALL
    SELECT 4
UNION ALL
    SELECT 5
UNION ALL
    SELECT 6
UNION ALL
    SELECT 7
UNION ALL
    SELECT 8
UNION ALL
    SELECT 9
UNION ALL
    SELECT 10

-- Ex3

    SELECT custid, empid
    FROM Sales.Orders
    WHERE YEAR(orderdate) = 2016 AND MONTH(orderdate) = 1
UNION
    SELECT custid, empid
    FROM Sales.Orders
    WHERE YEAR(orderdate) = 2016 AND MONTH(orderdate) = 1
EXCEPT
    (
        SELECT custid, empid
    FROM Sales.Orders
    WHERE YEAR(orderdate) = 2016 AND MONTH(orderdate) = 2
UNION
    SELECT custid, empid
    FROM Sales.Orders
    WHERE YEAR(orderdate) = 2016 AND MONTH(orderdate) = 2
);

-- Ex4
    (
        SELECT custid, empid
    FROM Sales.Orders
    WHERE YEAR(orderdate) = 2016 AND MONTH(orderdate) = 1
UNION
    SELECT custid, empid
    FROM Sales.Orders
    WHERE YEAR(orderdate) = 2016 AND MONTH(orderdate) = 1
    )
INTERSECT
    (
        SELECT custid, empid
    FROM Sales.Orders
    WHERE YEAR(orderdate) = 2016 AND MONTH(orderdate) = 2
UNION
    SELECT custid, empid
    FROM Sales.Orders
    WHERE YEAR(orderdate) = 2016 AND MONTH(orderdate) = 2
);

-- Ex5
    (
        SELECT custid, empid
    FROM Sales.Orders
    WHERE YEAR(orderdate) = 2016 AND MONTH(orderdate) = 1
UNION
    SELECT custid, empid
    FROM Sales.Orders
    WHERE YEAR(orderdate) = 2016 AND MONTH(orderdate) = 1
    )
INTERSECT
    (
        SELECT custid, empid
    FROM Sales.Orders
    WHERE YEAR(orderdate) = 2016 AND MONTH(orderdate) = 2
UNION
    SELECT custid, empid
    FROM Sales.Orders
    WHERE YEAR(orderdate) = 2016 AND MONTH(orderdate) = 2
)
EXCEPT
    SELECT custid, empid
    FROM Sales.Orders
    WHERE YEAR(orderdate) = 2015;

-- Ex6
SELECT country, region, city
FROM (
            SELECT 1 AS sortcol, country, region, city
        FROM HR.Employees
    UNION ALL
        SELECT 2, country, region, city
        FROM Production.Suppliers
) AS R1
ORDER BY sortcol, country, region, city;