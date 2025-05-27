import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/data/models/tracks_model.dart';

class TracklistController extends GetxController {
  static TracklistController get to => Get.find();

  final audioPlayer = AudioPlayer();
  final currentTrack = Rxn<TrackModel>();
  final trackList = <TrackModel>[];
  int currentIndex = 0;
  void playTrackList(List<TrackModel> tracks, int index) {
    trackList.clear();
    trackList.addAll(tracks);
    currentIndex = index;
    _playCurrent();
  }

  void _playCurrent() async {
    final track = trackList[currentIndex];
    currentTrack.value = track;
    await audioPlayer.setUrl(track.audio);
    await audioPlayer.play();
  }

  void playNext() {
    if (currentIndex + 1 < trackList.length) {
      currentIndex++;
      _playCurrent();
    }
  }

  void pause() {
    audioPlayer.pause();
  }

  void resume() {
    audioPlayer.play();
  }
}
