USE TSQLV4;

SELECT custid, orderid, orderdate, empid
FROM Sales.Orders AS O1
WHERE orderid = 
    (
        SELECT MAX(orderid)
FROM Sales.Orders AS O2
WHERE O2.custid = O1.custid
    );

SELECT orderid, custid, val, CAST(100 * val / (
    SELECT SUM(O2.val)
    FROM Sales.OrderValues AS O2
    WHERE O2.custid = O1.custid
) AS NUMERIC(5,2)) AS pct
FROM Sales.OrderValues AS O1
ORDER BY custid, orderid;