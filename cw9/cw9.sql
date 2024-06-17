USE AdventureWorks2019;

--a) 

BEGIN TRANSACTION;

UPDATE Production.Product 
SET ListPrice = 1.1 * ListPrice 
WHERE ProductID = 680;

COMMIT;


--b)

BEGIN TRANSACTION 

DELETE FROM Production.Product 
WHERE ProductID = 707
ROLLBACK;

SELECT * FROM Production.Product WHERE ProductID=707;


--c)

SET IDENTITY_INSERT Production.Product ON

BEGIN TRANSACTION 

INSERT INTO Production.Product (ProductID, Name, ProductNumber, MakeFlag, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate, ModifiedDate)
VALUES(5, 'ABCHeadphones', 'HO-0001', 0, 200, 150, 0.00, 0.00, 0.00, '2008-04-30 00:00:00.000', '2014-02-08 10:01:36.827');
COMMIT;

SELECT * FROM Production.Product;


--d)

BEGIN TRANSACTION
UPDATE Production.Product
SET StandardCost = StandardCost * 1.1

IF(SELECT SUM(StandardCost) FROM Production.Product) > 50000
BEGIN
	ROLLBACK;
END

ELSE
BEGIN
	COMMIT;
END;

--e)

BEGIN TRANSACTION 

IF EXISTS (SELECT * FROM Production.Product WHERE ProductNumber='CO-0002')
	BEGIN
		PRINT 'Taki ProductNumber juz istnieje'
		ROLLBACK;
	END;
	ELSE
	BEGIN
		INSERT INTO Production.Product (ProductID, Name, ProductNumber, MakeFlag, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate, ModifiedDate)
		VALUES(6, 'XHeadphones', 'HO-0002', 0, 300, 200, 0.00, 0.00, 0.00, '2008-04-30 00:00:00.000', '2014-02-08 10:01:36.827')
		COMMIT;
	END;

SELECT * FROM Production.Product;


--f)

BEGIN TRANSACTION
IF EXISTS (SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
BEGIN
	PRINT 'Transakcja wycofana'
	ROLLBACK;
END

ELSE
BEGIN
	UPDATE Sales.SalesOrderDetail
	SET OrderQty += 10;
	COMMIT;
END;

SELECT * FROM Sales.SalesOrderDetail;


--g)

BEGIN TRANSACTION 

DELETE FROM Production.Product
WHERE StandardCost > (SELECT AVG(StandardCost) FROM Production.Product);
IF @@ROWCOUNT > 10
	BEGIN
		PRINT 'Wiêcej ni¿ 10 produktów do usuniecia';
		ROLLBACK;
	END;
	ELSE
	BEGIN
		PRINT 'Transakcja wykonana poprawnie';
		COMMIT;
	END;
	
SELECT * FROM Production.Product;
