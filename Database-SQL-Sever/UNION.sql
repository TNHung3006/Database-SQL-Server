------------------------------------------------------------
-- //////  UNION  \\\\\\

--SELECT column_name(s) FROM table1
--UNION
--SELECT column_name(s) FROM table2;

--Được sử dung để kết hợp tập kết qua của hai hoặc nhiều câu lệnh.
--Mỗi câu lệnh bên trong phải có cùng số lượng cột
--Các cột cũng phải có kiểu dữ liệu tương tự
--Các cột trong mỗi câu lệnh cũng phải theo cùng thứ tự
--KHÔNG LÁY GIÁ TRỊ LẬP LẠI
------------------------------------------------------------
------------------------------------------------------------
-- //////  UNION ALL  \\\\\\

--SELECT column_name(s) FROM table1
--UNION ALL
--SELECT column_name(s) FROM table2;

--Được sử dụng để kết hợp tập kết qua của hai hoặc nhiều câu lệnh.
--Mỗi câu lệnh bên trong phải có cùng số lượng cột
--Các cột cũng phải có kiểu dữ liệu tương tự
--Các cột trong mỗi câu lệnh cũng phải theo cùng thứ tự
--CHO PHÉP CÁC GIÁ TRỊ BỊ LẶP LẠI
------------------------------------------------------------

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- VD thông thường 
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

--Từ bảng Order Details hãy liệt kê
--các đơn đặt hàng có Unit Price
--nằm trong phạm vi từ 100 đến 200.
--I : ROW = 22
SELECT [OrderID]
FROM [dbo]. [Order Details] od
WHERE od.UnitPrice BETWEEN 100 AND 200;

--Đưa ra các đơn đặt hàng có
--Quantity bằng 10 hoặc 20
--II : ROW = 433
SELECT od.[OrderID]
FROM [dbo]. [Order Details] od
WHERE od.Quantity IN (10, 20);

--Từ bảng Order Details hãy liệt kê các
--đơn đặt hàng có Unit Price nằm trong phạm
--vi từ 100 đến 200 VÀ đơn hàng phải có Quantity
--bằng 10 hoặc 20
--III = I AND II = 7 row 
SELECT od.[OrderID]
FROM [dbo]. [Order Details] od
WHERE	(od. UnitPrice BETWEEN 100 AND 200)
		AND (od.Quantity IN (10, 20));

--Từ bảng Order Details hãy liệt kê các
--đơn đặt hàng có Unit Price nằm trong phạm
--vi từ 100 đến 200 HOẶC đơn hàng phải có Quantity
--bằng 10 hoặc 20
--IV = I OR 2 = 448 row
SELECT od.[OrderID]
FROM [dbo]. [Order Details] od
WHERE	(od. UnitPrice BETWEEN 100 AND 200)
		OR (od.Quantity IN (10, 20));

--Từ bảng Order Details hãy liệt kê các
--đơn đặt hàng có Unit Price nằm trong phạm
--vi từ 100 đến 200 HOAC đơn hàng phải có Quantity
--bằng 10 hoặc 20, DISTINCT
--V = IV + DISTINCT = 360 row
SELECT DISTINCT od.[OrderID]
FROM [dbo]. [Order Details] od
WHERE	(od.UnitPrice BETWEEN 100 AND 200)
		OR (od.Quantity IN (10,20));

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--VD UNION - UNION ALL
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

-- V = I OR 2 = 360 row
SELECT [OrderID]
FROM [dbo]. [Order Details] od
WHERE od.UnitPrice BETWEEN 100 AND 200
UNION
SELECT od.[OrderID]
FROM [dbo]. [Order Details] od
WHERE od.Quantity IN (10, 20);

-- IV = I OR 2 = 448 + 7 = 455 row
SELECT [OrderID]
FROM [dbo]. [Order Details] od
WHERE od.UnitPrice BETWEEN 100 AND 200
UNION ALL -- láy cả giá trị lặp lại
SELECT od.[OrderID]
FROM [dbo]. [Order Details] od
WHERE od.Quantity IN (10, 20);

--Hãy liệt kê toàn bộ các thành phố và quốc gia tồn tại trong 2 tables suppliers và customers
-- sau đây với 2 tình huống sử dụng UNION và UNION ALL
-- C = 21 ROW
SELECT DISTINCT C.[Country]
FROM dbo.Customers AS C
-- S = 16 ROW
SELECT DISTINCT S.[Country]
FROM dbo.Suppliers AS S

-- 1 = 25 ROW
SELECT DISTINCT C.[Country]
FROM dbo.Customers AS C
UNION -- không láy giá trị trùng lập
SELECT DISTINCT S.[Country]
FROM dbo.Suppliers AS S;

-- 2 = 37 row = C + S
SELECT DISTINCT C.[Country]
FROM dbo.Customers AS C
UNION ALL -- lấy tất cả giá trị kể cả trùng lập
SELECT DISTINCT S.[Country]
FROM dbo.Suppliers AS S;

-- HÃY giải thích ý nghĩa câu lệnh
--1: 20 rows
SELECT [City], [Country]
FROM [dbo]. [Customers]
WHERE [Country] LIKE 'U%'
UNION
--2: 1 row
SELECT [City], [Country]
FROM [dbo]. [Suppliers]
WHERE [City] = 'London'
UNION
--3: 122 rows
SELECT [ShipCity], [ShipCountry]
FROM [dbo]. [Orders]
WHERE [ShipCountry]='USA';

--Liệt kê tên Thành Phố và Quốc Gia có:
--1/ khách hàng thuộc các quốc gia có tên bắt đầu bằng chữ U, hoặc
--2/ có các nhà cung cáp ở thành phố London, hoặc 
--3/ đơn hàng được ship đến USA
--Lưu ý: Bỏ các kqua trùng lặp.