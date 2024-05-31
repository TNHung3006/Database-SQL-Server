------------------------------------------------------------
-- ////// Windows Functions \\\\\\

--Giới thiệu về Windows Functions

--Windows Functions (hoặc còn gọi là Windowed Functions) là một tính năng mạnh mẽ
--trong SQL Server cho phép chúng ta thực hiện tính toán trên một tập dữ liệu con (window)
--của bảng dữ liệu, thay vì trên toàn bộ bảng.

--Các loại Windows Functions

--Aggregate Functions: Được sử dung để thực hiện tính toán tổng hợp như SUM, AVG,
--COUNT trên một window.
--Ranking Functions: Được sử dung để xếp hàng các dòng dữ liệu trong một window, 
--ví dụ: ROW_NUMBER, RANK, DENSE_RANK.
--Analytic Functions: Cho phép thực hiện tính toán trên các dòng dữ liệu trong window
--và trả về kết quả cho mỗi dòng mà không làm thay đổi kích thước của kết quả, 
--ví dụ: LAG, LEAD, FIRST_VALUE, LAST_VALUE.

--Cú pháp cơ bản

--FUNCTION_NAME (expression) OVER (
--[PARTITION(phân vùng) BY partition_expression, ... ]
--[ORDER BY sort_expression [ASC | DESC], ... ]
--[ROWS BETWEEN frame_specification]
--)

--Danh sách các Functions

--ROW_NUMBER(): Gán một số thứ tự (row number) duy nhất cho mỗi dòng trong window, bắt đầu từ 1.

--RANK(): Xếp hạng các dòng dựa trên giá trị của cột được sắp xếp. Giá trị trùng lặp được
--xếp hạng giồng nhau và bỏ qua các sô xêp hạng sau.

--DENSE_RANK(): Tương tự như RANK(), nhưng giá trị trùng lặp có cùng một số xếp hạng
--và không bị bỏ qua các số xếp hạng sau.

--NTILE(n): Chia dữ liệu thành n phần bằng nhạu và gán một số xác định cho mỗi dòng để
--xác định phần nào của dữ liệu dòng đó thuộc về.

--LAG(column, n): Trả về giá trị của cột cho dòng trước đó (hoặc dòng thứ n trước đó) trong window.

--LEAD(column, n): Trả về giá trị của cột cho dòng sau đó (hoặc dòng thứ n sau đó) trong window.

--FIRST_VALUE(column): Trả về giá trị đầu tiên của cột trong window.

--LAST_VALUE(column): Trả về giá trị cuối cùng của cột trong window.

--SUM(column): Tính tổng giá trị của cột trong window.

--AVG(column): Tính giá trị trung bình của cột trong window.

--COUNT(column): Đếm số lượng dòng có giá trị không null của cột trong window.

--MIN(column): Tìm giá trị nhỏ nhất của cột trong window.

--MAX(column): Tìm giá trị lớn nhất của cột trong window.

--PERCENT_RANK(): Xếp hạng dòng dựa trên phần trăm vị trí của dòng trong window.
--Trả về giá trị từ 0 đến 1.

--CUME_DIST(): Xác định xem dòng đó thuộc phần bao nhiêu phần trăm của dữ liệu
--trong window. Trả về giá trị từ 0 đến 1.
------------------------------------------------------------

--VD Xếp hàng giá trị sản phẩm giảm dần, trên toàn bộ table
SELECT	ProductID, ProductName, UnitPrice, [CategoryID], 
		RANK() OVER (ORDER BY UnitPrice DESC) AS "rank"
FROM dbo.Products

--VD Xếp hàng giá trị sản phẩm giảm dần, trên từng thể loại(categoryID)
SELECT	ProductID, ProductName, UnitPrice, [CategoryID], 
		RANK() OVER (PARTITION BY CategoryID ORDER BY UnitPrice DESC) AS "rank"
FROM dbo.Products

--VD Xếp hàng giá trị sản phẩm giảm dần, trên từng thể loại(categoryID) không nhảy hạng
SELECT	ProductID, ProductName, UnitPrice, [CategoryID], 
		DENSE_RANK() OVER (PARTITION BY CategoryID ORDER BY UnitPrice DESC) AS "rank"
FROM dbo.Products

--VD Xếp hàng giá trị sản phẩm giảm dần, trên từng thể loại(categoryID) không bị trùng hạng
SELECT	ProductID, ProductName, UnitPrice, [CategoryID], 
		ROW_NUMBER() OVER (PARTITION BY CategoryID ORDER BY UnitPrice DESC) AS "rank"
FROM dbo.Products

-- Tạo bảng "sinh_vien"
-- Chèn 20 dòng dữ liệu thực tế vào bảng
-- Tạo bảng "sinh_vien"
CREATE TABLE [sinh_vien] (
    [ma_sinh_vien] INT PRIMARY KEY,
    [ho_ten] NVARCHAR(255),
    [diem_trung_binh] DECIMAL(3, 2),
    [ma_lop_hoc] INT
);
-- Chèn 20 dòng dữ liệu thực tế vào bảng
INSERT INTO [sinh_vien] ([ma_sinh_vien], [ho_ten], [diem_trung_binh], [ma_lop_hoc])
VALUES
    (1, N'Nguyễn Văn A', 3.75, 101),
    (2, N'Trần Thị B', 3.88, 102),
    (3, N'Phạm Văn C', 3.75, 101),
    (4, N'Huỳnh Thị D', 3.92, 103),
    (5, N'Lê Văn E', 3.60, 102),
    (6, N'Ngô Thị F', 3.78, 101),
    (7, N'Trịnh Văn G', 3.65, 102),
    (8, N'Võ Thị H', 3.80, 103),
    (9, N'Đặng Văn I', 3.55, 101),
    (10, N'Hoàng Thị K', 3.95, 102),
    (11, N'Mai Thị L', 3.70, 103),
    (12, N'Lý Thị M', 3.62, 101),
    (13, N'Chu Thị N', 3.85, 102),
    (14, N'Đỗ Thị P', 3.58, 103),
    (15, N'Dương Văn Q', 3.72, 101),
    (16, N'Lâm Thị R', 3.85, 102),
    (17, N'Nguyễn Văn S', 3.68, 101),
    (18, N'Nguyễn Thị T', 3.75, 103),
    (19, N'Nguyễn Văn U', 3.93, 102),
    (20, N'Nguyễn Thị V', 3.67, 101);

--VD Xếp hạng sinh viên toàn trường dựa trên điểm tb giảm dần
SELECT	[ma_sinh_vien], [ho_ten], [diem_trung_binh], [ma_lop_hoc],
		RANK() OVER (ORDER BY [diem_trung_binh] DESC) AS "RANK"
FROM dbo.sinh_vien

-- Xếp hạng sinh viên theo từng lớp học dựa trên điểm tb giảm dần (phân vùng mã lớp học)
SELECT	[ma_sinh_vien], [ho_ten], [diem_trung_binh], [ma_lop_hoc],
		RANK() OVER (PARTITION BY [ma_lop_hoc] ORDER BY [diem_trung_binh] DESC) AS "RANK"
FROM dbo.sinh_vien

-- Xếp hạng sinh viên theo từng lớp học dựa trên điểm tb giảm dần, không nhảy hạng
SELECT	[ma_sinh_vien], [ho_ten], [diem_trung_binh], [ma_lop_hoc],
		DENSE_RANK() OVER (PARTITION BY [ma_lop_hoc] ORDER BY [diem_trung_binh] DESC) AS "RANK"
FROM dbo.sinh_vien

-- Xếp hạng sinh viên theo từng lớp học dựa trên điểm tb giảm dần, không bị trùng hạng
SELECT	[ma_sinh_vien], [ho_ten], [diem_trung_binh], [ma_lop_hoc],
		ROW_NUMBER() OVER (PARTITION BY [ma_lop_hoc] ORDER BY [diem_trung_binh] DESC) AS "RANK"
FROM dbo.sinh_vien

-- Chúng ta sẽ sử dụng hàm LAG() lấy thông tin về đơn đặt hàng 
-- và ngày đặt hàng của đơn đặt hàng trước đó cho mỗi khách hàng.
SELECT	[OrderID], [CustomerID], [OrderDate], 
		LAG([OrderDate]) OVER (PARTITION BY [CustomerID] ORDER BY [OrderDate] ASC) AS "DAY"
FROM dbo.Orders;