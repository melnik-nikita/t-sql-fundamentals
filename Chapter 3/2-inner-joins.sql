use TSQLV4;

-- Inner Join example
SELECT e.empid, e.firstname, e.lastname, O.orderid
FROM HR.Employees AS E
    INNER JOIN Sales.Orders AS O
    ON E.empid = O.empid;