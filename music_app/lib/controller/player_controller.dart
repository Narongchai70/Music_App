import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/data/models/tracks_model.dart';

class PlayerController extends GetxController {
  static PlayerController get to => Get.find();

  final AudioPlayer audioPlayer = AudioPlayer();
  final RxList<TrackModel> _playlist = <TrackModel>[].obs;
  final RxInt _currentIndex = 0.obs;
  final RxBool isPlaying = false.obs;

  final Rxn<TrackModel> currentTrack = Rxn<TrackModel>();

  void setPlaylist(List<TrackModel> tracks, {int startAt = 0}) {
    audioPlayer.stop();
    _playlist.clear();
    _playlist.assignAll(tracks);
    _currentIndex.value = startAt;
    playCurrent();
  }

  void playTrackList(List<TrackModel> list, int index) {
    setPlaylist(list, startAt: index);
  }

  Future<void> playCurrent() async {
    final track = _playlist.isNotEmpty ? _playlist[_currentIndex.value] : null;
    currentTrack.value = track;

    if (track == null) return;

    try {
      await audioPlayer.setUrl(track.audio);
      await audioPlayer.play();
      isPlaying.value = true;

      audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          playNext();
        }
      });
    } catch (e) {}
  }

  void togglePlayPause() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
      isPlaying.value = false;
    } else {
      audioPlayer.play();
      isPlaying.value = true;
    }
  }

  void playNext() {
    if (_currentIndex.value + 1 < _playlist.length) {
      _currentIndex.value++;
      playCurrent();
    }
  }

  void playPrevious() {
    if (_currentIndex.value > 0) {
      _currentIndex.value--;
      playCurrent();
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
