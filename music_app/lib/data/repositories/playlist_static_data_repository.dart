import 'package:music_app/data/models/playlist_static_data.dart';
import 'package:music_app/data/models/playlist_model.dart';

class PlaylistStaticDataRepository {
  Future<List<PlaylistModel>> fetchPlaylists() async {
    return staticPlaylists;
  }
}
