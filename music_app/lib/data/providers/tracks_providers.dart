import 'package:dio/dio.dart';
import 'package:music_app/data/models/key_jamendo.dart';
import 'package:music_app/data/models/tracks_model.dart';

class TrackProvider {
  final Dio _dio = Dio();

  Future<List<TrackModel>> fetchTracksByTag(String tag) async {
    final apiKey = await KeyJamendo.getKey();

    if (apiKey == null) {
      throw Exception('Jamendo API key not found');
    }

    final url =
        'https://api.jamendo.com/v3.0/tracks/?client_id=$apiKey&tags=$tag&format=json&limit=200';

    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      final List data = response.data['results'];
      return data.map((json) => TrackModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tracks from tag: $tag');
    }
  }
}
