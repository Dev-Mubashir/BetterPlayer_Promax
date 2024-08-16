import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class TamashaVideoPlayer extends StatefulWidget {
  const TamashaVideoPlayer({
    super.key,
    required this.title,
    required this.videoUrl,
    required this.isLive,
  });
  final String title;
  final String videoUrl;
  final bool isLive;

  @override
  State<TamashaVideoPlayer> createState() => _TamashaVideoPlayerState();
}

class _TamashaVideoPlayerState extends State<TamashaVideoPlayer> {
  late BetterPlayerController _betterPlayerController;
  final GlobalKey _betterPlayerKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    BetterPlayerBufferingConfiguration bufferingConfiguration =
        const BetterPlayerBufferingConfiguration(
      minBufferMs: 30000,
      maxBufferMs: 60000,
      bufferForPlaybackMs: 5000,
      bufferForPlaybackAfterRebufferMs: 10000,
    );

    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoUrl,
      liveStream: widget.isLive,
      useAsmsSubtitles: false,
      bufferingConfiguration: bufferingConfiguration,
    );

    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      autoPlay: true,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        overflowMenuIcon: Icons.settings,
        enableSubtitles: false,
        enableAudioTracks: false,
        enablePlaybackSpeed: false,
        enablePip: true,
        pipMenuIcon: Icons.picture_in_picture,
      ),
    );

    _betterPlayerController = BetterPlayerController(
      betterPlayerConfiguration,
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  void _enterPiPMode() async {
    bool isSupported =
        await _betterPlayerController.isPictureInPictureSupported();
    if (isSupported) {
      _betterPlayerController.enablePictureInPicture(_betterPlayerKey);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Picture-in-Picture mode is not supported on this device."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_in_picture),
            onPressed: _enterPiPMode,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: BetterPlayer(
                  controller: _betterPlayerController,
                  key: _betterPlayerKey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }
}
