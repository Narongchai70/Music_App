import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/player_controller.dart';
import 'package:music_app/data/models/playlist_model.dart';
import 'package:music_app/data/providers/tracks_providers.dart';
import 'package:music_app/ui/tracklist/playlist_tracks_page.dart';
import 'package:music_app/widget/snackbar_custom.dart';

class PlaylistStaticItem extends StatelessWidget {
  final PlaylistModel playlist;

  const PlaylistStaticItem({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => PlaylistTracksPage(tag: playlist.tag, label: playlist.label),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  playlist.imageAsset != null
                      ? Image.asset(
                        playlist.imageAsset!,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playlist.label,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    playlist.tag,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.play_circle_fill, size: 32),
              onPressed: () async {
                final trackProvider = TrackProvider();
                try {
                  final tracks = await trackProvider.fetchTracksByTag(
                    playlist.tag,
                  );
                  if (tracks.isNotEmpty) {
                    PlayerController.to.playTrackList(tracks, 0);
                  }
                } catch (e) {
                  SnackbarCustom.show(
                    title: "Error",
                    message: e.toString(),
                    isError: true,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
