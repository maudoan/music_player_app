import 'song.dart';

class MusicTab {
  final String id;
  final String title;
  final List<Song> songs;

  MusicTab({
    required this.id,
    required this.title,
    this.songs = const [],
  });

  MusicTab copyWith({
    String? id,
    String? title,
    List<Song>? songs,
  }) {
    return MusicTab(
      id: id ?? this.id,
      title: title ?? this.title,
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'songs': songs.map((song) => song.toJson()).toList(),
    };
  }

  factory MusicTab.fromJson(Map<String, dynamic> json) {
    return MusicTab(
      id: json['id'],
      title: json['title'],
      songs: (json['songs'] as List?)
          ?.map((songJson) => Song.fromJson(songJson))
          .toList() ?? [],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MusicTab && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 