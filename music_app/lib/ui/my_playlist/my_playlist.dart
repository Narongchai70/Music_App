import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/data/repositories/playlist_static_data_repository.dart';
import 'package:music_app/data/providers/tracks_providers.dart';
import 'package:music_app/data/repositories/playlist_repository.dart';
import 'package:music_app/ui/my_playlist/controller/playlist_controller.dart';
import 'package:music_app/ui/custom_playlist/controller/custom_playlist_controller.dart';
import 'package:music_app/ui/my_playlist/widget/mini_player.dart';
import 'package:music_app/ui/my_playlist/widget/playlist_static_item.dart';
import 'package:music_app/ui/my_playlist/widget/custom_playlist_item.dart';

class MyPlaylist extends StatelessWidget {
  MyPlaylist({super.key});

  final controller = Get.put(
    PlaylistController(
      repository: PlaylistRepository(provider: PlaylistStaticDataRepository()),
      trackProvider: TrackProvider(),
    ),
  );

  final customController = Get.put(CustomPlaylistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Playlist",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 80),
            children: [
              ...controller.playlists.map(
                (playlist) => PlaylistStaticItem(playlist: playlist),
              ),

              if (customController.customPlaylists.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "MyplayList",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                ),
                ...customController.customPlaylists.map(
                  (playlist) => CustomPlaylistItem(playlist: playlist),
                ),
              ],
            ],
          );
        }),
      ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
