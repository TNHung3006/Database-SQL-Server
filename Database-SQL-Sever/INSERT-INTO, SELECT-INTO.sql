------------------------------------------------------------
-- ////// Cú pháp INSERT INTO \\\\\\

--INSERT INTO Table_name (column_name1, column_name2, column_name3,...)
--VALUES ();

--Thêm dữ liệu vào bảng 
------------------------------------------------------------
-- Thêm một khách hàng mới
INSERT INTO [dbo].[Customers]([CustomerID], [CompanyName], [ContactName], [Phone])
VALUES ('KH123', 'TITV.VN', 'Le Nhat Tung', '0123456789');

-- Thêm một khách hàng mới đầy đủ các cột
INSERT INTO [dbo].[Customers]
VALUES ('KH456', 'TITV.VN', 'Le Nhat Tung', '0123456789', '-', null, null, null, null, null, null);

-- Thêm nhiều khách hàng mới cùng lúc
INSERT INTO [dbo].[Customers]([CustomerID], [CompanyName], [ContactName], [Phone])
VALUES 
	('KH124', 'TITV.VN', 'Le Nhat Tung', '0123456789'),
	('KH125', 'TITV.VN', 'Le Nhat Tung', '0123456789'),
	('KH126', 'TITV.VN', 'Le Nhat Tung', '0123456789'),
	('KH127', 'TITV.VN', 'Le Nhat Tung', '0123456789');

-- Thêm một sản phẩm mới
INSERT INTO Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock) 
VALUES ('New Product', 1, 2, '24 bottles', 10.99, 100);

INSERT INTO dbo.[Order Details]
SELECT * FROM dbo.[Order Details]

--Bài Tập

--VD 
--Viết một câu lệnh INSERT INTO để thêm nhà cung cấp sau vào bảng Suppliers:
--SupplierName: "New Supplier"
--ContactName: "John Smith"
--ContactTitle: "Sales Manager"
--Address: "123 Supplier Street"
--City: "New York"
--Region: "NY"
--PostalCode: "10001"
--Country: "USA"
--Phone: "555-555-5555"
--Fax: "555-555-5556"
--HomePage: "http://www.newsupplier.com"
INSERT INTO dbo.Suppliers
VALUES ('New Supplier', 'John Smith', 'Sales Manager', '123 Supplier Street', 'New York', 'NY', 10001, 'USA', '555-555-5555', '555-555-5556', 'http://www.newsupplier.com');

--VD 
--Hãy viết một câu lệnh INSERT INTO để thêm 3 đơn hàng sau:
--CustomerID: Chọn một mã khách hàng hiện có trong bảng Customers.
--EmployeelD: Chọn một mã nhân viên hiện có trong bảng Employees.
--OrderDate: Sử dụng ngày hiện tại.
--ShipVia: Chọn một mã Shipper hiện có trong bảng Shippers.
--Và sắp xếp orderdate giảm dần để xem kết quả.
INSERT INTO dbo.Orders ([CustomerID], [EmployeeID], [OrderDate], [ShipVia])
VALUES	('VINET', 3, GETDATE(), 3),
		('QUICK', 7, GETDATE(), 2), 
		('ROMEY', 6, GETDATE(), 1)
SELECT *
FROM dbo.Orders
ORDER BY OrderDate DESC;

------------------------------------------------------------
-- ////// SELECT INTO \\\\\\

-- CÚ PHÁP
--SELECT *|column1, column2, column3,...
--INTO newtable [IN externaldb]
--FROM oldtable
--WHERE condition;

--Câu lệnh SELECT INTO trong SQL được sử dụng để tạo một bảng mới và sao chép
--dữ liệu từ một bảng hiện có vào bảng mới này.

--Nó thường được sử dụng để tạo bảng tạm thời hoặc sao lưu dữ liệu từ một bảng hiện
--có để thực hiện các phân tích hoặc thao tác dữ liệu khác.

--Câu lệnh SELECT INTO cũng có thể sử dụng để chọn một phần dữ liệu từ bảng nguồn
--và chèn nó vào bảng mới.

--LƯU Ý:
--ƯU ĐIỂM:
--Tạo Bảng Tạm Thời: SELECT INTO thường được sử dụng để tạo bảng tạm thời để lưu trữ
--kết quả truy vấn hoặc tạo các bảng chứa dữ liệu cần phân tích mà không cần thay đổi bảng nguồn.
--Sao Lưu Dữ Liệu: Bạn có thể sử dụng SELECT INTO để sao lưu dữ liệu từ bảng gốc vào
--bảng tạm thời để tránh mất dữ liệu trong quá trình thực hiện các thao tác.
--Trích Xuất Dữ Liệu: Khi bạn cần trích xuất một phần hoặc toàn bộ dữ liệu từ bảng gốc để
--thực hiện xử lý dữ liệu khác mà không ảnh hưởng đến dữ liệu gốc.
--Tạo Tổng Hợp Dữ Liệu: Đôi khi, bạn có thể sử dụng SELECT INTO để tạo bảng mới chứa
--kết quả tổng hợp 

--NHƯỢC ĐIỂM
--Không Nên Sử Dụng Trong Môi Trường Sản Xuất: SELECT INTO thường được sử
--dụng trong quá trình phát triển, kiểm thử, hoặc xử lý dữ liệu, nhưng không nên được
--sử dụng trong môi trường sản xuất nếu không cần thiết, vì nó có thể tạo ra nhiều bảng
--tạm thời không cần thiết và làm tăng kích thước cơ sở dữ liệu.
------------------------------------------------------------

--VD Tạo 1 bảng mới tạm thời với các sản phẩm có giá trị > 50.
SELECT *
INTO ProductPrice
FROM dbo.Products
WHERE UnitPrice > 50;

DROP TABLE ProductPrice;

--VD Tạo 1 bảng mới tạm thời với các đơn hàng được giao đến USA
SELECT *
INTO OrderCountry
FROM dbo.Orders
WHERE ShipCountry = 'USA';

DROP TABLE OrderCountry;

--VD Tạo một bảng tạm thời "CustomersInLondon" từ bảng "Customers" trong cơ sở dữ
--liệu NorthWind để chứa thông tin của các khách hàng có địa chỉ ở Brazil
SELECT *
INTO CustomersInBrazil
FROM dbo.Customers
WHERE Country = 'Brazil';

DROP TABLE CustomersInLondon1;

--VD Tạo một bảng tạm thời "HighValueOrders" để chứa thông tin về các đơn hàng có tổng
--giá trị đặt hàng lớn hơn 1000 đô la.
SELECT *, (UnitPrice*Quantity) AS "Total order"
INTO HighValueOrders
FROM dbo.[Order Details]
WHERE (UnitPrice*Quantity) > 1000;

DROP TABLE HighValueOrders;