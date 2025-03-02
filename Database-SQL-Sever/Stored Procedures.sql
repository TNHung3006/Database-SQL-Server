------------------------------------------------------------
-- ////// Stored procedure là gì \\\\\\

--Stored procedure là gì?

--Stored procedure là tap hợp một hoặc nhiều câu lệnh T-SQL thành 1
--nhóm đơn vị xử lý logic và được lưu trữ trên Database Server.

--Khi một câu lệnh gọi chạy stored procedure lần đầu tiên thì SQL Server
--sẽ chạy nó và lưu trữ vào bộ nhớ đệm, gọi là plan cache, những lần tiếp
--theo SQL Server sẽ sử dụng lại plan cache nên sẽ cho tốc độ xử lý tối ưu.

--Stored procedure rất tiện lợi cho người quản trị database (DBA), nó giúp
--DBA tạo ra những nhóm câu lệnh và gửi đến một bô phận khác mà họ
--sẽ không cần quan tâm đến nội dung bên trong stored procedure có gì,
--họ chỉ quan tâm đến tham số đầu vào và đầu ra.

-- ////// CÚ PHÁP \\\\\\

--CREATE PROCEDURE [database_name]. [schema_name].[procedure_name]
--(
--	[parameter_1] [datatype] [, parameter_2] [datatype] ...
--)
--AS
--BEGIN
--	[statements]
--END

-- Ưu điểm @@@@@@@@@@@
	--Hiệu suất tốt:
	--Các cuộc gọi thủ tục nhanh chóng và hiệu quả vì các thủ tục lưu trữ được biên dịch một lần và được lưu trữ ở dạng thực thi.
	--Mã thực thi được tự động lưu trữ, do đó làm giảm yêu cầu bộ nhớ.
	--Khi thực thi một câu lệnh SQL thì SQL Server phải kiểm tra permission xem user gởi câu lệnh đó có được phép thực hiện câu
	--lệnh hay không đồng thời kiểm tra cú pháp rồi mới tạo ra một execute plan và thực thi. Nếu có nhiều câu lệnh như vậy gởi qua
	--network có thể làm giảm đi tốc độ làm việc của server.
	--SQL Server sẽ làm việc hiệu quả hơn nếu dùng stored procedure vì người gởi chỉ gởi một câu lệnh đơn và SQL Server chỉ kiểm
	--tra một lần sau đó tạo ra một execute plan và thực thi. Nếu stored procedure được gọi nhiều lần thì execute plan có thể được sử
	--dụng lại nên sẽ làm việc nhanh hơn. Ngoài ra cú pháp của các câu lệnh SQL đã được SQL Sever kiểm tra trước khi save nên nó
	--không cần kiểm lại khi thực thi.
--Nhược điểm @@@@@@@@@@@@@
	--Khả năng kiểm tra: logic nghiệp vụ được gói gọn trong các thủ tục lưu trữ nên rất khó kiểm tra (nếu được kiểm tra). Việc viết các kiểm thử
	--cho bất kỳ logic nghiệp vụ nào trong một thủ tục lưu trữ là không thể, bởi vì không có cách nào để phân tách rõ ràng logic nghiệp vụ.
	--Khả năng gỡ lỗi: tùy thuộc vào các hệ quản trị cơ sở dữ liệu, việc gỡ lỗi các thủ tục sẽ không thực hiện được hoặc cực kỳ khó hiểu. Chẳng
	--hạn như SQL Server có khả năng sửa lỗi và những hệ quản trị cơ sở dữ liệu khác thì không có. Điều này rất khó khăn cho lập trình viên.
	--(trên nền tảng phát triển doanh nghiệp điển hình)
	--Sợ thay đổi: một trong những nhược điểm lớn nhất của các thủ tục lưu trữ là cực kỳ khó để biết phần nào của hệ thống sử dụng chúng và
	--phần nào không. Đặc biệt là nếu phần mềm được chia thành nhiều ứng dụng thì thường không thể tìm thấy tất cả các tài liệu tham khảo
	--trong một lần (hoặc hoàn toàn nếu nhà phát triển không đọc quyền truy cập vào tất cả các dự án) và do đó khó có thể tự tin thiết lập một
	--cách chắc chắn thay đổi sẽ ảnh hưởng đến hệ thống tổng thể. Kết quả là các thủ tục được lưu trữ có nguy cơ rất lớn trong việc đưa ra các
	--thay đổi vi phạm và các nhóm phát triển thường né tránh thực hiện bất kỳ thay đổi nào. Đôi khi điều này có thể dẫn đến làm tê liệt những
	--đổi mới công nghệ mới.

------------------------------------------------------------

--VD Tạo một stored procedure để lấy thông tin
--về sản phẩm dựa trên tên sản phẩm được cung cấp.
CREATE PROCEDURE ProductProcedure (
	@ProductName VARCHAR(100)
)
AS
BEGIN
	SELECT *
	FROM dbo.Products p
	WHERE ProductName = @ProductName
END
--Sử dụng stored procedure
EXEC ProductProcedure @ProductName = 'Chang'
EXEC ProductProcedure @ProductName = 'Mi 3 mien'

-- Tạo một stored procedure để tính tổng doanh số bán hàng
-- của một nhân viên dựa trên EmployeeID.
CREATE PROCEDURE EmployeeProcedure (
	@EmployeeID VARCHAR(100)
)
AS
BEGIN
	SELECT e.EmployeeID, SUM(od.Quantity * od.UnitPrice) AS "total"		
	FROM dbo.Employees e
	INNER JOIN dbo.Orders o
	ON o.EmployeeID = e.EmployeeID
	INNER JOIN dbo.[Order Details] od
	ON o.OrderID = od.OrderID
	WHERE e.EmployeeID = @EmployeeID
	GROUP BY e.EmployeeID	
END
--Sử dụng
EXEC EmployeeProcedure @EmployeeID = 2
EXEC EmployeeProcedure @EmployeeID = 4

--Tạo 1 stored procedure để thêm mới khách hàng vào bảng Customers

CREATE PROCEDURE CustomerProcedure (
	@CustomerID VARCHAR(20),
	@CompanyName NVARCHAR(50),
	@City VARCHAR(50),
	@Country VARCHAR(50)
)
AS
BEGIN
	INSERT INTO dbo.Customers (CustomerID, CompanyName, City, Country)
	VALUES (@CustomerID, UPPER(@CompanyName), @City, @Country)
END
EXEC CustomerProcedure @CustomerID = 31367, @CompanyName = 'tranngochung', @City = 'Ninh Hoa', @Country = 'Khanh Hoa'
EXEC CustomerProcedure @CustomerID = 57867, @CompanyName = 'buivanb', @City = 'Ninh Hoa', @Country = 'Viet Nam'
EXEC CustomerProcedure @CustomerID = 18967, @CompanyName = 'buivana', @City = 'Ninh Hoa', @Country = 'VietNamese'



-- Tạo một stored procedure để cập nhật giá của tất cả cho một mã sản phẩm cụ thể
CREATE PROCEDURE ProductProcedure1 (
	@ProductID INT,
	@giasaukhithaydoi DECIMAL(10,2)
)
AS
BEGIN
	UPDATE dbo.Products
	SET [UnitPrice] = [UnitPrice] + @giasaukhithaydoi
	WHERE ProductID = @ProductID
END
EXEC ProductProcedure1 @ProductID = 2, @giasaukhithaydoi = 730


--Viết một Stored Procedure để truy xuất danh sách các đơn đặt hàng cho một khách hàng
--dựa trên tên khách hàng. Tham số đầu vào là tên khách hàng, và Stored Procedure sẽ trả
--về danh sách các đơn đặt hàng liên quan.
CREATE PROCEDURE CustomerProcedure (
	@ContactName VARCHAR(50)
)
AS 
BEGIN
	SELECT c.ContactName, o.*
	FROM dbo.Customers c
	JOIN dbo.Orders o
	ON o.CustomerID = c.CustomerID
	WHERE c.ContactName = @ContactName
END
EXEC CustomerProcedure @ContactName = 'Antonio Moreno'

--Viết một Stored Procedure để cập nhật số lượng hàng tồn kho(UnitsInStock) cho một sản phẩm cụ thể
--dựa trên ID sản phẩm và số lượng mới. Stored Procedure này sẽ nhận vào ID sản phẩm
--và số lượng mới, sau đó cập nhật số lượng tồn kho trong bảng Products.
CREATE PROCEDURE ProductProcedure (
	@UnitsInStock INT,
	@ProductID INT
)
AS
BEGIN
	UPDATE dbo.Products
	SET UnitsInStock = @UnitsInStock
	WHERE ProductID = @ProductID
END
EXEC ProductProcedure @UnitsInStock = 730, @ProductID = 2

--Viết một Stored Procedure để truy xuất danh sách các sản phẩm thuộc một danh mục cụ
--thể và giới hạn số lượng sản phẩm trả về. Tham số đầu vào bao gồm ID danh mục và số
--lượng sản phẩm cần trả về.
CREATE PROCEDURE ProductProcedure (
	@CategoryID INT, 
	@soluongsanphamcantrave INT
)
AS
BEGIN
	SELECT TOP (@soluongsanphamcantrave) * 
	FROM dbo.Products
	WHERE CategoryID = @CategoryID
END
EXEC ProductProcedure @CategoryID = 7, @soluongsanphamcantrave = 5

--Viết một Stored Procedure để truy xuất danh sách khách hàng dựa trên khu vực địa lý
--(Region) hoặc quốc gia (Country) của họ. Tham số đầu vào sẽ là khu vực địa lý hoặc
--quốc gia và Stored Procedure sẽ trả về danh sách các khách hàng trong khu vực đó.

CREATE PROCEDURE CustomerProcedure (
	@Country NVARCHAR(15),
	@Region nVARCHAR(15)
)
AS
BEGIN
	SELECT *
	FROM dbo.Customers
	WHERE Country = @Country OR Region = @Region
END
EXEC CustomerProcedure @Country = 'USA', @Region = 'Táchira'


DROP PROCEDURE CustomerProcedure;
