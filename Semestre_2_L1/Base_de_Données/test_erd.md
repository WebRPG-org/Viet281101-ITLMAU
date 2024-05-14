
# Chuyển đổi ERD sang Mô hình Dữ liệu Quan hệ

## Bước 1: Xác định các thực thể
Dựa trên sơ đồ ERD, các thực thể chính bao gồm:
1. **PHIEUXUAT**
2. **VATTU**
3. **PHIEUNHAP**
4. **DONHANG (DONDH)**
5. **NHACCC**

---

## Bước 2: Xác định các mối quan hệ
Các mối quan hệ và dạng kết nối được xác định từ ERD:
1. **Chi tiết phiếu xuất** (1 - N): PHIEUXUAT ↔ VATTU
   - Trường tạo thêm: `SoPX` (khóa ngoại trong bảng chi tiết)
2. **Chi tiết phiếu nhập** (1 - N): PHIEUNHAP ↔ VATTU
   - Trường tạo thêm: `SoPN` (khóa ngoại trong bảng chi tiết)
3. **Chi tiết đơn đặt hàng** (N - N): DONDH ↔ VATTU
   - Phải tạo bảng trung gian để quản lý mối quan hệ N - N
4. **Cung cấp** (N - 1): NHACC ↔ DONDH
   - Trường tạo thêm: `MaNCC` (khóa ngoại)

---

## Bước 3: Xác định các thuộc tính đa trị
Không có thuộc tính đa trị nào trong mô hình.

---

## Bước 4: Liệt kê danh sách các bảng
Danh sách các bảng chuyển đổi từ ERD sang mô hình quan hệ:

### 1. PHIEUXUAT
- **Trường**: SoPX (PK), NgayXuat
- **Quan hệ**: Liên kết với bảng Chi tiết phiếu xuất (1 - N)

### 2. VATTU
- **Trường**: MaVTU (PK), TenVTU, DGNhap
- **Quan hệ**: Liên kết với PHIEUXUAT, PHIEUNHAP và DONDH

### 3. PHIEUNHAP
- **Trường**: SoPN (PK), NgayNhap
- **Quan hệ**: Liên kết với bảng Chi tiết phiếu nhập (1 - N)

### 4. CHI_TIET_PX (bảng trung gian cho mối quan hệ PHIEUXUAT - VATTU)
- **Trường**: SoPX (FK), MaVTU (FK), DGXuat, SLXuat
- **Quan hệ**: FK từ PHIEUXUAT và VATTU

### 5. CHI_TIET_PN (bảng trung gian cho mối quan hệ PHIEUNHAP - VATTU)
- **Trường**: SoPN (FK), MaVTU (FK), SLNhap
- **Quan hệ**: FK từ PHIEUNHAP và VATTU

### 6. DONHANG (DONDH)
- **Trường**: SoDH (PK), NgayDH, MaNCC (FK)
- **Quan hệ**: FK liên kết với NHACCC

### 7. CHI_TIET_DONDH (bảng trung gian cho mối quan hệ DONDH - VATTU)
- **Trường**: SoDH (FK), MaVTU (FK)
- **Quan hệ**: FK từ DONHANG và VATTU

### 8. NHACCC
- **Trường**: MaNCC (PK), TenNCC, DiaChi, SDT
- **Quan hệ**: Liên kết 1 - N với DONHANG

---

## Bảng Tổng Quan

| **Bảng**          | **Trường chính (PK)**    | **Trường phụ thuộc (FK)** | **Thuộc tính khác**                  |
|--------------------|--------------------------|---------------------------|---------------------------------------|
| PHIEUXUAT         | SoPX                    |                           | NgayXuat                              |
| VATTU             | MaVTU                  |                           | TenVTU, DGNhap                       |
| PHIEUNHAP         | SoPN                    |                           | NgayNhap                              |
| CHI_TIET_PX       | (SoPX, MaVTU)           | SoPX, MaVTU              | DGXuat, SLXuat                       |
| CHI_TIET_PN       | (SoPN, MaVTU)           | SoPN, MaVTU              | SLNhap                                |
| DONHANG           | SoDH                    | MaNCC                    | NgayDH                                |
| CHI_TIET_DONDH    | (SoDH, MaVTU)           | SoDH, MaVTU              |                                       |
| NHACCC            | MaNCC                  |                           | TenNCC, DiaChi, SDT                  |

Nguyễn Việt Anh
