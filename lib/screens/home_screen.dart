import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../widgets/song_list_item.dart';
import 'player_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TH AUDIO',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showAddTabDialog(context),
            icon: const Icon(Icons.add, color: Colors.white),
            tooltip: 'Thêm tab mới',
          ),
        ],
      ),
      body: Consumer<MusicProvider>(
        builder: (context, musicProvider, child) {
          if (musicProvider.tabs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.music_note, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Chưa có tab nhạc nào',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Nhấn + để tạo tab mới',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Tab bar với hướng dẫn rõ ràng
              Container(
                color: Colors.blue[50],
                child: Column(
                  children: [
                    // Tab bar
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemCount: musicProvider.tabs.length,
                        itemBuilder: (context, index) {
                          final tab = musicProvider.tabs[index];
                          final isSelected = index == musicProvider.currentTabIndex;

                          return GestureDetector(
                            onTap: () => musicProvider.setCurrentTab(index),
                            onLongPress: () {
                              // Haptic feedback để user biết đã long press
                              // HapticFeedback.mediumImpact();
                              _showTabOptions(context, index, tab.title);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.blue[700] : Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: isSelected ? Colors.blue[700]! : Colors.blue[300]!,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isSelected 
                                        ? Colors.blue[700]!.withOpacity(0.3)
                                        : Colors.grey.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.library_music,
                                    size: 18,
                                    color: isSelected ? Colors.white : Colors.blue[700],
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    tab.title,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.blue[700],
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  // Visual cue cho long press
                                  Icon(
                                    Icons.more_vert,
                                    size: 14,
                                    color: isSelected 
                                        ? Colors.white.withOpacity(0.7)
                                        : Colors.blue[400],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Hướng dẫn rõ ràng
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.touch_app, size: 16, color: Colors.blue[600]),
                          const SizedBox(width: 4),
                          Text(
                            'Chạm để chọn • ',
                            style: TextStyle(
                              color: Colors.blue[600],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(Icons.touch_app, size: 16, color: Colors.orange[600]),
                          const SizedBox(width: 4),
                          Text(
                            'Giữ để sửa/xóa',
                            style: TextStyle(
                              color: Colors.orange[600],
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Song list
              Expanded(
                child: musicProvider.currentTab?.songs.isEmpty == true
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.queue_music, size: 64, color: Colors.blue[300]),
                            const SizedBox(height: 16),
                            Text(
                              'Chưa có bài hát nào trong "${musicProvider.currentTab?.title}"',
                              style: TextStyle(fontSize: 16, color: Colors.blue[600]),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Nhấn + để thêm nhạc',
                              style: TextStyle(color: Colors.blue[400]),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 8),
                        itemCount: musicProvider.currentTab?.songs.length ?? 0,
                        itemBuilder: (context, index) {
                          final song = musicProvider.currentTab!.songs[index];
                          return SongListItem(
                            song: song,
                            onTap: () {
                              musicProvider.playSong(song);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PlayerScreen(),
                                ),
                              );
                            },
                            onDelete: () => musicProvider.removeSongFromTab(
                              musicProvider.currentTabIndex,
                              index,
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Consumer<MusicProvider>(
        builder: (context, musicProvider, child) {
          if (musicProvider.tabs.isEmpty) return const SizedBox.shrink();
          
          return FloatingActionButton(
            onPressed: () => musicProvider.addSongToTab(musicProvider.currentTabIndex),
            backgroundColor: Colors.blue[700],
            tooltip: 'Thêm bài hát',
            child: const Icon(Icons.add, color: Colors.white),
          );
        },
      ),
    );
  }

  void _showAddTabDialog(BuildContext context) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.add_circle, color: Colors.blue[700]),
            const SizedBox(width: 8),
            const Text('Thêm tab mới'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Tên tab (ví dụ: Nhạc đám cưới)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.library_music),
              ),
              autofocus: true,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  context.read<MusicProvider>().addTab(value.trim());
                  Navigator.pop(context);
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              'Gợi ý: Nhạc trữ tình, Nhạc bolero, Nhạc thiếu nhi...',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                context.read<MusicProvider>().addTab(controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }

  void _showTabOptions(BuildContext context, int index, String currentTitle) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            
            // Title
            Row(
              children: [
                Icon(Icons.settings, color: Colors.blue[700]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Quản lý tab: "$currentTitle"',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Edit option
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.edit, color: Colors.blue[700]),
              ),
              title: const Text('Đổi tên tab'),
              subtitle: const Text('Thay đổi tên hiển thị của tab'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
              onTap: () {
                Navigator.pop(context);
                _showEditTabDialog(context, index, currentTitle);
              },
            ),
            
            const Divider(),
            
            // Delete option
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete, color: Colors.red),
              ),
              title: const Text('Xóa tab', style: TextStyle(color: Colors.red)),
              subtitle: const Text('Xóa tab và tất cả bài hát trong đó'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
              onTap: () {
                Navigator.pop(context);
                _showDeleteTabConfirmation(context, index, currentTitle);
              },
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showEditTabDialog(BuildContext context, int index, String currentTitle) {
    final controller = TextEditingController(text: currentTitle);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.edit, color: Colors.blue[700]),
            const SizedBox(width: 8),
            const Text('Đổi tên tab'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Tên tab mới',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.library_music),
              ),
              autofocus: true,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty && value.trim() != currentTitle) {
                  context.read<MusicProvider>().updateTabTitle(index, value.trim());
                  Navigator.pop(context);
                }
              },
            ),
            const SizedBox(height: 12),
            Text(
              'Tên hiện tại: "$currentTitle"',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              final newTitle = controller.text.trim();
              if (newTitle.isNotEmpty && newTitle != currentTitle) {
                context.read<MusicProvider>().updateTabTitle(index, newTitle);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Đã đổi tên thành "$newTitle"'),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _showDeleteTabConfirmation(BuildContext context, int index, String tabTitle) {
    final tabCount = context.read<MusicProvider>().tabs.length;
    final songCount = context.read<MusicProvider>().tabs[index].songs.length;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.warning, color: Colors.red),
            const SizedBox(width: 8),
            const Text('Xác nhận xóa'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bạn có chắc chắn muốn xóa tab "$tabTitle"?'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '⚠️ Lưu ý:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  const SizedBox(height: 4),
                  Text('• $songCount bài hát sẽ bị xóa'),
                  const Text('• Hành động này không thể hoàn tác'),
                  if (tabCount == 1)
                    const Text('• Đây là tab cuối cùng', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<MusicProvider>().removeTab(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Đã xóa tab "$tabTitle"'),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'OK',
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
} 