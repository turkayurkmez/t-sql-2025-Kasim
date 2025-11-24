
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

