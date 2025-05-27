import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_app/data/models/custom_playlist.dart';
import 'package:music_app/data/models/tracks_model.dart';

class CustomPlaylistController extends GetxController {
  final _box = GetStorage();
  final _storageKey = 'my_custom_playlists';

  var customPlaylists = <CustomPlaylist>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPlaylists();
  }

  void loadPlaylists() {
    final data = _box.read<List>(_storageKey);
    if (data != null) {
      customPlaylists.value =
          data
              .map((e) => CustomPlaylist.fromJson(Map<String, dynamic>.from(e)))
              .toList();
    }
  }

  void savePlaylists() {
    _box.write(_storageKey, customPlaylists.map((e) => e.toJson()).toList());
  }

  void addPlaylist(String name) {
    final newPlaylist = CustomPlaylist(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      tracks: [],
      isCustom: true,
    );
    customPlaylists.add(newPlaylist);
    savePlaylists();
  }

  void deletePlaylist(String playlistId) {
    customPlaylists.removeWhere((p) => p.id == playlistId);
    savePlaylists();
  }

  void addTrackToPlaylist(String playlistId, TrackModel track) {
    final index = customPlaylists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      final exists = customPlaylists[index].tracks.any((t) => t.id == track.id);
      if (!exists) {
        customPlaylists[index].tracks.add(track);
        savePlaylists();
        customPlaylists.refresh();
      }
    }
  }

  void removeTrackFromPlaylist(String playlistId, String trackId) {
    final index = customPlaylists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      customPlaylists[index].tracks.removeWhere((t) => t.id == trackId);
      savePlaylists();
      customPlaylists.refresh();
    }
  }

  CustomPlaylist? getPlaylistById(String id) {
    return customPlaylists.firstWhereOrNull((p) => p.id == id);
  }
}
