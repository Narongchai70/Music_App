import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/data/models/tracks_model.dart';
import 'package:music_app/controller/player_controller.dart';
import 'package:music_app/ui/tracklist/widger/track_list_item.dart';

class PlaylistTabs extends StatelessWidget {
  final List<TrackModel> tracks;
  final TabController tabController;
  final void Function(TrackModel track)? onMoreTap;

  const PlaylistTabs({
    super.key,
    required this.tracks,
    required this.tabController,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final player = PlayerController.to;

    return TabBarView(
      controller: tabController,
      children: [
        Obx(() {
          final currentTrack = player.currentTrack.value;

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: tracks.length,
            itemBuilder: (context, index) {
              final track = tracks[index];
              final isPlaying = currentTrack?.id == track.id;

              return TrackListItem(
                track: track,
                isPlaying: isPlaying,
                onTap: () {
                  player.playTrackList(tracks, index);
                },
                onMoreTap: onMoreTap,
              );
            },
          );
        }),

        const Center(
          child: Text('jamendo no lyrics.', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
