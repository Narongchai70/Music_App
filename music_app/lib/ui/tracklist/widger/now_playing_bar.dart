import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/player_controller.dart';

class NowPlayingBar extends StatelessWidget {
  final TabController tabController;

  const NowPlayingBar({super.key, required this.tabController});

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final player = PlayerController.to;

    return Obx(() {
      final currentTrack = player.currentTrack.value;
      if (currentTrack == null) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    currentTrack.image,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.music_note),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentTrack.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        currentTrack.artistName,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    player.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: player.togglePlayPause,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: player.playNext,
                ),
              ],
            ),
          ),
          StreamBuilder<Duration>(
            stream: player.audioPlayer.positionStream,
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              final duration = player.audioPlayer.duration ?? Duration.zero;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Slider(
                      min: 0,
                      max: duration.inMilliseconds.toDouble(),
                      value:
                          position.inMilliseconds
                              .clamp(0, duration.inMilliseconds)
                              .toDouble(),
                      onChanged: (value) {
                        player.audioPlayer.seek(
                          Duration(milliseconds: value.toInt()),
                        );
                      },
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey[300],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(position),
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          _formatDuration(duration),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          TabBar(
            controller: tabController,
            tabs: const [Tab(text: "UP NEXT"), Tab(text: "LYRICS")],
          ),
        ],
      );
    });
  }
}
