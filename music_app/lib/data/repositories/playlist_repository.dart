import 'package:music_app/data/models/playlist_model.dart';
import 'package:music_app/data/repositories/playlist_static_data_repository.dart';

class PlaylistRepository {
  final PlaylistStaticDataRepository provider;
  PlaylistRepository({required this.provider});

  Future<List<PlaylistModel>> fetchPlaylists() async {
    return await provider.fetchPlaylists();
  }
}
