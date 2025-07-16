import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đang phát',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<MusicProvider>(
        builder: (context, musicProvider, child) {
          final currentSong = musicProvider.currentSong;
          
          if (currentSong == null) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.music_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Không có bài hát nào đang phát',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue[700]!,
                  Colors.blue[900]!,
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Spacer(),
                    
                    // Song info
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.music_note,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Song title
                    Text(
                      currentSong.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    if (currentSong.artist != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        currentSong.artist!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    
                    const Spacer(),
                    
                    // Progress bar
                    Column(
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.white,
                            inactiveTrackColor: Colors.white.withOpacity(0.3),
                            thumbColor: Colors.white,
                            overlayColor: Colors.white.withOpacity(0.2),
                            trackHeight: 4,
                          ),
                          child: Slider(
                            value: musicProvider.totalDuration.inMilliseconds > 0
                                ? musicProvider.currentPosition.inMilliseconds / 
                                  musicProvider.totalDuration.inMilliseconds
                                : 0.0,
                            onChanged: (value) {
                              final position = Duration(
                                milliseconds: (value * musicProvider.totalDuration.inMilliseconds).round(),
                              );
                              musicProvider.seek(position);
                            },
                          ),
                        ),
                        
                        // Time labels
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(musicProvider.currentPosition),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                _formatDuration(musicProvider.totalDuration - musicProvider.currentPosition),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Control buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Previous button (placeholder)
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // TODO: Implement previous song
                            },
                            icon: const Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        
                        // Play/Pause button
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: musicProvider.pauseResume,
                            icon: Icon(
                              musicProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.blue[700],
                              size: 40,
                            ),
                          ),
                        ),
                        
                        // Next button (placeholder)
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // TODO: Implement next song
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Volume control
                    Row(
                      children: [
                        Icon(
                          Icons.volume_down,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Colors.white.withOpacity(0.3),
                              thumbColor: Colors.white,
                              overlayColor: Colors.white.withOpacity(0.2),
                              trackHeight: 3,
                            ),
                            child: Slider(
                              value: musicProvider.volume,
                              onChanged: (value) {
                                musicProvider.setVolume(value);
                              },
                            ),
                          ),
                        ),
                        Icon(
                          Icons.volume_up,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Additional controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            // TODO: Implement repeat
                          },
                          icon: Icon(
                            Icons.repeat,
                            color: Colors.white.withOpacity(0.8),
                            size: 28,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // TODO: Implement shuffle
                          },
                          icon: Icon(
                            Icons.shuffle,
                            color: Colors.white.withOpacity(0.8),
                            size: 28,
                          ),
                        ),
                        IconButton(
                          onPressed: musicProvider.stop,
                          icon: Icon(
                            Icons.stop,
                            color: Colors.white.withOpacity(0.8),
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
} 