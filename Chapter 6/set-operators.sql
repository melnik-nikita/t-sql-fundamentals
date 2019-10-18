USE TSQLV4;


-- Union operator
    SELECT country, region, city
    FROM HR.Employees
UNION ALL
    SELECT country, region, city
    FROM Sales.Customers;

-- intersect operator
    SELECT country, region, city
    FROM HR.Employees
INTERSECT
    SELECT country, region, city
    FROM Sales.Customers;

-- except operator
    SELECT country, region, city
    FROM HR.Employees
EXCEPT
    SELECT country, region, city
    FROM Sales.Customers;