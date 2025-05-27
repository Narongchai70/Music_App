import 'package:get/get.dart';
import 'package:music_app/controller/player_controller.dart';
import 'package:music_app/ui/custom_playlist/controller/custom_playlist_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PlayerController(), permanent: true);
    Get.put(CustomPlaylistController());
  }
}
