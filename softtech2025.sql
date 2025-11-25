
-- DML: Data Manuplation Language

-- INSERT into [TabloAdi] ([Kolon1], [Kolon2], [Kolon3]) 
--                 values (Deger1, Deger2, Deger3)

INSERT into Shippers (CompanyName, Phone)
           values    ('Yurtiçi Kargo', '0222 222 22 22')

-- UPDATE [TabloAdi] SET [Kolon1]=[Deger1], [Kolon2]=[Deger2], [Kolon3]=[Deger3]
-- WHERE [Kosul]

UPDATE Shippers SET Phone = '0555 555 12 34' WHERE ShipperID=4

SELECT CompanyName, Phone FROM Shippers

SELECT CompanyName, Country, Phone, Fax
FROM Customers WHERE Country = 'Germany' AND Fax is not  null

SELECT 
 CompanyName, Address + ' ' + City + ' ' + Country as 'AddressInfo'
FROM Customers
ORDER BY AddressInfo

--1. Ne yapmak istediðine karar ver (INSERT, UPDATE, DELETE, SELECT)
--2. Hangi Tablo(lar) ile çalýþmak istediðine karar ver.
--3. Hangi kolonlarý görmek istediðine karar ver
--4. Varsa koþul ekle.
--5. Gerekiyorsa Grupla...
--6. Sýrala.

SELECT 
   ProductId,ProductName, UnitPrice, Discontinued
FROM Products
WHERE Discontinued != 'True' AND UnitPrice > 50 

SELECT 
ProductName, UnitPrice
FROM Products 
WHERE ProductName LIKE 'C%'

SELECT 
ProductName, UnitPrice
FROM Products 
WHERE ProductName NOT LIKE 'C%'

SELECT 
ProductName, UnitPrice
FROM Products 
WHERE ProductName LIKE '_A%'

-- Adýnda "RESTAURANT" olan müþterilerim:

SELECT CompanyName, Country
FROM Customers WHERE CompanyName LIKE '%RESTAURANT%'

-- Ülkesi; UK, Germany veya Italy olan müþterilerim:

SELECT
   CompanyName, Country
FROM Customers
WHERE Country = 'Germany' OR Country='UK' OR Country='Italy' OR Country='Spain'
ORDER BY Country


SELECT
   CompanyName, Country
FROM Customers
WHERE Country IN ('Spain','UK','Italy')
ORDER BY Country

SELECT
   CompanyName, Country
FROM Customers
WHERE Country NOT IN ('Spain','UK','Italy')
ORDER BY Country

-- Ürünleri fiyata göre pahalýdan ucuza sýrala
SELECT
  ProductName, UnitPrice, UnitsInStock
FROM Products
ORDER BY UnitPrice DESC, UnitsInStock ASC  

--Aggregate Functions

SELECT Count(*) FROM Products
SELECT MAX(UnitPrice) FROM Products
SELECT MIN(UnitPrice) FROM Products
SELECT AVG(UnitPrice) FROM Products

SELECT SUM(UnitPrice * Quantity) FROM [Order Details]

SELECT SUM(UnitPrice * Quantity * (1-Discount)) FROM [Order Details]

SELECT SUM(UnitPrice * Quantity) - SUM(UnitPrice * Quantity * (1-Discount))  FROM [Order Details]

SELECT GETDATE() --Scalar functions

SELECT Upper('test')

SELECT LOWER(CompanyName) FROM Customers

SELECT 
   FirstName, LastName, YEAR(GETDATE()) - YEAR(BirthDate) as 'Yas'
FROM Employees
ORDER BY Yas

--Hangi ülkede kaç müþterim var?
--Ülke Adý ............. Müþteri Sayýsý
-- Brazil                  9
-- UK                      13
-- Türkiye                 3

SELECT 
  COUNT(CustomerID)
FROM Customers WHERE Country ='Brazil'

SELECT
  Country, COUNT(*) 'Müþteri Sayýsý'
FROM Customers
GROUP BY Country

SELECT 
  OrderID, SUM(UnitPrice * Quantity) TotalPrice
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(UnitPrice * Quantity) >= 10000 --Filtreyi, kolonda bulunan deðer üzerinden DEÐÝL de Aggregate function'un sonucu üzerinden uygulamak istiyorsanýz having kullanmalýsýnýz.
ORDER BY TotalPrice

SELECT CustomerID FROM Customers

--Ürünler ve kategori adlarý

SELECT 
  Products.ProductName, Products.UnitPrice, Categories.CategoryName
FROM Products INNER JOIN Categories
     ON Products.CategoryID = Categories.CategoryID

--Kategorisi olmayan ürün var mý?
SELECT ProductName,CategoryID FROM Products 
WHERE CategoryID is Null

/*
SELECT 
  Products.ProductName, Products.UnitPrice, Categories.CategoryName
FROM Products INNER JOIN Categories
     ON Products.CategoryID = Categories.CategoryID
WHERE ProductName IN ('Domates', 'Gül reçeli')
*/

SELECT 
  Products.ProductName, Products.UnitPrice, Categories.CategoryName
FROM Products INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID

SELECT 
  ProductName, 
  UnitPrice, 
  CategoryName,
  CompanyName
FROM Categories as c
JOIN Products as p
ON p.CategoryID = c.CategoryID
JOIN Suppliers as s
ON p.SupplierID = s.SupplierID


SELECT TOP 10
  CompanyName, Country, SUM(Quantity * od.UnitPrice) as 'Total Payment'
FROM Customers c
JOIN Orders o
ON o.CustomerId = c.CustomerId
JOIN [Order Details] od
ON o.OrderID = od.OrderID
JOIN Products p
ON od.ProductID = p.ProductID
GROUP BY  CompanyName, Country
ORDER BY 'Total Payment' DESC 

--Olabilecek en detaylý sorgu

SELECT 
   o.OrderID,
   c.CompanyName 'Müþteri',
   e.FirstName + ' ' + e.LastName 'Çalýþan',
   o.OrderDate,
   s.CompanyName 'Kargo',
   o.ShippedDate,
   p.ProductName,
   cat.CategoryName,
   sup.CompanyName 'Tedarikçi',
   od.Quantity * od.UnitPrice 'Ödenen Tutar'
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Employees e
ON e.EmployeeID = o.EmployeeID
JOIN Shippers s 
ON o.ShipVia = s.ShipperID
JOIN [Order Details] od
ON od.OrderID = o.OrderID
JOIN Products p
ON od.ProductID = p.ProductID
JOIN Categories cat
ON p.CategoryID = cat.CategoryID
JOIN Suppliers sup
ON p.SupplierID = sup.SupplierID
ORDER BY 'Ödenen Tutar' DESC

SELECT COUNT(*) FROM Customers
SELECT COUNT (DISTINCT CustomerID) FROM Orders

SELECT
 CompanyName,OrderID
FROM Orders RIGHT JOIN Customers
ON Customers.CustomerID = Orders.CustomerId
WHERE OrderID is NULL

SELECT CategoryName,ProductName
FROM Categories FULL OUTER JOIN Products
ON Categories.CategoryID = Products.CategoryID
WHERE ProductName is NULL OR CategoryName is NULL

SELECT EmployeeID, FirstName,LastName, ReportsTo
FROM Employees 

/*
   Çalýþan Adý            Yönetici
   --------------------------------
   Nancy Davolio              Andrew Fuller
   Andrew Fuller              NULL
*/

SELECT 
     Calisan.FirstName + ' ' + Calisan.LastName 'Çalýþan',
	 Yonetici.FirstName + ' ' + Yonetici.LastName 'Yönetici'

FROM Employees Calisan LEFT JOIN Employees Yonetici
ON Calisan.ReportsTo = Yonetici.EmployeeId

SELECT * FROM Orders Cross Join [Order Details]

SELECT COUNT(*) FROM [Order Details]
SELECT COUNT(*) FROM [Orders]

SET STATISTICS TIME ON
SET STATISTICS IO ON
SELECT
 Customers.CustomerID, CompanyName, ContactName, ContactTitle,Address,City, Region,PostalCode,Country,Phone,Fax
FROM Orders RIGHT JOIN Customers
ON Customers.CustomerID = Orders.CustomerId
WHERE OrderID is NULL

--Müþteriler tablosunda bulunan
--Sipariþler tablosunda bulunmayan Müþteriler....
SET STATISTICS TIME Off
SET STATISTICS IO Off
SELECT 
  *
FROM Customers 
WHERE CustomerID  NOT IN  
(Select DISTINCT CustomerID FROM Orders)

--Hangi kategoride toplam kaç ürün var?
SET STATISTICS TIME ON
SET STATISTICS IO ON
SELECT 
 CategoryName, (
 SELECT Count(*) FROM Products WHERE CategoryID =c.CategoryID
 )
FROM Categories as c

SELECT 
  CategoryName , COUNT(ProductID) as Adet
FROM Categories LEFT JOIN Products
ON Categories.CategoryID = Products.CategoryID
GROUP BY CategoryName

SET STATISTICS TIME Off
SET STATISTICS IO Off

SELECT *
FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products)


-- Spesifik bir ürünü alanlar, o ürünün dýþýnda hangi ürünü tercih ettiler.
-- Ürün Adý    Adet
-- :.....        50
CREATE PROC bunuAlanlar
  @productId int
as
SELECT TOP 10 ProductName, Sum(Quantity) 'Adet' FROM
Products JOIN [Order Details] od
ON Products.ProductID = od.ProductID
WHERE od.OrderID IN
	(SELECT OrderId
	FROM [Order Details] WHERE ProductId=@productId)
AND od.ProductID != @productId
GROUP BY ProductName
ORDER BY Adet DESC


bunuAlanlar 19

-- Hangi müþteri, hangi ürünü satýn almayý tercih ediyor (en çok satýn aldýðý ürün)
-- Müþteri Adý             Tercih ettiði Ürün
-- Alfred Futterkiste       Chai
-- Around the Horn          Baþka bir ürün
--                        

SELECT CompanyName, 
(
   SELECT kaynak.ProductName FROM 
   (
      SELECT TOP 1 p.ProductID, p.ProductName, SUM(Quantity) AS 'Total' FROM [Order Details] od
	         JOIN Orders o On od.OrderID = o.OrderID
			 JOIN Products p ON p.ProductID = od.ProductID
	  WHERE o.CustomerID = c.CustomerId
	  GROUP BY p.ProductName, p.ProductID
	  ORDER BY Total DESC
	 
   ) as kaynak
 

) as  'Tercih edilen ürün', 
(
   SELECT TOP 1 SUM(Quantity) AS 'Total' FROM [Order Details] od
	         JOIN Orders o On od.OrderID = o.OrderID
			 JOIN Products p ON p.ProductID = od.ProductID
	  WHERE o.CustomerID = c.CustomerId
	  GROUP BY p.ProductName
	  ORDER BY Total DESC

)as Adet FROM Customers AS c







SELECT 
  c.CompanyName, p.ProductName, SUM(od.Quantity) 'adet'
FROM Customers c JOIN Orders o
ON c.CustomerID = o.CustomerID
JOIN [Order Details] od 
ON o.OrderID = od.OrderID
JOIN Products p 
ON p.ProductID = od.ProductID
GROUP BY c.CompanyName, p.ProductName
ORDER BY c.CompanyName, adet DESC
