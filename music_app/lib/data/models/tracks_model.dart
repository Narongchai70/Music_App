class TrackModel {
  final String id;
  final String name;
  final int duration;
  final String artistId;
  final String artistName;
  final String albumName;
  final String albumId;
  final String licenseUrl;
  final int position;
  final String releaseDate;
  final String albumImage;
  final String audio;
  final String audioDownload;
  final String shortUrl;
  final String shareUrl;
  final String waveform;
  final String image;
  final bool audioDownloadAllowed;

  TrackModel({
    required this.id,
    required this.name,
    required this.duration,
    required this.artistId,
    required this.artistName,
    required this.albumName,
    required this.albumId,
    required this.licenseUrl,
    required this.position,
    required this.releaseDate,
    required this.albumImage,
    required this.audio,
    required this.audioDownload,
    required this.shortUrl,
    required this.shareUrl,
    required this.waveform,
    required this.image,
    required this.audioDownloadAllowed,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      duration: json['duration'] ?? 0,
      artistId: json['artist_id'] ?? '',
      artistName: json['artist_name'] ?? '',
      albumName: json['album_name'] ?? '',
      albumId: json['album_id'] ?? '',
      licenseUrl: json['license_ccurl'] ?? '',
      position: json['position'] ?? 0,
      releaseDate: json['releasedate'] ?? '',
      albumImage: json['album_image'] ?? '',
      audio: json['audio'] ?? '',
      audioDownload: json['audiodownload'] ?? '',
      shortUrl: json['shorturl'] ?? '',
      shareUrl: json['shareurl'] ?? '',
      waveform: json['waveform'] ?? '',
      image: json['image'] ?? '',
      audioDownloadAllowed: json['audiodownload_allowed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'duration': duration,
    'artist_id': artistId,
    'artist_name': artistName,
    'album_name': albumName,
    'album_id': albumId,
    'license_ccurl': licenseUrl,
    'position': position,
    'releasedate': releaseDate,
    'album_image': albumImage,
    'audio': audio,
    'audiodownload': audioDownload,
    'shorturl': shortUrl,
    'shareurl': shareUrl,
    'waveform': waveform,
    'image': image,
    'audiodownload_allowed': audioDownloadAllowed,
  };
}
