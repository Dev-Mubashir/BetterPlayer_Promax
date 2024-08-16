import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class TamashaLivetvplayer extends StatefulWidget {
  const TamashaLivetvplayer({super.key, required this.title});
  final String title;

  @override
  State<TamashaLivetvplayer> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TamashaLivetvplayer> {
  late BetterPlayerController _betterPlayerController;
  final GlobalKey _betterPlayerKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "https://cdn02khi.tamashaweb.com:8087/jazzauth/ARYdigital-abr/playlist.m3u8",
      liveStream: true,
    );

    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      autoPlay: true,
      autoDetectFullscreenDeviceOrientation: true,
      fullScreenByDefault: false,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        enablePip: true,
        enableAudioTracks: false,
        enablePlaybackSpeed: false,
        enableSubtitles: false,
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
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_in_picture),
            onPressed: _enterPiPMode,
          ),
        ],
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(
              controller: _betterPlayerController,
              key: _betterPlayerKey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
