import 'package:music_app/data/models/tracks_model.dart';

class CustomPlaylist {
  final String id;
  final String name;
  final List<TrackModel> tracks;
  final bool isCustom;

  CustomPlaylist({
    required this.id,
    required this.name,
    required this.tracks,
    this.isCustom = false,
  });
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'isCustom': isCustom,
    'tracks': tracks.map((e) => e.toJson()).toList(),
  };

  factory CustomPlaylist.fromJson(Map<String, dynamic> json) {
    return CustomPlaylist(
      id: json['id'],
      name: json['name'],
      isCustom: json['isCustom'] ?? false,
      tracks:
          (json['tracks'] as List<dynamic>)
              .map((e) => TrackModel.fromJson(Map<String, dynamic>.from(e)))
              .toList(),
    );
  }
}
