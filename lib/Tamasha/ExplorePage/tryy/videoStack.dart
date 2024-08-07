import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryy/reeels.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryy/reelsDescription.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryy/reelsProgressbar.dart';
import 'package:video_player/video_player.dart';

class VideoStack extends StatefulWidget {
  final int index;
  final Widget child;
  final VideoPlayerController videoPlayerController;
  final bool isLiked;

  const VideoStack({
    Key? key,
    required this.index,
    required this.child,
    required this.videoPlayerController,
    required this.isLiked,
  }) : super(key: key);

  @override
  _VideoStackState createState() => _VideoStackState();
}

class _VideoStackState extends State<VideoStack> {
  bool isReadMore = false;
  late StreamController<double> videoProgressController;

  @override
  void initState() {
    super.initState();
    videoProgressController = StreamController<double>();
    widget.videoPlayerController.addListener(() {
      if (!videoProgressController.isClosed) {
        double videoProgress =
            widget.videoPlayerController.value.position.inMilliseconds /
                widget.videoPlayerController.value.duration.inMilliseconds;
        videoProgressController.add(videoProgress);
      }
    });
  }

  @override
  void dispose() {
    videoProgressController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: VideoDescription(
            isReadMore: isReadMore,
            onReadMore: () {
              setState(() {
                isReadMore = !isReadMore;
              });
            },
          ),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: ActionButtons(
            isLiked: widget.isLiked,
          ),
        ),
        VideoProgressBar(
          videoProgressController: videoProgressController,
          videoPlayerController: widget.videoPlayerController,
        ),
      ],
    );
  }
}
