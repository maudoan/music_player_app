# 🎵 Hướng dẫn Sửa tên và Xóa Tab

## 📝 Tổng quan
Ứng dụng phát nhạc đã có đầy đủ tính năng quản lý tab với khả năng:
- ✅ **Sửa tên tab**: Thay đổi tên hiển thị của tab
- ✅ **Xóa tab**: Xóa tab và tất cả bài hát trong đó
- ✅ **Giao diện trực quan**: Menu xuất hiện khi giữ tab

## 🎯 Cách sử dụng

### 1️⃣ Sửa tên Tab

#### Bước 1: Mở menu tab
- **Giữ (long press)** vào tab mà bạn muốn sửa tên
- Menu quản lý tab sẽ xuất hiện từ dưới lên

#### Bước 2: Chọn "Đổi tên tab"
- Trong menu, chọn **"Đổi tên tab"** (icon ✏️)
- Dialog sửa tên sẽ mở ra

#### Bước 3: Nhập tên mới
- Nhập tên mới cho tab trong ô text
- Tên hiện tại sẽ được hiển thị sẵn
- Nhấn **"Lưu"** để xác nhận

#### Kết quả:
- Tên tab được cập nhật ngay lập tức
- Hiển thị thông báo xác nhận
- Dữ liệu được lưu tự động

---

### 2️⃣ Xóa Tab

#### Bước 1: Mở menu tab  
- **Giữ (long press)** vào tab mà bạn muốn xóa
- Menu quản lý tab sẽ xuất hiện

#### Bước 2: Chọn "Xóa tab"
- Trong menu, chọn **"Xóa tab"** (icon 🗑️ màu đỏ)
- Dialog xác nhận sẽ xuất hiện

#### Bước 3: Xác nhận xóa
- Đọc thông tin cảnh báo:
  - Số lượng bài hát sẽ bị xóa
  - Hành động không thể hoàn tác
- Nhấn **"Xóa"** để xác nhận

#### Kết quả:
- Tab và tất cả bài hát trong đó bị xóa
- Tự động chuyển sang tab khác (nếu có)
- Hiển thị thông báo xác nhận

---

## 🎨 Giao diện trực quan

### Tab Bar đã được thiết kế:
```
┌─────────────────────────────────────────┐
│ [🎵 Nhạc đám cưới] [🎵 Nhạc trữ tình]   │  ← Giữ để sửa/xóa
│         Giữ tab để sửa tên hoặc xóa     │  ← Hướng dẫn
└─────────────────────────────────────────┘
```

### Menu quản lý tab:
```
┌─────────────────────────────────────────┐
│              Quản lý tab: "Tên tab"     │
│                                         │
│  ✏️  Đổi tên tab                       │
│      Thay đổi tên hiển thị của tab     │
│  ─────────────────────────────────────  │
│  🗑️  Xóa tab                          │
│      Xóa tab và tất cả bài hát trong đó│
└─────────────────────────────────────────┘
```

---

## ⚠️ Lưu ý quan trọng

### Khi sửa tên tab:
- ✅ Tên không được để trống
- ✅ Tên mới phải khác tên cũ
- ✅ Thay đổi được lưu ngay lập tức
- ✅ Không ảnh hưởng đến bài hát trong tab

### Khi xóa tab:
- ⚠️ **CẢNH BÁO**: Tất cả bài hát trong tab sẽ bị xóa
- ⚠️ **KHÔNG THỂ HOÀN TÁC** - Hãy cân nhắc kỹ
- ⚠️ Nếu chỉ còn 1 tab cuối cùng, vẫn có thể xóa
- ⚠️ App sẽ tự tạo tab mặc định nếu không còn tab nào

---

## 🔧 Tính năng bổ sung

### Tạo tab mới:
- Nhấn nút **"+"** trên thanh tiêu đề
- Nhập tên tab mới
- Tab được tạo ngay lập tức

### Chuyển đổi tab:
- **Chạm** vào tab để chuyển đổi
- **Giữ** tab để sửa/xóa

---

## 🎯 Ví dụ thực tế

### Tình huống 1: Đổi tên tab
```
Tên cũ: "Nhạc đám cưới"
↓ Giữ tab → Chọn "Đổi tên"
↓ Nhập: "Nhạc cưới hỏi"
↓ Nhấn "Lưu"
Kết quả: "Nhạc cưới hỏi" ✅
```

### Tình huống 2: Xóa tab
```
Tab có: "Nhạc buồn" (5 bài hát)
↓ Giữ tab → Chọn "Xóa tab"
↓ Cảnh báo: "5 bài hát sẽ bị xóa"
↓ Nhấn "Xóa"
Kết quả: Tab bị xóa hoàn toàn ❌
```

---

## 🚀 Demo và Test

### Để test tính năng:
1. Mở ứng dụng
2. Tạo vài tab mới
3. Thêm bài hát vào các tab
4. Thử sửa tên tab
5. Thử xóa tab (cẩn thận!)

### Commands:
```bash
# Chạy ứng dụng
flutter run

# Kiểm tra code
flutter analyze
```

---

## 🎉 Kết luận

✅ **Tính năng đã hoàn thiện 100%**:
- Sửa tên tab với giao diện đẹp
- Xóa tab với cảnh báo an toàn  
- Menu trực quan, dễ sử dụng
- Lưu dữ liệu tự động
- Responsive design

**Enjoy your music! 🎵🎶** 