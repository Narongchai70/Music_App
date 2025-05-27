import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/player_controller.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});
  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = PlayerController.to;

      final track = controller.currentTrack.value;

      if (track == null) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    track.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, __, ___) => const Icon(Icons.music_note, size: 48),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        track.artistName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                    size: 32,
                  ),
                  onPressed: controller.togglePlayPause,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next, size: 32),
                  onPressed: controller.playNext,
                ),
              ],
            ),

            const SizedBox(height: 8),

            StreamBuilder<Duration>(
              stream: controller.audioPlayer.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final duration =
                    controller.audioPlayer.duration ?? Duration.zero;

                return Column(
                  children: [
                    Slider(
                      min: 0,
                      max: duration.inMilliseconds.toDouble(),
                      value:
                          position.inMilliseconds
                              .clamp(0, duration.inMilliseconds)
                              .toDouble(),
                      onChanged: (value) {
                        controller.audioPlayer.seek(
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
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _formatDuration(duration),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                  ],
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
