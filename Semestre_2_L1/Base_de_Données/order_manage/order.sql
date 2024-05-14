DROP DATABASE QuanLyBanHang;
CREATE DATABASE QuanLyBanHang;
USE QuanLyBanHang;

CREATE TABLE Customer (
	cID INT AUTO_INCREMENT PRIMARY KEY, -- Mã khách hàng (Khóa chính)
	cName VARCHAR(100) NOT NULL,        -- Tên khách hàng
	cAge INT                            -- Tuổi khách hàng
);

CREATE TABLE `Order` (
	oID INT AUTO_INCREMENT PRIMARY KEY, -- Mã hóa đơn (Khóa chính)
	cID INT NOT NULL,                   -- Mã khách hàng (Khóa ngoại)
	oDate DATE NOT NULL,                -- Ngày mua hàng
	oTotalPrice DECIMAL(10, 2),         -- Tổng giá trị hóa đơn
	FOREIGN KEY (cID) REFERENCES Customer(cID) -- Ràng buộc khóa ngoại
);

CREATE TABLE Product (
	pID INT AUTO_INCREMENT PRIMARY KEY, -- Mã sản phẩm (Khóa chính)
	pName VARCHAR(100) NOT NULL,        -- Tên sản phẩm
	pPrice DECIMAL(10, 2) NOT NULL      -- Giá sản phẩm
);

CREATE TABLE OrderDetail (
	oID INT NOT NULL,                   -- Mã hóa đơn (Khóa ngoại)
	pID INT NOT NULL,                   -- Mã sản phẩm (Khóa ngoại)
	odQTY INT NOT NULL,                 -- Số lượng sản phẩm
	PRIMARY KEY (oID, pID),             -- Khóa chính kết hợp
	FOREIGN KEY (oID) REFERENCES `Order`(oID),  -- Ràng buộc khóa ngoại tới bảng Order
	FOREIGN KEY (pID) REFERENCES Product(pID)   -- Ràng buộc khóa ngoại tới bảng Product
);


-- Thêm dữ liệu vào bảng Customer
INSERT INTO Customer (cID, cName, cAge)
VALUES 
	(1, 'Minh Quan', 10),
	(2, 'Ngoc Oanh', 20),
	(3, 'Hong Ha', 50);


-- Thêm dữ liệu vào bảng Order
INSERT INTO `Order` (oID, cID, oDate, oTotalPrice)
VALUES 
	(1, 1, '2006-03-21', NULL),
	(2, 2, '2006-03-23', NULL),
	(3, 1, '2006-03-16', NULL);


-- Thêm dữ liệu vào bảng Product
INSERT INTO Product (pID, pName, pPrice)
VALUES 
	(1, 'May Giat', 3),
	(2, 'Tu Lanh', 5),
	(3, 'Dieu Hoa', 7),
	(4, 'Quat', 1),
	(5, 'Bep Dien', 2);


-- Thêm dữ liệu vào bảng OrderDetail
INSERT INTO OrderDetail (oID, pID, odQTY)
VALUES 
	(1, 1, 3),
	(1, 3, 7),
	(1, 4, 2),
	(2, 1, 1),
	(3, 1, 8),
	(2, 5, 4),
	(2, 3, 3);


-- Hiển thị các thông tin gồm oID, oDate, oTotalPrice của tất cả các hóa đơn trong bảng Order
SELECT oID, oDate, oTotalPrice
FROM `Order`;


-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách hàng
SELECT c.cName AS CustomerName, p.pName AS ProductName
FROM Customer c
JOIN `Order` o ON c.cID = o.cID
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID;


-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT c.cName
FROM Customer c
LEFT JOIN `Order` o ON c.cID = o.cID
WHERE o.oID IS NULL;


-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn
SELECT 
	o.oID AS OrderID,
	o.oDate AS OrderDate,
	SUM(od.odQTY * p.pPrice) AS TotalPrice
FROM `Order` o
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID
GROUP BY o.oID, o.oDate;
