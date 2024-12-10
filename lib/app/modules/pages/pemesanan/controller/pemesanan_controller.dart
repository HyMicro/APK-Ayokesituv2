import 'package:ayokesituv2/app/data/models/article_model.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PemesananController extends GetxController {
  late VideoPlayerController videoPlayerController;
  var isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    final tour = Get.arguments as Tour;

    videoPlayerController = VideoPlayerController.asset(
      tour.vid,
    )..initialize().then((_) {
        isInitialized.value = true;
        videoPlayerController.setLooping(true);
        videoPlayerController.play(); // Start playing automatically
      }).catchError((error) {
        print(
            "Video Initialization Error: $error"); // Catch initialization errors
      });

    // Add Listener for Playback Errors
    videoPlayerController.addListener(() {
      final error = videoPlayerController.value.errorDescription;
      if (error != null) {
        print("Playback Error: $error"); // Log playback errors
      }
    });
  }

  void togglePlayPause() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
  }

  @override
  void onClose() {
    // Dispose of the video controller
    videoPlayerController.dispose();
    super.onClose();
  }
}
