# Ứng dụng phát nhạc Flutter

Ứng dụng phát nhạc được phát triển bằng Flutter với đầy đủ tính năng quản lý và phát nhạc.

## Tính năng chính

### 📱 Quản lý Tab nhạc
- **Tạo tab mới**: Nhấn nút "+" trên thanh appbar để tạo tab mới (ví dụ: "Nhạc đám cưới", "Nhạc trữ tình")
- **Chuyển đổi tab**: Chạm vào tên tab để chuyển đổi giữa các tab
- **Sửa tên tab**: Giữ tab để hiển thị menu, chọn "Đổi tên tab"
- **Xóa tab**: Giữ tab để hiển thị menu, chọn "Xóa tab"

### 🎵 Quản lý bài hát
- **Thêm nhạc**: Nhấn nút "+" ở góc dưới bên phải để import file nhạc từ thiết bị
- **Phát nhạc**: Chạm vào bài hát để phát ngay lập tức
- **Xóa bài hát**: Nhấn nút menu (3 chấm) bên cạnh bài hát, chọn "Xóa"

### 🎮 Trình phát nhạc
- **Timeline**: Thanh tiến trình hiển thị quá trình phát nhạc
- **Thời gian**: Bên trái hiển thị thời gian đã phát, bên phải hiển thị thời gian còn lại
- **Controls**: 
  - ⏯️ Play/Pause: Phát/tạm dừng nhạc
  - ⏹️ Stop: Dừng phát và reset về đầu bài
  - ⏭️ Next/Previous: Chuyển bài (sẽ được cập nhật trong phiên bản tiếp theo)
- **Điều chỉnh âm lượng**: Thanh trượt âm lượng ở dưới controls
- **Controls bổ sung**: Repeat, Shuffle (sẽ được cập nhật trong phiên bản tiếp theo)

## Thiết kế UI

- **Màu chủ đạo**: Xanh dương (#1976D2)
- **Giao diện hiện đại**: Material Design 3
- **Responsive**: Tự động điều chỉnh theo kích thước màn hình
- **Gradient**: Màn hình phát nhạc có gradient xanh dương đẹp mắt

## Hướng dẫn sử dụng

### Lần đầu sử dụng:
1. Khởi động app - sẽ có 2 tab mặc định: "Nhạc đám cưới" và "Nhạc trữ tình"
2. Chọn tab mong muốn
3. Nhấn nút "+" để thêm file nhạc
4. Chạm vào bài hát để phát

### Thêm tab mới:
1. Nhấn nút "+" trên thanh tiêu đề
2. Nhập tên tab (ví dụ: "Nhạc bolero", "Nhạc thiếu nhi")
3. Nhấn "Thêm"

### Phát nhạc:
1. Chọn bài hát từ danh sách
2. Màn hình phát nhạc sẽ mở ra
3. Sử dụng các controls để điều khiển:
   - Thanh timeline để tua nhạc
   - Nút play/pause
   - Thanh âm lượng

## Yêu cầu hệ thống

- **Flutter**: >= 3.3.1
- **Dart**: >= 3.3.1
- **Platform**: Windows, Android, iOS, macOS, Linux

## Dependencies chính

- `audioplayers`: Phát nhạc
- `file_picker`: Chọn file nhạc
- `provider`: Quản lý state
- `shared_preferences`: Lưu trữ dữ liệu
- `permission_handler`: Quản lý quyền truy cập

## Cài đặt và chạy

```bash
# Clone hoặc tải project
cd music_player_app

# Cài đặt dependencies
flutter pub get

# Chạy ứng dụng
flutter run
```

## Tính năng sẽ được phát triển

- [ ] Chuyển bài tự động (Next/Previous)
- [ ] Phát ngẫu nhiên (Shuffle)
- [ ] Lặp lại (Repeat)
- [ ] Playlist tự động
- [ ] Hiển thị thông tin file nhạc chi tiết
- [ ] Equalizer
- [ ] Dark mode
- [ ] Export/Import playlists

## Báo lỗi và góp ý

Nếu gặp lỗi hoặc có góp ý, vui lòng tạo issue mới.

---

**Phát triển bởi Flutter** 🎵
