﻿--a) Bài tập về Store Procedures:
--1. Tạo một stored procedure có tên là sp_Greeting in ra dòng ‘Xin chào’ +
--@ten với @ten là tham số đầu vào là tên của bạn. Cho thực thi và in giá trị
--của các tham số này để kiểm tra.
CREATE PROCEDURE sp_Greeting(
	@ten NVARCHAR(100)
)
AS
BEGIN
	PRINT N'Xin Chào ' + @ten;
	PRINT N'Gía trị tham số @ten: ' + @ten;
END;
GO
EXEC sp_Greeting @ten = N'Trần Ngọc Hùng'

--2. Tạo một stored procedure có tên sp_SoHoc có 2 tham số @s1, @s2. Xuất
--tổng @s1+@s2 ra tham số @tong, số lớn nhất của 2 biến trên ra tham số
--@max và số nhỏ nhất ra tham số @min. In các giá trị @tong, @min, @max
--ra màn hình. 
CREATE PROCEDURE sp_SoHoc(
	@s1 int,
	@s2 int,
	@tong int OUTPUT,
	@max int OUTPUT,
	@min int OUTPUT
)
AS
BEGIN
	SET @tong = @s1 + @s2;
	IF @s1 > @s2
	BEGIN
		SET @max = @s1;
		SET @min = @s2;
	END
	ELSE
    BEGIN
        SET @max = @s2;
        SET @min = @s1;
    END
	PRINT N'Tổng s1 và s2 là: ' + CAST(@tong AS NVARCHAR(10));
	PRINT N'Gía trị lớn nhất là: ' + CAST(@max AS NVARCHAR(10));
	PRINT N'Gía trị nhỏ nhất là: ' + CAST(@min AS NVARCHAR(10));
END;
GO

EXEC sp_SoHoc @s1 = 10, @s2 = 7, @tong = 0, @max = 0, @min = 0;

--3. Ứng với mỗi bảng trong CSDL Quản lý bóng đá, bạn hãy viết 4 Stored
--Procedures: sp_Insert_<tên bảng>, sp_Update_<tên bảng>,
--sp_Delete_<tên bảng>, và sp_Select_<tên bảng> ứng với 4 công việc
--Insert/Update/Delete/Select. 

--////// INSERT \\\\\\
CREATE PROCEDURE sp_Insert_TINH(
	@MATINH VARCHAR(5),
	@TENTINH NVARCHAR(100),
	@RESULT NVARCHAR(100) output
)
AS
BEGIN
	DECLARE @COUNTS INT = 0;
	DECLARE @error INT;
	DECLARE @id INT;
	SELECT @COUNTS = COUNT(*) FROM dbo.TINH AS A WHERE A.MATINH=@MATINH;
	IF @COUNTS >= 1
		SET @RESULT = N'Tồn tại mã tỉnh '+@MATINH;
	ELSE
		BEGIN
			INSERT INTO TINH VALUES (@MATINH, @TENTINH);
			SELECT @error = @@ERROR, @id = SCOPE_IDENTITY();
			IF @error = 0
				SET @RESULT = N'Đã tạo dữ liệu cho mã tỉnh là: '+@MATINH;
			ELSE
				SET @RESULT = N'Đã xảy ra lỗi tạo dữ liệu với mã lỗi: '+@id;
	END
END
DECLARE @RESULT NVARCHAR(100);
EXEC sp_Insert_TINH 'HPH', N'HẢI PHÒNG',@RESULT OUTPUT;
SELECT @RESULT AS MESSAGES_RESULT; 

--////// UPDATE \\\\\\
CREATE PROC sp_UPDATE_TINH
@KEY VARCHAR(5),
@TENTINH NVARCHAR(100),
@RESULT NVARCHAR(100) output
AS
BEGIN
	DECLARE @COUNTS INT = 0;
	DECLARE @error INT;
	SELECT @COUNTS = COUNT(*) FROM TINH A WHERE A.MATINH = @KEY;
	IF @COUNTS = 0
		SET @RESULT = N'Không tìm thấy mã tỉnh: '+@KEY;
	ELSE
	BEGIN
		UPDATE TINH SET TENTINH=@TENTINH WHERE MATINH = @KEY;
		SELECT @error = @@ERROR
		IF @error = 0
			SET @RESULT = N'Đã cập nhật thông tin với mã tỉnh: '+@KEY;
		ELSE
			SET @RESULT = N'Đã xảy ra lỗi cập nhật';
	END;
END;
DECLARE @RESULT NVARCHAR(100);
EXEC sp_UPDATE_TINH 'HPH', N'Hải Phòng',@RESULT OUTPUT;
SELECT @RESULT AS MESSAGES_RESULT; 

--////// DELETE \\\\\\
CREATE PROC sp_DELETE_TINH
@KEY VARCHAR(5),
@RESULT NVARCHAR(100) output
AS
BEGIN
	DECLARE @COUNTS INT = 0;
	DECLARE @error INT;
	SELECT @COUNTS = COUNT(*) FROM TINH A WHERE A.MATINH = @KEY;
	IF @COUNTS = 0
		SET @RESULT = N'Không tìm thấy mã tỉnh: '+@KEY;
	ELSE
	BEGIN
		DELETE FROM TINH WHERE MATINH = @KEY;
		SELECT @error = @@ERROR;
		IF @error = 0
			SET @RESULT = N'Đã xóa mã tỉnh: '+@KEY;
		ELSE
			PRINT N'Đã xảy ra lỗi khi xóa mã tỉnh: '+@KEY;
	END
END;
DECLARE @RESULT NVARCHAR(100);
EXEC sp_DELETE_TINH 'BD',@RESULT OUTPUT;
SELECT @RESULT AS MESSAGES_RESULT;

--////// SELECT \\\\\\
CREATE PROC sp_SELECT_TINH
@KEY VARCHAR(5),
@RESULT NVARCHAR(100) output
AS
BEGIN
	DECLARE @COUNTS INT = 0;
	DECLARE @error INT;
	SELECT @COUNTS = COUNT(*) FROM TINH A WHERE A.MATINH = @KEY;
	IF @COUNTS = 0
		SET @RESULT = N'Không tìm thấy mã tỉnh: '+@KEY;
	ELSE
	BEGIN
		SELECT * FROM TINH A WHERE A.MATINH=@KEY;
		SET @RESULT =N'Tìm thấy '+CAST(@COUNTS AS NVARCHAR(100))+ N' bản ghi';
	END
END;
DECLARE @RESULT NVARCHAR(100);
EXEC sp_SELECT_TINH 'BD',@RESULT OUTPUT;
SELECT @RESULT AS MESSAGES_RESULT; 

--4. Viết thủ tục sp_GetTableRowCounts đếm số lượng records có trong bảng
--BANGXH của CSDL QLBongD
CREATE PROC sp_GetTableRowCounts
AS
BEGIN
	SELECT COUNT(*) AS "Số lượng records"
	FROM dbo.BANGXH
END
GO
EXEC sp_GetTableRowCounts

--b) Bài tập về functions
--1. Viết hàm SoBanThang tính số lượng bàn thắng của đội BECAMEX BÌNH
--DƯƠNG trong năm 2009 có 2 tham số đầu vào là @TênĐội và Năm.
CREATE FUNCTION SoBanThang (
    @TenDoi NVARCHAR(100),
    @Nam INT
)
RETURNS INT
AS
BEGIN
    DECLARE @TongBanThang INT;

    SELECT @TongBanThang = SUM(CAST(LEFT(HIEUSO, 1) AS INT))
    FROM dbo.CAULACBO c
	JOIN dbo.BANGXH b ON c.MACLB = b.MACLB
    WHERE TENCLB = @TenDoi AND b.NAM = @Nam;

    RETURN @TongBanThang;
END;
GO

SELECT dbo.SoBanThang(N'BECAMEX BÌNH DƯƠNG', 2009) AS "So luong ban thang";

--2. Tạo hàm có tên XemThongTinTranDau trả về 1 bảng dữ liệu bao gồm
--MATRAN, NGAYTD, VONG, TENCLB1, TENCLB2, TENSAN, KETQUA.Thực thi
--hàm để in ra bảng trên. 
CREATE FUNCTION XemThongTinTranDau()
RETURNS TABLE
AS
RETURN (
    SELECT
        TD.MATRAN,
        TD.NGAYTD,
        TD.VONG,
        CLB1.TENCLB AS TENCLB1,
        CLB2.TENCLB AS TENCLB2,
        S.TENSAN,
        TD.KETQUA
    FROM
        TRANDAU TD
    JOIN
        CAULACBO CLB1 ON TD.MACLB1 = CLB1.MACLB
    JOIN
        CAULACBO CLB2 ON TD.MACLB2 = CLB2.MACLB
    JOIN
        SANVD S ON TD.MASAN = S.MASAN
);
GO
SELECT * FROM XemThongTinTranDau();

--c) Bài tập về Triggers
--1. Khi thêm cầu thủ mới, cần kiểm tra:
--a. vị trí trên sân của cầu thủ chỉ thuộc một trong các vị trí sau: Thủ môn,
--Tiền đạo, Tiền vệ, Trung vệ, Hậu vệ. 
--b. số áo của cầu thủ thuộc cùng một câu lạc bộ phải khác nhau.
--c. số lượng cầu thủ nước ngoài ở mỗi câu lạc bộ chỉ được phép đăng ký tối đa 8 cầu thủ.
CREATE TRIGGER trg_KiemTraCauThu
ON dbo.CAUTHU
FOR INSERT
AS
BEGIN
    -- a. Kiểm tra vị trí trên sân
    IF EXISTS (
		SELECT 1 
		FROM inserted 
		WHERE VITRI NOT IN ('Thủ môn', 'Tiền đạo', 'Tiền vệ', 'Trung vệ', 'Hậu vệ'))
    BEGIN
        RAISERROR('Vị trí trên sân không hợp lệ.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- b. Kiểm tra số áo
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN CAUTHU c ON i.MACLB = c.MACLB AND i.SO = c.SO
    )
    BEGIN
        RAISERROR('Số áo cầu thủ trùng với cầu thủ khác trong cùng câu lạc bộ.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- c. Kiểm tra số lượng cầu thủ nước ngoài
    DECLARE @SoLuongCauThuNuocNgoai INT;
    SELECT @SoLuongCauThuNuocNgoai = COUNT(*)
    FROM CAUTHU c
    JOIN inserted i ON c.MACLB = i.MACLB
    WHERE c.MAQG != (SELECT MAQG FROM inserted);

    IF @SoLuongCauThuNuocNgoai >= 8
    BEGIN
        RAISERROR('Số lượng cầu thủ nước ngoài vượt quá giới hạn (8 cầu thủ).', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;

--2. Khi thêm tên quốc gia, kiểm tra tên quốc gia không được trùng với tên quốc gia đã có. 
CREATE TRIGGER TRIG_QG ON dbo.QUOCGIA
FOR INSERT
AS
	DECLARE @MAQG VARCHAR(5);
	DECLARE @TENQG NVARCHAR(100);
BEGIN
	SELECT @MAQG = A.MAQG, @TENQG = A.TENQG FROM INSERTED A;
	IF((SELECT COUNT(*) FROM dbo.QUOCGIA Q WHERE Q.TENQG =@TENQG) = 0)
	BEGIN
		DECLARE @error INT;
		INSERT INTO dbo.QUOCGIA VALUES (@MAQG, @TENQG);
		SELECT @error = @@ERROR;
		IF @error = 0
		BEGIN
			COMMIT TRANSACTION;
			PRINT N'Đã thêm tên quốc gia';
		END
		ELSE
		BEGIN
			PRINT N'Xảy ra lỗi khi thêm quốc gia';
			ROLLBACK TRANSACTION;
		END
	END
	ELSE
	BEGIN
		PRINT N'TÊN QUỐC GIA ĐÃ TỒN TẠI';
		ROLLBACK TRANSACTION;
	END
END; 
--2.1 Khi thêm tên tỉnh thành, kiểm tra tên tỉnh thành không được trùng với tên tỉnh thành đã có.
CREATE TRIGGER TRIG_TINH ON TINH
FOR INSERT
AS
	DECLARE @MATINH VARCHAR(5);
	DECLARE @TENTINH NVARCHAR(100);
BEGIN
	SELECT @MATINH = A.MATINH, @TENTINH = A.TENTINH FROM INSERTED A;
	IF((SELECT COUNT(*) FROM TINH T WHERE T.TENTINH =@TENTINH) = 0)
	BEGIN
		DECLARE @error INT;
		INSERT INTO TINH VALUES (@MATINH, @TENTINH);
		SELECT @error = @@ERROR;
		IF @error = 0
		BEGIN
			COMMIT TRANSACTION;
			PRINT N'Đã thêm TỈNH';
		END
		ELSE
		BEGIN
			PRINT N'Xảy ra lỗi khi thêm TỈNH';
			ROLLBACK TRANSACTION;
		END
	END
	ELSE
	BEGIN
		PRINT N'TÊN TỈNH ĐÃ TỒN TẠI';
		ROLLBACK TRANSACTION;
	END
END; 