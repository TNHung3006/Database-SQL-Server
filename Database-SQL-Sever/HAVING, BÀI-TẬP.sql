----------------------------------------
--  ////// HAVING \\\\\\

--SELECT column_name(s)
--FROM table_name
--WHERE condition
--GROUP BY column_name(s)
--HAVING condition
--ORDER BY "column_name(s);

--Lọc dữ liệu sau GROUP BY
----------------------------------------

--VD Hãy cho biết những khách hàng nào đã đặt nhiều hơn 20 đơn hàng, 
--sắp xếp theo thứ tự tổng số đơn hàng giảm dần.
SELECT [CustomerID], COUNT(OrderID) as "Quantity Order"
FROM dbo.Orders
GROUP BY [CustomerID]
HAVING COUNT([OrderID]) > 20
ORDER BY COUNT(OrderID) DESC;

--VD Hãy lọc ra những nhà cung cấp(supplier) sản phẩm có tổng số lượng hàng trong kho(UnitsInStock) lớn hơn 30, 
--và có trung bình đơn gia (UnitPrice) có giá trị dưới 50, trong bảng products.
SELECT SupplierID, SUM(UnitsInStock) AS "Total UnitsInStock", AVG(UnitPrice) AS "AVG Price"
FROM dbo.Products
GROUP BY SupplierID
HAVING SUM(UnitsInStock) > 30 AND AVG(UnitPrice) < 50;

--VD Hãy cho biết tổng số tiền vận chuyển(Freight) của từng tháng, ngày vận chuyển(ShippedDate) trong nửa năm sau của năm 1996,
--sắp xếp ngày vận chuyển(ShippedDate) theo tháng tăng dần, tổng tiền vận chuyển phải lớn hơn 1000$ trong bảng order.
SELECT MONTH([ShippedDate]) AS "MONTH", YEAR([ShippedDate]) AS "YEAR", SUM([Freight]) AS "Total Freight"
FROM dbo.Orders
WHERE [ShippedDate] BETWEEN '1996-07-01' AND '1996-12-31'
GROUP BY MONTH([ShippedDate]), YEAR([ShippedDate])
HAVING SUM([Freight]) > 1000
ORDER BY MONTH([ShippedDate]) ASC;

SELECT [CustomerID], MONTH([ShippedDate]) AS "MONTH", SUM([Freight]) AS "Total Freight", YEAR([ShippedDate]) AS "YEAR"
FROM dbo.Orders
--WHERE [ShippedDate] BETWEEN '1996-07-01' AND '1996-12-31'
GROUP BY [CustomerID], MONTH([ShippedDate]), YEAR([ShippedDate])
HAVING SUM([Freight]) > 1000
ORDER BY MONTH([ShippedDate]) ASC;

--VD Hãy lọc ra những thành phố có số lượng đơn hàng >16 và sắp xếp theo tổng số lượng giảm dần.
SELECT [ShipCity], COUNT([OrderID]) AS "Quantity Orders"
FROM dbo.Orders
GROUP BY [ShipCity]
HAVING COUNT([OrderID]) > 16
ORDER BY COUNT([OrderID]) DESC;

--BT: Lấy ra ID sản phẩm trong bảng order datails, sắp xếp tăng dần theo giá tiền
--ĐK1: hãy tính tổng giá tiền của từng sản phẩm trong đó có cả mã giảm giá
--ĐK2: chỉ xét những điều kiện có orderID lấy 2 chữ số đầu chữ số t3 thì từ (2-4) sau đó lấy hết
--ĐK3: tổng giá tiền chỉ được trong khoản từ 50 - 500
SELECT [ProductID], OrderID, SUM([UnitPrice]) AS "Total Price"
FROM dbo.[Order Details]
WHERE OrderID LIKE '__[2-4]%'
GROUP BY [ProductID], OrderID
HAVING SUM([UnitPrice]) BETWEEN 50 AND 500
ORDER BY SUM([UnitPrice]) ASC;

------------------------------------------------
-- @@@@@@@@@@@@@@@  BÀI  TẬP  @@@@@@@@@@@@@@@ --
------------------------------------------------

--VD Hãy cho biết những khách hàng nào đã đặt nhiều hơn 20 đơn hàng, 
--sắp xếp theo thứ tự tổng số đơn hàng giảm dần.
SELECT [CustomerID], COUNT([OrderID]) AS "Total"
FROM dbo.Orders
GROUP BY [CustomerID]
HAVING COUNT([OrderID]) > 20
ORDER BY COUNT([OrderID]) DESC;

--VD Hay lọc ra các nhân viên (EmployeelD) có tổng số đơn hàng lớn hơn hoặc
-- bằng 100, sắp xếp theo tổng số đơn hàng giảm dần.
SELECT [EmployeeID], SUM([OrderID]) AS "Total"
FROM dbo.Orders
GROUP BY [EmployeeID]
HAVING SUM([OrderID]) >= 100
ORDER BY SUM([OrderID]) DESC;

--VD Hãy cho biết những thể loại nào (CategoryID) có số sản phẩm (products) khác nhau lớn hớn 11.
SELECT DISTINCT [CategoryID], COUNT([ProductID]) AS "Total"
FROM dbo.Products
GROUP BY [CategoryID]
HAVING COUNT([ProductID]) > 11;

--VD Hãy cho biết nhung thể loại nào (CategoryID) có số tổng số lượng sản phẩm 
--trong kho (UnitsInStock) lớn hơn 350, trong bảng products.
SELECT [CategoryID], SUM([UnitsInStock]) AS "Total"
FROM dbo.Products
GROUP BY [CategoryID]
HAVING SUM([UnitsInStock]) > 350;

--VD Hãy cho biết những quốc gia nào có nhieu hơn 7 khách hàng.
SELECT [Country], COUNT([CustomerID]) AS "total"
FROM dbo.Customers
GROUP BY [Country]
HAVING COUNT([CustomerID]) > 7;

--VD Hãy cho biết những ngày nào có nhiều hơn 5 đơn hàng được giao, 
--sắp xếp tăng dần theo ngày giao hàng.
SELECT [OrderDate], count([OrderID])
FROM dbo.Orders
GROUP BY [OrderDate]
HAVING count([OrderID]) > 5
ORDER BY [OrderDate] ASC;

--VD  Hãy cho biết những quốc gia bắt đầu bằng chữ 'A' hoặc 'G'
-- và có số lượng đơn hàng lớn hơn 29.
SELECT [ShipCountry], COUNT([OrderID]) as "total"
FROM dbo.Orders
WHERE  [ShipCountry] LIKE '[A,G]%'
GROUP BY [ShipCountry]
HAVING  COUNT([OrderID]) > 29;

--VD Hãy cho biết những thành phố nào có số lượng đơn hàng được giao là khác 1
--và 2, ngày đặt hàng từ ngày '1997-04-01' đến ngày '1997-08-31'
--Và sắp xếp thành phố từ A-Z
SELECT [ShipCity], COUNT([OrderID]) AS "TOTAL"
FROM dbo.Orders
WHERE [OrderDate] BETWEEN '1997-04-01' AND '1997-08-31'
GROUP BY [ShipCity]
HAVING COUNT([OrderID]) <> 1 AND  COUNT([OrderID]) <> 2
ORDER BY [ShipCity] ASC;

