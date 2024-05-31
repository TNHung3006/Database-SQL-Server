------------------------------------------------------------
-- ////// VIEW \\\\\\

--View là gì?
	--Database View là sự trình bày data theo ý muốn được trích xuất từ một hoặc nhiều
	--table/view khác. View không lưu data nên nó còn được biết đến với cái tên "bảng ảo (Virtual tables)".
	--Các thao tác select, insert, update và delete với view tương tự như table bình thường.
--LƯU Ý:
	--Vì không lưu data nên tất cả những thao tác được thực hiện trên view thì đều được
	--phản ánh đến base table mà được trích xuất dữ liệu.
--CÚ PHÁP
	--CREATE VIEW view_name AS
	--SELECT column1, column2,...
	--FROM table_name
	--WHERE condition;
--Updatable view
	--Một View có thể được cấu hình để cho phép cập nhật nếu nó được tạo dựa trên một
	--bảng cơ sở dữ liệu và tuân theo một số yêu cầu. Điều này bao gồm:
	--View phải được tạo bằng cách sử dụng SELECT, không được chứa các phép toán SET,
	--UNION, DISTINCT, hoặc GROUP BY phức tạp.
	--View không được chứa các cột tính toán (computed columns).
	--View phải có đủ các trường cần thiết để cập nhật (ví dụ: PRIMARY KEY).
--Check option
	--CHECK OPTION trong View là mot đieu kien cho phep ban xac định rang buoc ve viec
	--cập nhật hoặc chèn dữ liệu vào View. Nó đảm bảo rằng các dòng dữ liệu được chèn
	--hoặc cập nhật thông qua View sẽ tuân theo một điều kiện cụ thể.
--Ưu điểm:
--View giúp đơn giản hóa những query phức tạp: Trong trường hợp cần truy xuất dữ liệu từ
	--nhiều table với logic phức tạp. Lúc này ta có thể tạo view với logic tương tự và thông qua
	--view chúng ta sẽ chỉ cần sử dụng những câu query đơn giản để truy xuất dữ liệu.
--Giới hạn data có thể truy cập với nhóm người dùng được chỉ định: Đôi khi ta không muốn
	--những dữ liệu nhạy cảm được truy cập bởi nhóm user nào đó. View có thể giúp ta giới hạn
	--row/column của những table theo điều kiện ta muốn lấy.
--View cung cấp thêm 1 lớp bảo mật cho database: Có những dữ liệu mà một nhóm người
	--dùng có thể truy cập nhưng lại không muốn họ có thể thao tác thay đổi. Option VIEW READ
	--ONLY sẽ giải quyết được vấn đề này.
--Cung cấp khả năng tương thích khi thay đổi cấu trúc dữ liệu.
--Nhược điểm
--Performance: Vì bản chất không lưu dữ liệu nên tất cả những thao tác được thực hiện trên
	--view thì đều được phản ánh đến base table. Do đó query processor phải translate view thành
	--query đến base table nên hiệu năng truy xuất dữ liệu có thẻ giảm nếu view phức tạp được
	--tạo từ nhiều table hoặc view được tạo từ view khác
--Phụ thuộc vào base table: Mỗi khi base table có sự thay đổi cấu trúc điều đó có thể khiến
	--view trở thành invalid

------------------------------------------------------------
--Tạo 1 view bảng orders
CREATE VIEW ThongKeTheoThang AS
SELECT	MONTH(OrderDate) AS "Tháng", 
		YEAR(OrderDate) AS "Năm", 
		COUNT(OrderID) AS "Số lượng đơn hàng"
FROM dbo.Orders
GROUP BY MONTH(OrderDate), YEAR(OrderDate);

--Truy vấn đến View
--cả 2 kiểu truy vấn đều chạy tốc độ như nhau
SELECT * 
FROM dbo.ThongKeTheoThang;
--tương tự
SELECT *
FROM (SELECT	MONTH(OrderDate) AS "Tháng", 
		YEAR(OrderDate) AS "Năm", 
		COUNT(OrderID) AS "Số lượng đơn hàng"
FROM dbo.Orders
GROUP BY MONTH(OrderDate), YEAR(OrderDate) 
) AS ABC;

--Tạo 1 view kết hợp thông tin về khách hàng và đơn hàng.
CREATE VIEW Order_Customer AS
SELECT	c.CustomerID, c.ContactName, c.Country, 
		o.[OrderID], o.[OrderDate], o.[Freight]
FROM dbo.Customers as c
INNER JOIN dbo.Orders as o
On c.CustomerID = o.CustomerID

--Tạo view hiển thị tổng giá trị của từng đơn hàng 
CREATE VIEW Tonggiatri_Order AS 
SELECT o.OrderID, o.OrderDate, SUM(od.Quantity * (od.UnitPrice - (od.UnitPrice * od.Discount))) AS "Total-Order"
FROM dbo.Orders o
INNER JOIN dbo.[Order Details] od
ON o.OrderID = od.OrderID
GROUP BY o.OrderID, o.OrderDate;

--Sử dụng CHECK OPTION để chỉ cho phép chèn dữ liệu thỏa mãn điều kiện. Giả sử bạn có một
--View có tên "HighValueProducts" để hiển thị sản phẩm có giá trị cao hơn $500.

CREATE VIEW HighValueProducts AS
SELECT ProductID, ProductName, UnitPrice
FROM dbo.Products 
WHERE UnitPrice > 500
WITH CHECK OPTION;


-- @@@@@@@@@@@@@ BÀI TẬP @@@@@@@@@@@@@

--Tạo một View có tên "HighValueProducts1" để hiển thị danh sách các sản
--phẩm có giá trị cao hơn $50.
CREATE VIEW HighValueProducts1 AS
SELECT ProductID, ProductName, UnitPrice
FROM dbo.Products 
WHERE UnitPrice > 50
WITH CHECK OPTION;

--Tạo một View có tên "CustomerOrders" để hiển thị thông tin về khách
--hàng và số lượng đơn hàng của họ.
CREATE VIEW CustomerOrders AS
SELECT c.CustomerID, c.ContactName, COUNT(o.OrderID) AS "Total"
FROM dbo.Customers c
INNER JOIN dbo.Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName;

--Tạo một View có tên "EmployeeSalesByYear" để hiển thị tổng doanh số
--bán hàng của từng nhân viên theo năm.
CREATE VIEW EmployeeSalesByYear AS
SELECT	e.EmployeeID, e.FirstName, e.LastName, o.OrderID, 
		SUM(od.Quantity*od.UnitPrice) AS "tổng doanh số bán hàng"
FROM dbo.Employees e
INNER JOIN dbo.Orders o
ON e.EmployeeID = o.EmployeeID
INNER JOIN dbo.[Order Details] od
ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, o.OrderID;

--Tạo một View có tên "CategoryProductCounts" để hiển thị số lượng sản
--phẩm trong mỗi danh mục sản phẩm.
CREATE VIEW CategoryProductCounts AS
SELECT	
FROM 
GROUP BY ;

--Tạo một View có tên "CustomerOrderSummary" để hiển thị tổng giá trị
--đặt hàng của mỗi khách hàng
CREATE VIEW CustomerOrderSummary AS
SELECT	c.[CustomerID], c.[ContactName], o.OrderID, 
		SUM(od.Quantity*od.UnitPrice) AS "tổng giá trị đặt hàng"
FROM dbo.Customers c
INNER JOIN dbo.Orders o
ON c.CustomerID = o.CustomerID
INNER JOIN dbo.[Order Details] od
ON o.OrderID = od.OrderID
GROUP BY c.[CustomerID], c.[ContactName], o.OrderID;