USE TSQLV4;

INSERT INTO Production.Products
    (productname, supplierid, categoryid, unitprice, discontinued)
VALUES
    ('Product ABCDE', 1, 1, 20.00, 0);

DELETE FROM Production.Products
WHERE productid > 77;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;