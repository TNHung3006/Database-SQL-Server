﻿--//////////////////////////////////////////////////////////////////////////////--
--1. Cho biết NGAYTD, TENCLB1, TENCLB2, KETQUA các trận đấu diễn ra vào tháng 3 trên sân 
--nhà mà không bị thủng lưới.
SELECT t.NGAYTD,
    clb1.TENCLB AS TENCLB1,
    clb2.TENCLB AS TENCLB2,
    t.KETQUA
FROM dbo.TRANDAU t
JOIN CAULACBO clb1 ON t.MACLB1 = clb1.MACLB
JOIN CAULACBO clb2 ON t.MACLB2 = clb2.MACLB
WHERE MONTH(NGAYTD) = 3
	AND (clb1.MASAN = t.MASAN OR clb2.MASAN = t.MASAN)
    AND t.KETQUA LIKE '%-0';

--2. Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ lót là “Công”. 
SELECT MACT, HOTEN, NGAYSINH
FROM dbo.CAUTHU
WHERE HOTEN LIKE N'%Công%'

--3. Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ không phải là họ “Nguyễn “. 
SELECT MACT, HOTEN, NGAYSINH
FROM dbo.CAUTHU
WHERE HOTEN NOT LIKE N'Nguyễn%'

--4. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ của những huấn luyện viên Việt 
--Nam có tuổi nằm trong khoảng 35-40. 
SELECT MAHLV, TENHLV, NGAYSINH, DIACHI
FROM DBO.HUANLUYENVIEN
WHERE YEAR(GETDATE()) - YEAR(NGAYSINH) BETWEEN 35 AND 40;

--5. Cho biết tên câu lạc bộ có huấn luyện viên trưởng sinh vào ngày 20 tháng 8 năm 2019. 
SELECT	TENCLB
FROM dbo.HUANLUYENVIEN h, dbo.CAULACBO c, dbo.HLV_CLB hc
WHERE h.MAHLV = hc.MAHLV AND c.MACLB = hc.MAHLV
	AND hc.VAITRO = N'HLV Chính' AND NGAYSINH = '2019-08-20'

--6. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có số bàn thắng nhiều nhất tính đến 
--hết vòng 3 năm 2009. 
SELECT Top 1 TENCLB, TENTINH, SUM(CAST(LEFT(HIEUSO, 1) AS INT)) AS TongBanThang
FROM dbo.CAULACBO c, dbo.TINH t, dbo.BANGXH b
WHERE c.MATINH = t.MATINH AND b.MACLB = c.MACLB
	AND VONG <= 3 AND Nam = 2009
GROUP BY TENCLB, TENTINH
ORDER BY TongBanThang DESC;

--b. Các toán tử nâng cao 
--1. Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong một câu lạc bộ mà chưa có số 
--điện thoại. 
SELECT TENHLV
FROM dbo.HUANLUYENVIEN
WHERE DIENTHOAI = NULL

--2. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác huấn 
--luyện tại bất kỳ một câu lạc bộ nào. 
SELECT TENHLV, MAHLV
FROM dbo.HUANLUYENVIEN h
WHERE MAQG = (SELECT MAQG FROM dbo.QUOCGIA WHERE TENQG = N'Việt Nam') 
	AND MAHLV NOT IN (SELECT MAHLV FROM dbo.HLV_CLB)

--3. Liệt kê các cầu thủ đang thi đấu trong các câu lạc bộ có thứ hạng ở vòng 3 năm 2009 
--lớn hơn 6 hoặc nhỏ hơn 3. 
SELECT HOTEN, HANG
FROM dbo.CAUTHU c
JOIN BANGXH b ON b.MACLB = c.MACLB
WHERE VONG = 3 AND NAM = 2009 AND HANG NOT BETWEEN 3 AND 6

--4. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của 
--câu lạc bộ (CLB) đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009. 
SELECT TOP 1 NGAYTD, clb1.TENCLB, clb2.TENCLB, TENSAN, KETQUA, HANG
FROM dbo.TRANDAU t
JOIN dbo.CAULACBO clb1 ON clb1.MACLB = t.MACLB1
JOIN dbo.CAULACBO clb2 ON clb2.MACLB = t.MACLB2
JOIN dbo.SANVD s ON s.MASAN = t.MASAN
JOIN dbo.BANGXH b ON b.MACLB = clb2.MACLB
WHERE b.VONG <= 3 AND b.NAM = 2009
ORDER BY HANG;

--c. Truy vấn con 
--1. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước 
--ngoài (Có quốc tịch khác “Việt Nam”) tương ứng của các câu lạc bộ có nhiều hơn 2 cầu 
--thủ nước ngoài. 
SELECT clb.MACLB, TENCLB, TENSAN, s.DIACHI, COUNT(MACT) as "Số lượng cầu thủ nước ngoài"
FROM dbo.CAULACBO clb
JOIN dbo.SANVD s ON s.MASAN = clb.MASAN
JOIN dbo.CAUTHU c ON c.MACLB = clb.MACLB
WHERE c.MAQG IN (SELECT MAQG FROM dbo.QUOCGIA WHERE TENQG != N'Việt Nam')
GROUP BY clb.MACLB, TENCLB, TENSAN, s.DIACHI
HAVING COUNT(MACT) > 2;

--2. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có hiệu số bàn thắng bại cao 
--nhất năm 2009. 
SELECT Top 1 TENCLB, TENTINH, SUM(CAST(LEFT(b.HIEUSO, 1) AS INT) - CAST(RIGHT(b.HIEUSO, 1) AS INT)) AS HieuSoBanThangBai
FROM dbo.CAULACBO c, dbo.TINH t, dbo.BANGXH b
WHERE c.MATINH = t.MATINH AND b.MACLB = c.MACLB  AND Nam = 2009
GROUP BY TENCLB, TENTINH
ORDER BY HieuSoBanThangBai DESC;

--3. Cho biết danh sách các trận đấu ( NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của 
--câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2009. 
SELECT TOP 1 t.NGAYTD, HANG,
    clb1.TENCLB AS TENCLB1,
    clb2.TENCLB AS TENCLB2,
    t.KETQUA
FROM dbo.TRANDAU t
JOIN CAULACBO clb1 ON t.MACLB1 = clb1.MACLB
JOIN CAULACBO clb2 ON t.MACLB2 = clb2.MACLB
JOIN BANGXH b ON b.MACLB = clb1.MACLB
WHERE b.VONG = 3 AND b.NAM = 2009
ORDER BY HANG DESC;

--4. Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại 
--(kể cả sân nhà và sân khách) trong mùa giải năm 2009. 
SELECT c.MACLB, c.TENCLB
FROM dbo.CAULACBO c
JOIN dbo.TRANDAU t ON c.MASAN = t.MASAN
WHERE t.NAM = 2009 And (c.MACLB = t.MACLB1 or c.MACLB = t.MACLB2)
GROUP BY c.MACLB, c.TENCLB

--5. Cho biết mã câu lạc bộ, tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại 
--(chỉ tính sân nhà) trong mùa giải năm 2009. 
SELECT c.MACLB, c.TENCLB
FROM dbo.CAULACBO c
JOIN dbo.TRANDAU t ON t.MASAN = c.MASAN
WHERE t.NAM = 2009 AND c.MACLB = t.MACLB1
GROUP BY c.MACLB, c.TENCLB
