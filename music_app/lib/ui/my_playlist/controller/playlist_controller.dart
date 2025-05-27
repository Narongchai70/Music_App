import 'package:get/get.dart';
import 'package:music_app/data/models/playlist_model.dart';
import 'package:music_app/data/models/tracks_model.dart';
import 'package:music_app/data/providers/tracks_providers.dart';
import 'package:music_app/data/repositories/playlist_repository.dart';
import 'package:music_app/widget/snackbar_custom.dart';

class PlaylistController extends GetxController {
  final PlaylistRepository repository;
  final TrackProvider trackProvider;

  PlaylistController({required this.repository, required this.trackProvider});

  final playlists = <PlaylistModel>[].obs;
  final tracks = <TrackModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPlaylists();
  }

  void loadPlaylists() async {
    try {
      isLoading.value = true;
      final result = await repository.fetchPlaylists();
      playlists.assignAll(result);
    } catch (e) {
      SnackbarCustom.show(title: 'Error', message: e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  void loadTracksByTag(String tag) async {
    try {
      isLoading.value = true;
      final result = await trackProvider.fetchTracksByTag(tag);
      tracks.assignAll(result);
    } catch (e) {
      SnackbarCustom.show(title: 'Error', message: e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}
