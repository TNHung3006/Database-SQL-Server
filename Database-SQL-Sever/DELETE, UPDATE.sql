------------------------------------------------------------
-- ////// Cú pháp DELETE \\\\\\

--DELETE FROM table_name 
--WHERE condition;

--Nên học trên bảng tạo tạm thời
--Câu lệnh DELETE luôn luôn kèm theo WHERE

--Một số tình huống không thể xóa dữ liệu

--Khóa ngoại (Foreign Key) cấu hình RESTRICT hoặc NO ACTION
--Các ràng buộc duy nhấc noặc ràng buộc kiểm tra (CHECK constraint)
--Quyền truy cập (Permissions)
--Trong trạng thái giao dịch (Transaction)
--Có triggers hoặc quy tắc (triggers or rules)
--Làm thay đổi dữ liệu liên quan đến tính toán (computed data)
--Làm thay đổi dữ liệu liên quan đến ghi lại sự kiện (auditing)

--Phân biệt DELETE FROM với TRUNCATE
--DELETE Xoá toàn bộ dữ liệu nhưng vẫn giữ lại cấu trúc bảng.
--TRUNCATE Xoá toàn bộ dữ liệu trong bảng.
------------------------------------------------------------
--Tạo bảng tạm thời
SELECT *
INTO Customers_1
FROM dbo.Customers;
--DROP TABLE Customers_1;

--VD xoá đi khách hàng có mã là 'ALFKI'
DELETE FROM dbo.Customers_1
WHERE CustomerID LIKE 'ALFKI';

--VD xoá đi toàn bộ khách hàng có quốc gia bắt đàu bằng chữ U
DELETE FROM dbo.Customers_1
WHERE Country LIKE 'U%';

SELECT Country FROM dbo.Customers_1;

--VD xoá sạch 1 bảng
DELETE FROM dbo.Customers_1;
--OR
TRUNCATE TABLE Customers_2;

--BÀI TẬP: %%%%%%%%%%%%%%%%%
--tạo bảng tạm thời trước khi giải

--VD Trong cơ sở dữ liệu NorthWind, Xóa đơn đặt hàng có OrderID là 10248.
--tạo bảng tạm thời
SELECT *
INTO Orders1
FROM dbo.Orders

DELETE FROM dbo.Orders1
WHERE OrderID = 10248
SELECT * FROM dbo.Orders1;

--VD Xóa tất cả sản phẩm từ bảng Products có số lượng tồn kho (UnitsInStock) bằng 0.
--tạo bảng tạm thời
SELECT *
INTO Products1
FROM dbo.Products

DELETE FROM dbo.Products1
WHERE UnitsInStock = 0
SELECT * FROM dbo.Products1;

--VD Xóa tất cả đơn hàng và chi tiết đặt hàng (giá và số lượng) liên quan đến một khách hàng cụ thể dựa
--trên CustomerID
--tạo bảng tạm thời
SELECT *
INTO Order_Detail1
FROM dbo.[Order Details]

DELETE FROM dbo.Order_Detail1
WHERE OrderID IN (
	SELECT OrderID
	FROM dbo.Order1
	WHERE CustomerID LIKE 'HANAR'
	);


------------------------------------------------------------
-- ////// Cú pháp UPDATE \\\\\\

--UPDATE table_name
--SET column1 = value1, column2 = value2,...
--WHERE condition;
------------------------------------------------------------

--Cập nhật thông tin của mot khach hang trong bang Customers.
--THAY ĐỔI địa chỉ của khách hàng có CustomerID là "ALFKI"

SELECT *
INTO Customers1
FROM dbo.Customers

UPDATE dbo.Customers1
SET [Address] = 'NEW Address'
WHERE CustomerID = 'ALFKI'


--VD tăng giá toàn bộ sản phẩm lên 10%
SELECT *
INTO Products1
FROM dbo.Products

UPDATE Products1
SET UnitPrice = UnitPrice * 1.1

-- Cap nhat thong tin cua san phẩm co ProductID
-- là 7 trong bảng Products để thay đổi tên sản
-- phẩm thành "Máy tính xách tay mới"
-- và cập nhật giá bán thành 999.99 đô la.
SELECT *
INTO Products1
FROM dbo.Products

UPDATE Products1
SET ProductName = 'Máy tính xách tay mới', UnitPrice = 999.99
WHERE ProductID = 7;

SELECT *
FROM dbo.Products1
Where ProductID = 7;

--VD Bạn muốn cập nhật thông tin của tất cả các khách hàng trong bảng Customers có thành
--phố (City) là "Paris" để thay đổi quốc gia (Country) của họ thành “PHÁP“
SELECT *
INTO Customers1
FROM dbo.Customers

UPDATE Customers1
SET Country = 'PHÁP'
WHERE City LIKE 'Paris';

--VD Cập nhật thông tin của một sản phẩm cụ thể trong bảng Products dựa trên ProductName.
SELECT *
INTO Products1
FROM dbo.Products

UPDATE Products1
SET UnitPrice = 730
WHERE ProductName LIKE 'Mi 3 mien';

SELECT *
FROM dbo.Products1