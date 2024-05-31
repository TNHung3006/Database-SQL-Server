----------------------------------------
--  ////// GROUP BY \\\\\\

--SELECT column_name(s)
--FROM table_name
--WHERE condition
--GROUP BY column_name(s) ////////////
--ORDER BY column_name(s);

--Dùng để nhóm các dòng dữ liệu có cùng giá trị.
--Thường được dung với các hàm: COUNT(), MAX(), MIN(), SUM(), AVG()
----------------------------------------

--VD Hãy cho biết mỗi khách hàng đã đặt bao nhiêu đơn hàng(orders).
SELECT [CustomerID], COUNT([OrderID]) AS "TOTAL"
FROM dbo.Orders
GROUP BY [CustomerID];

--VD hãy tính giá trị đơn giá trung bình theo mỗi nhà cung cấp sản phẩm(products)
SELECT [SupplierID], AVG([UnitPrice])
FROM dbo.Products
GROUP BY [SupplierID];

--VD hãy cho biết mỗi thể loại(CateGory) có tổng số bao nhiêu sản phẩm trong kho (UnitsInStock)?
SELECT [CategoryID], SUM(UnitsInStock) as "total"
FROM dbo.Products
GROUP BY [CategoryID];

--VD hãy cho biết giá vận chuyển thấp nhất và lớn nhất của các đơn hàng theo từng thành phố và quốc gia khác nhau.
--SẮP xếp Quốc gia và thành phố từ a - z
SELECT	[ShipCountry], [ShipCity], 
		MIN(Freight) AS "MIN Freight", 
		Max(Freight) AS "MAX Freight"
FROM dbo.Orders
GROUP BY [ShipCountry], [ShipCity]
ORDER BY ShipCountry ASC, ShipCity ASC;

--VD hãy thống kê số lượng nhân viên theo từng quốc gia khác nhau.
SELECT Country, COUNT([EmployeeID]) AS "Số lượng nhân viên"
FROM dbo.Employees
GROUP BY Country;

--Challenges1: Write an SQL statement 
--Thống kê số khách hàng ở từng quốc gia, từng thành phố
--Tìm các khách hàng có CompanyName có chữ a trong tên
--Sắp xếp theo chiều A-Z Country
SELECT [Country], [City], COUNT(CustomerID) AS "số lượng khách hàng"
FROM dbo.Customers
WHERE CompanyName LIKE '%A%'
GROUP BY [Country], [City]
ORDER BY [Country] ASC;

--Challenges2: Write an SQL Statment
-- Tính tổng số tiền vận chuyển đơn hàng ở từng thành phố, quốc gia
-- Chỉ lấy những ShipName có có chữ 'b' 
--Sắp xếp theo chiều từ A-Z của ShipNAme
SELECT	ShipName, [ShipCountry], [ShipCity], 
		SUM(Freight) AS "Total"
FROM dbo.Orders
WHERE ShipName LIKE '%b%'
GROUP BY ShipName, [ShipCountry], [ShipCity]
ORDER BY ShipName ASC;

----------------------------------------
--  ////// DAY(date | datetime) \\\\\\

--SELECT DAY('2023-08-25') ...
-- ==> 25

--Lấy ra dữ liệu NGÀY và thời gian
----------------------------------------
----------------------------------------
--  ////// MONTH(date | datetime) \\\\\\

--SELECT MONTH('2023-08-25') ...
-- ==> 8

--Lấy ra dữ liệu THÁNG và thời gian
----------------------------------------
----------------------------------------
--  ////// YEAR(date | datetime) \\\\\\

--SELECT YEAR('2023-08-25 15:23:39') ...
-- ==> 2023

--Lấy ra dữ liệu NĂM và thời gian
----------------------------------------

--VD tính số lượng đơn đặt hàng trong năm 1997 của từng khách hàng(CusTomers)?
SELECT	[CustomerID], 
		COUNT([OrderID]) AS "Total", 
		YEAR(OrderDate) AS "Year"
FROM dbo.Orders
WHERE YEAR(OrderDate)=1997
GROUP BY [CustomerID], YEAR(OrderDate);

--VD hãy lọc ra các đơn hàng được đặt hàng vào tháng 5 và năm 1997.
SELECT	[OrderID], 
		MONTH([OrderDate]) AS "Month", 
		YEAR([OrderDate]) AS "Year"
FROM dbo.Orders
WHERE MONTH([OrderDate]) = 5 AND YEAR([OrderDate]) = 1997;

SELECT	*
FROM dbo.Orders
WHERE MONTH([OrderDate]) = 5 AND YEAR([OrderDate]) = 1997;

--VD lấy danh sách các đơn hàng được đặt vào ngày 4 tháng 9 năm 1996
SELECT *
FROM dbo.Orders
WHERE DAY([OrderDate]) = 4 AND MONTH([OrderDate]) = 9 AND YEAR([OrderDate]) = 1996;

SELECT *
FROM dbo.Orders
WHERE [OrderDate] = '1996-09-04';

--VD Lấy danh sách khách hàng đặt hàng trong năm 1998
--và số đơn hàng mỗi tháng, sắp xếp tháng tăng dần.
SELECT	[CustomerID], 
		MONTH([OrderDate]) AS "MONTH", 
		YEAR([OrderDate]) AS "YEAR", 
		COUNT(*) AS "Total order"
FROM dbo.Orders
WHERE YEAR([OrderDate]) = 1998
GROUP BY [CustomerID], MONTH([OrderDate]), YEAR([OrderDate])
ORDER BY MONTH([OrderDate]) ASC;

--VD hãy lọc các đơn hàng đã được giao vào tháng 5, và sắp xếp tăng dần theo năm.
SELECT [OrderID], MONTH([OrderDate]), YEAR([OrderDate])
FROM dbo.Orders
WHERE MONTH([OrderDate]) = 5
ORDER BY YEAR([OrderDate]) ASC;

-- Lấy danh sách khách hàng không ở USA, và số đơn đặt hàng trong năm 1997, sắp xếp tăng dần theo tháng
SELECT	[CustomerID], ShipCountry, 
		MONTH([OrderDate]) AS "MONTH", 
		YEAR([OrderDate]) AS "YEAR", 
		COUNT(ShipCountry) AS "số đơn hàng"
FROM dbo.Orders
WHERE ShipCountry NOT IN ('USA') AND YEAR([OrderDate]) = 1997
GROUP BY [CustomerID], YEAR([OrderDate]), MONTH([OrderDate]),  ShipCountry
ORDER BY MONTH([OrderDate]);

SELECT [CustomerID], ShipCountry, MONTH([OrderDate]) AS "MONTH", YEAR([OrderDate]) AS "YEAR", COUNT(ShipCountry) AS "Total"
FROM dbo.Orders
WHERE ShipCountry <> 'USA' AND YEAR([OrderDate]) = 1997
GROUP BY [CustomerID], YEAR([OrderDate]), MONTH([OrderDate]),  ShipCountry
ORDER BY MONTH([OrderDate]);


