------------------------------------------------------------
-- ////// tạo CSDL \\\\\\
--CÚ PHÁP
--CREATE DATABASE <database_name>;
------------------------------------------------------------
--VD TẠO 1 CSDL nhân viên database
CREATE DATABASE NVDB
ON
(	NAME = 'nvdb_data',
	FILENAME = 'C:\data\nvdb_data.mdf',
	SIZE =10MB,
	MAXSIZE = 100MB,	-- Có thể đặt số khác
	FILEGROWTH = 5MB)	-- sau khi sử dụng hết size 10mb thì sẽ tăng 5mb mỗi lần
LOG ON
(	NAME = 'nvdb_log',
	FILENAME = 'C:\data\nvdb_log.ldf',
	SIZE =5MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB)	-- sau khi sử dụng hết size 5mb thì sẽ tăng 5mb mỗi lần

------------------------------------------------------------
-- ////// Cú pháp tạo TABLE mới \\\\\\

--CREATE TABLE [tên bảng] (
--[tên cột] [kiểu dữ liệu] [khóa chính] [khóa ngoại] [số lượng ký tự] [null] [kiểu ràng buộc],
--[tên cột] [kiểu dữ liệu] [khóa chính] [khóa ngoại] [số lượng ký tự] [null] [kiểu ràng buộc],
--);

--Trong đó:
--Tên bảng: Tên của bảng mới được tạo.
--Tên cột: Tên của cột trong bảng.
--Kiểu dữ liệu: Kiểu dữ liệu của cột.
--Khóa chính: Cột được chọn làm khóa chính của bảng.
--Khóa ngoại: Cột tham chiếu đến khóa chính của một bảng khác.
--Số lượng ký tự: Số lượng ký tự tối đa của cột.
--Null: Giá trị của cột có thể là null hay không.
--Kiểu ràng buộc: Ràng buộc áp dụng cho cột.

--Các loại kiểu dữ liệu

--Kiểu dữ liệu số: Lưu trữ các số nguyên, số thực và số thập phân.
--Kiểu dữ liệu chuỗi: Lưu trữ văn bản.
--Kiểu dữ liệu ngày và thời gian: Lưu trữ ngày, giờ và ngày giờ.
--Kiểu dữ liệu bit: Lưu trữ các giá trị logic, chẳng hạn là TRUE hoặcFALSE.
--tìm hiểu thêm trong link: https://www.w3schools.com/sql/sql_datatypes.asp

--Môt số lưu ý khi tạo TABLE://////////////

--Tên bảng phải bắt đầu bằng một ký tự chữ cái và không được chứa các ký tự đặc biệt
--Tên cột phải bắt đầu bằng một ký tự chữ cái hoặc số và không được chứa các ký tự đặc biệt.
--Kiểu dữ liệu của cột phải được xác định rõ ràng.
--Khóa chính của bảng phải là duy nhất.
--Khóa ngoại của bảng phải tham chiếu đến khóa chính của một bảng khác.

--CONSTRAINTS - Các lệnh bổ sung khi tạo bảng:

--IDENTITY: Tạo cột tự tăng.
--IDENTITY(seed, increment): Tạo cột tự tăng với giá trị seed và increment.
--DEFAULT: Thiết lập giá trị mặc định cho cột.
--CHECK: Thiết lập ràng buộc kiểm tra cho cột.
--UNIQUE: Thiết lập ràng buộc duy nhất cho cột.

--&&&&&&& Tìm hiểu thêm lệnh khác trong google = sql regex &&&&&&&

-- ////// Cú pháp thay đổi cấu trúc TABLE \\\\\\

--THÊM CỘT VÀO BẢNG
--ALTER TABLE table_name
--ADD column_name datatype;

--XOÁ CỘT
--ALTER TABLE table_name
--DROP COLUMN column_name;

--ĐỔI TÊN CỘT
--ALTER TABLE table_name
--RENAME COLUMN old_name to new_name;

--THAY ĐỔI GIỚI HẠN KÍ TỰ TRONG CỘT HOẶC THAY ĐỔI KIỂU DỮ LIỆU TRONG CỘT
--ALTER TABLE table_name
--ALTER COLUMN column_name datatype;

-- TRUNCATE và DROP

--Cú pháp này sẽ xóa tất cả dữ liệu trong bảng, nhưng không xóa cấu trúc của bảng.
--TRUNCATE TABLE table_name;

--Cú pháp này sẽ xóa hoàn toàn bảng, bao gồm cả cấu trúc và dữ liệu.
--DROP TABLE table_name;

------------------------------------------------------------

CREATE TABLE NhanVien(
	MANV INT NOT NULL PRIMARY KEY, 
	HoTen VARCHAR(50) NOT NULL, 
	GioiTinh VARCHAR(10), 
	NgaySinh DATE, 
	DiaChi VARCHAR(255),
	SDT VARCHAR(10)
);

-- Tao Table khach hang
CREATE TABLE KhachHang(
	MaKH INT IDENTITY(100, 5) NOT NULL PRIMARY KEY,
	TenKH VARCHAR(50) NOT NULL,
	DiaChi VARCHAR(255),
	SDT VARCHAR(10) CHECK (SDT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);

CREATE TABLE KhachHang_1(
	MaKH INT IDENTITY(100, 5) NOT NULL PRIMARY KEY,
	TenKH VARCHAR(50) NOT NULL,
	DiaChi VARCHAR(255),
	SDT VARCHAR(10) CHECK (LEN(SDT)=10 AND PATINDEX('%[^0-9]%', SDT)=0)
);

-- thêm cột email vào bảng nhân viên
ALTER TABLE nhanvien
ADD Email VARCHAR(100);

-- tăng giới hạng kí tự lên cột HoTen trong bảng nhân viên
ALTER TABLE nhanvien
ALTER COLUMN HoTen VARCHAR(100);

-- Kiểm tra ngày sinh phải trước ngày hiện tại (hàm ràng buộc)
-- hàm GETDATE() là ngày hiện tại được tích hợp sẵn trên sql
ALTER TABLE nhanvien
ADD CONSTRAINT NgaySinhCheck CHECK (NgaySinh <= GETDATE());

-- TRUNCATE va DROP
-- xoá dữ liệu trong bảng khachhang_1
TRUNCATE TABLE KhachHang_1;
-- xoá dữ liệu và bảng khachhang_1
DROP TABLE KhachHang_1;


-- Bài tập tổng hợp
--Yêu cầu
--1: Tạo bảng Sinh Vien với các cột sau:

--MaSV: Kiểu dữ liệu INT, khóa chính, không thể chứa giá trị null.
--HoTen: Kiểu dữ liệu VARCHAR(50), không thể chứa giá trị null.
--Lop: Kiểu dữ liệu VARCHAR(20).
--Nganh: Kiểu dữ liệu VARCHAR(20).
--DiemTB: Kiểu dữ liệu FLOAT.

--2: Thêm cột Email vào bảng SinhVien với kiểu dữ liệu VARCHAR(100).
--3: Sửa đổi kiểu dữ liệu của cột DiemTB trong bảng SinhVien thành kiểu dữliệu DECIMAL(2,1).
--4: Xóa cột Nganh khỏi bảng SinhVien.
--5: Thêm ràng buộc kiểm tra cho cột DiemTB trong bảng SinhVien để giá trị
--phải lớn hơn hoặc bằng 0 và <= 10.
--6: Thêm ràng buộc duy nhất cho cột MaSV trong bảng SinhVien.
--7: Thêm dữ liệu vào bảng Sinh Vien với một số thông tin thủ công.
--8: Xóa dữ liệu trong bảng Sinh Vien.
--9: Xóa bảng Sinh Vien.
--10: Tạo lại bảng Sinh Vien với cấu trúc ban đầu.

--1
CREATE TABLE SinhVien(
	MaSV INT NOT NULL PRIMARY KEY, 
	HoTen VARCHAR(50) NOT NULL, 
	Lop VARCHAR(20), 
	Nganh VARCHAR(20), 
	DiemTB FLOAT
);
--2
ALTER TABLE SinhVien
ADD Email VARCHAR(100);
--3
ALTER TABLE SinhVien
ALTER COLUMN DiemTB DECIMAL(2,1);
--4
ALTER TABLE SinhVien
DROP COLUMN Nganh;
--5
ALTER TABLE SinhVien
ADD CONSTRAINT DiemTBCheck CHECK (DiemTB BETWEEN 0 AND 10);
--6
ALTER TABLE SinhVien
ADD CONSTRAINT MaSVCheck UNIQUE (MaSV);
--8
TRUNCATE TABLE SinhVien;
--9
DROP TABLE SinhVien;
--10
CREATE TABLE SinhVien(
	MaSV INT NOT NULL PRIMARY KEY, 
	HoTen VARCHAR(50) NOT NULL, 
	Lop VARCHAR(20), 
	Nganh VARCHAR(20), 
);

