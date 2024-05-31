------------------------------------------------------------
-- ////// SQL là gì? \\\\\\

--SQL (Structured Query Language) là một ngôn ngữ lập trình được sử
--dụng để thao tác với dữ liệu trong cơ sở dữ liệu quan hệ. SQL được
--sử dụng để tạo, truy vấn, thay đổi và xóa dữ liệu trong cơ sở dữ liệu.

--SQL có thể được chia thành bốn nhóm chính, bao gồm:

--1: DML (Data Manipulation Language): Các câu lenh DML được sử dung đe thao tác voi du
--liệu trong cơ sở dữ liệu, bao gồm các câu lệnh chèn, cập nhật, xóa và truy vấn.

--2: DDL (Data Definition Language): Cac câu lenh DDL được sử dung đe định nghĩa cau truc
--của cơ sở dữ liệu, bao gồm các bảng, cột, chỉ mục và ràng buộc.

--3: DCL (Data Control Language): Các câu lệnh DCL được sử dụng để kiểm soát quyền truy
--cập vào cơ sở dữ liệu, bao gồm các câu lệnh cấp phép và thu hồi quyền.

--4: TCL (Transaction Control Language): Các câu lệnh TCL được sử dụng để quản lý các giao
--dịch trong cơ sở dữ liệu, bao gồm các câu lệnh bắt đầu, xác nhận và hoàn tác giao dịch.

--1 ////// DML \\\\\\

--Các câu lệnh DML được sử dụng để thao tác với dữ liệu trong cơ sở dữ
--liệu. Các câu lệnh DML thường được sử dụng để thêm, cập nhật, xóa hoặc
--truy vấn dữ liệu.

--INSERT INTO: Chèn dữ liệu vào một bảng.
--UPDATE: Cập nhật dữ liệu trong một bảng.
--DELETE: Xóa dữ liệu từ một bảng.
--SELECT: Truy vấn dữ liệu từ một hoặc nhiều bảng.

--2 ////// DDL \\\\\\

--CREATE TABLE: Tạo một bảng mới.
--ALTER TABLE: Thêm, xóa hoặc sửa đổi các cột trong bảng.
--DROP TABLE: Xóa một bảng.
--CREATE INDEX: Tạo một chỉ mục cho một cột hoặc tập hợp các cột.
--DROP INDEX: Xóa một chỉ mục.
--CREATE CONSTRAINT: Tạo một ràng buộc cho một cột hoặc tập hợp các cột.
--DROP CONSTRAINT: Xóa một ràng buộc.

--3 ////// DCL \\\\\\

--Các câu lệnh DCL được sử dụng để kiểm soát quyền truy cập vào cơ
--sở dữ liệu. Các câu lệnh DCL thường được sử dụng để cấp quyền
--truy cập cho người dùng hoặc thu hồi quyền truy cập.

--GRANT: Cấp quyền truy cập cho người dùng.

--REVOKE: Thu hồi quyền truy cập cho người dùng.

--4 ////// TCL \\\\\\

--Các câu lệnh TCL được sử dụng để quản lý các giao dịch trong cơ sở
--dữ liệu. Các câu lệnh TCL thường được sử dụng để đảm bảo tính toàn
--vẹn dữ liệu trong trường hợp xảy ra lỗi.

--BEGIN TRANSACTION: Bắt đầu một giao dịch.
--COMMIT TRANSACTION: Xác nhận một giao dịch.
--ROLLBACK TRANSACTION: Hoàn tác một giao dịch.

------------------------------------------------------------