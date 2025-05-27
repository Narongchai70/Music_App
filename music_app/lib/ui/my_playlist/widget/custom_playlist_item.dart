import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/player_controller.dart';
import 'package:music_app/data/models/custom_playlist.dart';
import 'package:music_app/ui/custom_playlist/custom_playlist_page.dart';
import 'package:music_app/ui/custom_playlist/controller/custom_playlist_controller.dart';

class CustomPlaylistItem extends StatelessWidget {
  final CustomPlaylist playlist;

  const CustomPlaylistItem({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomPlaylistController>();

    return InkWell(
      onTap: () {
        Get.to(() => CustomPlaylistPage(playlist: playlist));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  playlist.tracks.isNotEmpty
                      ? Image.network(
                        playlist.tracks.first.image,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => const Icon(Icons.music_note),
                      )
                      : const Icon(Icons.music_note, size: 60),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                playlist.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.play_circle_fill, size: 32),
              onPressed: () {
                if (playlist.tracks.isNotEmpty) {
                  PlayerController.to.playTrackList(playlist.tracks, 0);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                Get.defaultDialog(
                  title: "Delete playlist?",
                  middleText:
                      "Are you sure you want to delete? '${playlist.name}'",
                  textCancel: "cancel",
                  textConfirm: "delete",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    controller.deletePlaylist(playlist.id);
                    Get.back();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
