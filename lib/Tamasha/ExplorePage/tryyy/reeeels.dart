import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryy/action_buttons.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryy/reels_description.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryyy/video_player_widget.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/utils/get_reels_data.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoProvider extends ChangeNotifier {
  List<String> _videoUrls = [];
  final Map<int, VideoPlayerController> _controllers = {};
  int _currentMax = 10;
  int _currentIndex = 0;

  List<String> get videoUrls => _videoUrls;

  Future<void> loadInitialVideos() async {
    final initialData = await fetchDataAndDecrypt();
    _videoUrls =
        initialData.map((video) => video['url'] as String).take(10).toList();
    _preloadControllers();
    notifyListeners();
  }

  Future<void> loadMoreVideos() async {
    final newData = await fetchDataAndDecrypt();
    _videoUrls.addAll(newData.map((video) => video['url'] as String).take(10));
    _currentMax = _videoUrls.length;
    _preloadControllers();
    notifyListeners();
  }

  void checkToLoadMore(int index) {
    _currentIndex = index;
    if (index == _currentMax - 5) {
      loadMoreVideos();
    }
    _preloadControllers();
    _disposeUnusedControllers();
  }

  void _preloadControllers() {
    final startIndex = (_currentIndex - 2).clamp(0, _videoUrls.length - 1);
    final endIndex = (_currentIndex + 3).clamp(0, _videoUrls.length - 1);

    for (int i = startIndex; i <= endIndex; i++) {
      if (_controllers.containsKey(i)) continue;

      final controller =
          VideoPlayerController.networkUrl(Uri.parse(_videoUrls[i]))
            ..initialize().then((_) {
              notifyListeners();
            });
      _controllers[i] = controller;
    }
  }

  void _disposeUnusedControllers() {
    final keysToRemove = _controllers.keys
        .where((key) => key < _currentIndex - 2 || key > _currentIndex + 3)
        .toList();

    for (final key in keysToRemove) {
      _controllers[key]?.dispose();
      _controllers.remove(key);
    }
  }

  VideoPlayerController? getController(int index) {
    return _controllers[index];
  }

  void playController(int index) {
    final controller = _controllers[index];
    if (controller != null &&
        controller.value.isInitialized &&
        !controller.value.isPlaying) {
      controller.play();
    }
  }

  void pauseController(int index) {
    final controller = _controllers[index];
    if (controller != null &&
        controller.value.isInitialized &&
        controller.value.isPlaying) {
      controller.pause();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

class Reeeels extends StatelessWidget {
  const Reeeels({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return Scaffold(
      body: SafeArea(
        child: Consumer<VideoProvider>(
          builder: (context, videoProvider, child) {
            final videoUrls = videoProvider.videoUrls;
            if (videoUrls.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return PageView.builder(
                controller: pageController,
                scrollDirection: Axis.vertical,
                itemCount: videoUrls.length,
                onPageChanged: (index) {
                  videoProvider.checkToLoadMore(index);
                  videoProvider.playController(index);
                  if (index > 0) {
                    videoProvider
                        .pauseController(index - 1); // Pause the previous video
                  }
                  if (index < videoUrls.length - 1) {
                    videoProvider.pauseController(
                        index + 1); // Pause the next video in case it's playing
                  }
                },
                itemBuilder: (context, index) {
                  final controller = videoProvider.getController(index);

                  if (controller == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return VisibilityDetector(
                    key: Key("video-$index"),
                    onVisibilityChanged: (visibilityInfo) {
                      if (visibilityInfo.visibleFraction == 1) {
                        videoProvider.playController(
                            index); // Play the video when fully visible
                      } else {
                        videoProvider.pauseController(
                            index); // Pause when partially out of view
                      }
                    },
                    child: Stack(
                      children: [
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            top: 0,
                            child: VideoPlayerWidget(controller: controller)),
                        const Positioned(
                          bottom: 0,
                          right: 0,
                          child: ActionButtons(isLiked: false),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: VideoDescription(
                            isReadMore: false,
                            onReadMore: () {
                              // Logic to handle read more
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
