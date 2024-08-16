import 'package:flutter/material.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/utils/get_reels_data.dart';
import 'package:video_player/video_player.dart';

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
