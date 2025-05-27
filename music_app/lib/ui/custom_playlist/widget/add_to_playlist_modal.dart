import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/data/models/tracks_model.dart';
import 'package:music_app/ui/custom_playlist/controller/custom_playlist_controller.dart';

import 'package:music_app/widget/snackbar_custom.dart';

void showAddToPlaylistModal(BuildContext context, TrackModel track) {
  final playlistController = Get.find<CustomPlaylistController>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const Text(
                "Add to Playlist",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Obx(
                () =>
                    playlistController.customPlaylists.isEmpty
                        ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: Text("No playlists yet")),
                        )
                        : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (_, __) => const Divider(),
                          itemCount: playlistController.customPlaylists.length,
                          itemBuilder: (_, index) {
                            final playlist =
                                playlistController.customPlaylists[index];
                            return ListTile(
                              leading: const Icon(Icons.queue_music),
                              title: Text(playlist.name),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onTap: () {
                                playlistController.addTrackToPlaylist(
                                  playlist.id,
                                  track,
                                );
                                Navigator.pop(context);
                                SnackbarCustom.show(
                                  title: "Song added",
                                  message: "Added to ${playlist.name}",
                                );
                              },
                            );
                          },
                        ),
              ),
              const Divider(height: 32),
              ListTile(
                leading: const Icon(Icons.playlist_add),
                title: const Text("New Playlist"),
                onTap: () {
                  Navigator.pop(context);
                  _showCreatePlaylistModal(context, track);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showCreatePlaylistModal(BuildContext context, TrackModel track) {
  final playlistController = Get.find<CustomPlaylistController>();
  final textController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Create New Playlist",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: "Playlist name",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Create and Add Song"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final name = textController.text.trim();
                    if (name.isNotEmpty) {
                      playlistController.addPlaylist(name);
                      final newPlaylist =
                          playlistController.customPlaylists.last;
                      playlistController.addTrackToPlaylist(
                        newPlaylist.id,
                        track,
                      );
                      Navigator.pop(context);
                      SnackbarCustom.show(
                        title: "Playlist created",
                        message: "Added music to $name",
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
