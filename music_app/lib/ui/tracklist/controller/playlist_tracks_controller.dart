import 'package:get/get.dart';
import 'package:music_app/data/models/tracks_model.dart';
import 'package:music_app/data/providers/tracks_providers.dart';
import 'package:music_app/widget/snackbar_custom.dart';

class PlaylistTracksController extends GetxController {
  final String tag;
  PlaylistTracksController(this.tag);

  final tracks = <TrackModel>[].obs;
  final isLoading = true.obs;

  final TrackProvider _provider = TrackProvider();

  @override
  void onInit() {
    super.onInit();
    loadTracksByTag();
  }

  void loadTracksByTag() async {
    try {
      isLoading.value = true;
      final result = await _provider.fetchTracksByTag(tag);
      tracks.assignAll(result);
    } catch (e) {
      SnackbarCustom.show(
        title: "Error PlaylistTracksController",
        message: e.toString(),
        isError: true,
      );
      isLoading.value = false;
    }
  }
}
