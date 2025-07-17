import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/song.dart';
import '../models/music_tab.dart';

class MusicProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  // State variables
  List<MusicTab> _tabs = [];
  int _currentTabIndex = 0;
  Song? _currentSong;
  bool _isPlaying = false;
  double _volume = 1.0;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  
  // Getters
  List<MusicTab> get tabs => _tabs;
  int get currentTabIndex => _currentTabIndex;
  MusicTab? get currentTab => _tabs.isNotEmpty ? _tabs[_currentTabIndex] : null;
  Song? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;
  double get volume => _volume;
  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  AudioPlayer get audioPlayer => _audioPlayer;

  MusicProvider() {
    _initializePlayer();
    _loadData();
  }

  void _initializePlayer() {
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      _isPlaying = state == PlayerState.playing;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((Duration position) {
      _currentPosition = position;
      notifyListeners();
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      _totalDuration = duration;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      _currentPosition = Duration.zero;
      _isPlaying = false;
      notifyListeners();
    });
  }

  // Tab management
  void addTab(String title) {
    final newTab = MusicTab(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
    );
    _tabs.add(newTab);
    _saveData();
    notifyListeners();
  }

  void removeTab(int index) {
    if (index >= 0 && index < _tabs.length) {
      _tabs.removeAt(index);
      if (_currentTabIndex >= _tabs.length && _tabs.isNotEmpty) {
        _currentTabIndex = _tabs.length - 1;
      } else if (_tabs.isEmpty) {
        _currentTabIndex = 0;
      }
      _saveData();
      notifyListeners();
    }
  }

  void updateTabTitle(int index, String newTitle) {
    if (index >= 0 && index < _tabs.length) {
      _tabs[index] = _tabs[index].copyWith(title: newTitle);
      _saveData();
      notifyListeners();
    }
  }

  void setCurrentTab(int index) {
    if (index >= 0 && index < _tabs.length) {
      _currentTabIndex = index;
      notifyListeners();
    }
  }

  // Song management
  Future<void> addSongToTab(int tabIndex) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        for (PlatformFile file in result.files) {
          if (file.path != null) {
            final song = Song(
              id: DateTime.now().millisecondsSinceEpoch.toString() + file.name,
              title: file.name.replaceAll(RegExp(r'\.[^.]*$'), ''), // Remove extension
              filePath: file.path!,
            );

            final updatedSongs = List<Song>.from(_tabs[tabIndex].songs)..add(song);
            _tabs[tabIndex] = _tabs[tabIndex].copyWith(songs: updatedSongs);
          }
        }
        _saveData();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error adding songs: $e');
    }
  }

  void removeSongFromTab(int tabIndex, int songIndex) {
    if (tabIndex >= 0 && tabIndex < _tabs.length) {
      final songs = List<Song>.from(_tabs[tabIndex].songs);
      if (songIndex >= 0 && songIndex < songs.length) {
        songs.removeAt(songIndex);
        _tabs[tabIndex] = _tabs[tabIndex].copyWith(songs: songs);
        _saveData();
        notifyListeners();
      }
    }
  }

  // Playback controls
  Future<void> playSong(Song song) async {
    try {
      _currentSong = song;
      await _audioPlayer.play(DeviceFileSource(song.filePath));
      notifyListeners();
    } catch (e) {
      debugPrint('Error playing song: $e');
    }
  }

  Future<void> pauseResume() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _resumeOrReplay();
      }
    } catch (e) {
      debugPrint('Error pause/resume: $e');
    }
  }

  // Method để resume hoặc play lại bài hát hiện tại
  Future<void> _resumeOrReplay() async {
    if (_currentSong == null) return;
    
    try {
      // Kiểm tra state của player
      final state = _audioPlayer.state;
      
      if (state == PlayerState.paused) {
        // Nếu đang pause, resume bình thường
        await _audioPlayer.resume();
      } else {
        // Nếu stopped hoặc state khác, play lại từ đầu
        await _audioPlayer.play(DeviceFileSource(_currentSong!.filePath));
      }
    } catch (e) {
      // Nếu có lỗi, cố gắng play lại từ đầu
      debugPrint('Error in _resumeOrReplay, trying to play from start: $e');
      try {
        await _audioPlayer.play(DeviceFileSource(_currentSong!.filePath));
      } catch (playError) {
        debugPrint('Error playing from start: $playError');
      }
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      _currentPosition = Duration.zero;
      // Không reset _currentSong để có thể play lại sau khi stop
      notifyListeners();
    } catch (e) {
      debugPrint('Error stopping: $e');
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      debugPrint('Error seeking: $e');
    }
  }

  // Method để play lại bài hát hiện tại từ đầu
  Future<void> replay() async {
    if (_currentSong != null) {
      try {
        await _audioPlayer.play(DeviceFileSource(_currentSong!.filePath));
      } catch (e) {
        debugPrint('Error replaying song: $e');
      }
    }
  }

  Future<void> setVolume(double volume) async {
    try {
      _volume = volume.clamp(0.0, 1.0);
      await _audioPlayer.setVolume(_volume);
      notifyListeners();
    } catch (e) {
      debugPrint('Error setting volume: $e');
    }
  }

  // Data persistence
  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tabsJson = _tabs.map((tab) => tab.toJson()).toList();
      await prefs.setString('music_tabs', jsonEncode(tabsJson));
      await prefs.setInt('current_tab_index', _currentTabIndex);
    } catch (e) {
      debugPrint('Error saving data: $e');
    }
  }

  Future<void> _loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tabsJsonString = prefs.getString('music_tabs');
      
      if (tabsJsonString != null) {
        final tabsJson = jsonDecode(tabsJsonString) as List;
        _tabs = tabsJson.map((json) => MusicTab.fromJson(json)).toList();
      } else {
        // Create default tabs
        _tabs = [
          MusicTab(id: '1', title: '.Nhà Trai'),
          MusicTab(id: '2', title: '.Nhà Gái'),
        ];
        _saveData();
      }

      _currentTabIndex = prefs.getInt('current_tab_index') ?? 0;
      if (_currentTabIndex >= _tabs.length) {
        _currentTabIndex = 0;
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading data: $e');
      // Create default tabs on error
      _tabs = [
        MusicTab(id: '1', title: '.Nhà Trai'),
        MusicTab(id: '2', title: '.Nhà Gái'),
      ];
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
} 