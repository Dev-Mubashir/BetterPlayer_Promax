import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoProgressBar extends StatelessWidget {
  final StreamController<double> videoProgressController;
  final VideoPlayerController videoPlayerController;

  const VideoProgressBar({
    super.key,
    required this.videoProgressController,
    required this.videoPlayerController,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: videoProgressController.stream,
      builder: (context, snapshot) {
        return SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbShape: SliderComponentShape.noThumb,
            overlayShape: SliderComponentShape.noOverlay,
            trackHeight: 5,
          ),
          child: Slider(
            value: (snapshot.data ?? 0).clamp(0.0, 1.0),
            min: 0.0,
            max: 1.0,
            activeColor: Colors.red,
            inactiveColor: Colors.white,
            onChanged: (value) {
              final position =
                  videoPlayerController.value.duration.inMilliseconds * value;
              videoPlayerController
                  .seekTo(Duration(milliseconds: position.toInt()));
            },
          ),
        );
      },
    );
  }
}
