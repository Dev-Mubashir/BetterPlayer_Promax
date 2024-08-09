import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/utils/getReelsData.dart';
import 'package:video_player/video_player.dart';

class VideoProvider extends ChangeNotifier {
  List<String> _videoUrls = [];
  int _currentMax = 10;

  List<String> get videoUrls => _videoUrls;

  Future<void> loadInitialVideos() async {
    final initialData = await fetchDataAndDecrypt();
    _videoUrls =
        initialData.map((video) => video['url'] as String).take(10).toList();
    await _preloadVideos(_videoUrls);
    notifyListeners();
  }

  Future<void> loadMoreVideos() async {
    final newData = await fetchDataAndDecrypt();
    final newVideoUrls =
        newData.map((video) => video['url'] as String).take(10).toList();
    _videoUrls.addAll(newVideoUrls);
    _currentMax = _videoUrls.length;
    await _preloadVideos(newVideoUrls);
    notifyListeners();
  }

  Future<void> _preloadVideos(List<String> urls) async {
    for (String url in urls) {
      final controller = VideoPlayerController.network(url);
      try {
        await controller.initialize();
        controller.setVolume(0.0); // Mute during preloading
        controller.play();
        await Future.delayed(Duration(seconds: 5)); // Play for 5 seconds
      } catch (e) {
        print('Error preloading video from $url: $e');
      } finally {
        controller.pause(); // Pause after preloading
        controller.dispose(); // Dispose to free resources
      }
    }
  }

  void checkToLoadMore(int index) {
    if (index == _currentMax - 5) {
      loadMoreVideos();
    }
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
                return VideoPlayerWidget(url: videoUrls[index]);
              },
            );
          }
        },
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  VideoPlayerWidget({required this.url});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
