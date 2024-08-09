import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/utils/getReelsData.dart';
import 'package:video_player/video_player.dart';

class VideoProvider extends ChangeNotifier {
  List<String> _videoUrls = [];
  Map<int, VideoPlayerController> _controllers = {};
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

      final controller = VideoPlayerController.network(_videoUrls[i])
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

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }
}

class Reeeels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<VideoProvider>(
        builder: (context, videoProvider, child) {
          final videoUrls = videoProvider.videoUrls;
          if (videoUrls.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: videoUrls.length,
              onPageChanged: videoProvider.checkToLoadMore,
              itemBuilder: (context, index) {
                final controller = videoProvider.getController(index);
                return controller != null
                    ? VideoPlayerWidget(controller: controller)
                    : Center(child: CircularProgressIndicator());
              },
            );
          }
        },
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController controller;

  VideoPlayerWidget({required this.controller});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.play();
  }

  @override
  void dispose() {
    widget.controller.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: widget.controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: widget.controller.value.aspectRatio,
              child: VideoPlayer(widget.controller),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
