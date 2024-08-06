import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/getReelsData.dart'; // Ensure this file is correctly imported

class ReelsPage extends StatefulWidget {
  @override
  _ReelsPageState createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  List<dynamic> videos = [];
  bool isLoading = false;
  int currentPage = 0;
  final int pageSize = 10;
  PageController _pageController = PageController();
  final int preloadCount = 5;

  @override
  void initState() {
    super.initState();
    _fetchMoreVideos();
  }

  Future<void> _fetchMoreVideos() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    final newVideos = await fetchDataAndDecrypt();
    setState(() {
      videos.addAll(newVideos);
      isLoading = false;
      currentPage++;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReelsPage'),
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: videos.length + 1,
        itemBuilder: (context, index) {
          if (index == videos.length) {
            if (!isLoading) _fetchMoreVideos();
            return _buildThumbnailPlaceholder(); // Use placeholder for loading state
          } else {
            _preloadNextVideos(
                index); // Preload videos only within reasonable range
            return _buildVideoItem(videos[index]);
          }
        },
      ),
    );
  }

  Widget _buildThumbnail(dynamic video) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          video['thumbnail'],
          fit: BoxFit.cover,
        ),
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }

  Widget _buildThumbnailPlaceholder() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildVideoItem(dynamic video) {
    return BetterPlayerWidget(videoUrl: video['url']);
  }

  void _preloadNextVideos(int currentIndex) {
    // Only preload videos that are within a reasonable range of the currentIndex
    int preloadStartIndex = currentIndex + 1;
    int preloadEndIndex = preloadStartIndex + preloadCount;

    for (int i = preloadStartIndex;
        i < preloadEndIndex && i < videos.length;
        i++) {
      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        videos[i]['url'],
      );
      BetterPlayerController _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
          autoPlay: false,
          looping: true,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableSkips: false,
            enableMute: false,
            enableProgressText: false,
            showControls: false,
          ),
        ),
        betterPlayerDataSource: betterPlayerDataSource,
      );

      // Use the controller to preload
      _betterPlayerController.setupDataSource(betterPlayerDataSource);
    }
  }
}

class BetterPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const BetterPlayerWidget({required this.videoUrl});

  @override
  _BetterPlayerWidgetState createState() => _BetterPlayerWidgetState();
}

class _BetterPlayerWidgetState extends State<BetterPlayerWidget> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoUrl,
    );
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true,
        looping: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableSkips: false,
          enableMute: false,
          enableProgressText: false,
          showControls: false,
        ),
        aspectRatio: 9 / 16, // Adjust to cover the whole screen
        fit: BoxFit.cover,
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      controller: _betterPlayerController,
    );
  }
}
