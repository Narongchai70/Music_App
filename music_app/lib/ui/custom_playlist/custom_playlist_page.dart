import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/data/models/custom_playlist.dart';
import 'package:music_app/data/models/tracks_model.dart';
import 'package:music_app/ui/custom_playlist/controller/custom_playlist_controller.dart';
import 'package:music_app/ui/custom_playlist/widget/add_to_playlist_modal.dart';
import 'package:music_app/ui/tracklist/widger/now_playing_bar.dart';
import 'package:music_app/ui/tracklist/widger/playlist_tabs.dart';
import 'package:music_app/widget/snackbar_custom.dart';

class CustomPlaylistPage extends StatefulWidget {
  final CustomPlaylist playlist;

  const CustomPlaylistPage({super.key, required this.playlist});

  @override
  State<CustomPlaylistPage> createState() => _CustomPlaylistPageState();
}

class _CustomPlaylistPageState extends State<CustomPlaylistPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomPlaylistController>();

    return Obx(() {
      final playlist = controller.customPlaylists.firstWhereOrNull(
        (p) => p.id == widget.playlist.id,
      );

      if (playlist == null) {
        return Scaffold(
          appBar: AppBar(title: const Text("Playlist")),
          body: const Center(child: Text("Playlist not found")),
        );
      }

      final tracks = playlist.tracks;

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            playlist.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(170),
            child: NowPlayingBar(tabController: _tabController),
          ),
        ),
        body: Obx(() {
          if (isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (tracks.isEmpty) {
            return const Center(
              child: Text("There are no songs in this playlist."),
            );
          }

          return PlaylistTabs(
            tracks: tracks,
            tabController: _tabController,
            onMoreTap: (track) => _showTrackOptions(context, track),
          );
        }),
      );
    });
  }

  void _showTrackOptions(BuildContext context, TrackModel track) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.playlist_add),
              title: const Text("Add to another playlist"),
              onTap: () {
                Navigator.pop(context);
                showAddToPlaylistModal(context, track);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Remove from this playlist"),
              onTap: () {
                Navigator.pop(context);
                final controller = Get.find<CustomPlaylistController>();
                controller.removeTrackFromPlaylist(
                  widget.playlist.id,
                  track.id,
                );
                SnackbarCustom.show(
                  title: "Deleted song",
                  message: "Deleted ${track.name} from ${widget.playlist.name}",
                );
              },
            ),
          ],
        );
      },
    );
  }
}
