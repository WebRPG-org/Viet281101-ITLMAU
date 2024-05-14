-- Tạo cơ sở dữ liệu QuanLyBanHang
DROP DATABASE QuanLyBanHang;
CREATE DATABASE QuanLyBanHang;
USE QuanLyBanHang;

-- Tạo bảng Customer
CREATE TABLE Customer (
	cID INT PRIMARY KEY, -- Mã khách hàng
	cName VARCHAR(255) NOT NULL, -- Tên khách hàng
	cAge INT CHECK (cAge > 0) -- Tuổi khách hàng
);

-- Tạo bảng Order
CREATE TABLE `Order` (
	oID INT PRIMARY KEY, -- Mã hóa đơn
	cID INT NOT NULL, -- Mã khách hàng
	oDate DATE NOT NULL, -- Ngày mua hàng
	oTotalPrice DECIMAL(10, 2), -- Tổng giá trị hóa đơn
	FOREIGN KEY (cID) REFERENCES Customer(cID)
);

-- Tạo bảng Product
CREATE TABLE Product (
	pID INT PRIMARY KEY, -- Mã sản phẩm
	pName VARCHAR(255) NOT NULL, -- Tên sản phẩm
	pPrice DECIMAL(10, 2) NOT NULL -- Giá tiền sản phẩm
);

-- Tạo bảng OrderDetail
CREATE TABLE OrderDetail (
	oID INT, -- Mã hóa đơn
	pID INT, -- Mã sản phẩm
	odQTY INT NOT NULL CHECK (odQTY > 0), -- Số lượng sản phẩm
	PRIMARY KEY (oID, pID),
	FOREIGN KEY (oID) REFERENCES `Order`(oID),
	FOREIGN KEY (pID) REFERENCES Product(pID)
);

SHOW TABLES;
