import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/data/models/tracks_model.dart';
import 'package:music_app/data/providers/tracks_providers.dart';
import 'package:music_app/ui/custom_playlist/widget/add_to_playlist_modal.dart';
import 'package:music_app/ui/tracklist/widger/now_playing_bar.dart';
import 'package:music_app/ui/tracklist/widger/playlist_tabs.dart';

class PlaylistTracksPage extends StatefulWidget {
  final String tag;
  final String label;

  const PlaylistTracksPage({super.key, required this.tag, required this.label});

  @override
  State<PlaylistTracksPage> createState() => _PlaylistTracksPageState();
}

class _PlaylistTracksPageState extends State<PlaylistTracksPage>
    with SingleTickerProviderStateMixin {
  final TrackProvider _provider = TrackProvider();
  final tracks = <TrackModel>[].obs;
  final isLoading = true.obs;

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadTracks();
  }

  void loadTracks() async {
    try {
      isLoading.value = true;
      final result = await _provider.fetchTracksByTag(widget.tag);
      tracks.assignAll(result);
    } catch (e) {
      debugPrint('Error loading tracks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          widget.label,
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
          return const Center(child: Text("No tracks found."));
        }

        return PlaylistTabs(
          tracks: tracks,
          tabController: _tabController,
          onMoreTap: (track) => showAddToPlaylistModal(context, track),
        );
      }),
    );
  }
}
