class Song {
  final String id;
  final String title;
  final String filePath;
  final Duration? duration;
  final String? artist;

  Song({
    required this.id,
    required this.title,
    required this.filePath,
    this.duration,
    this.artist,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'filePath': filePath,
      'duration': duration?.inMilliseconds,
      'artist': artist,
    };
  }

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      filePath: json['filePath'],
      duration: json['duration'] != null 
          ? Duration(milliseconds: json['duration']) 
          : null,
      artist: json['artist'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Song && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 