import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryyy/reels_progress_bar.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryyy/action_buttons.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryyy/reels_description.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryyy/video_player_widget.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryyy/video_provider.dart';

class Reeeels extends StatelessWidget {
  const Reeeels({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return Scaffold(
      body: SafeArea(
        child: Consumer<VideoProvider>(
          builder: (context, videoProvider, child) {
            final videos = videoProvider.videos;
            if (videos.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return PageView.builder(
                controller: pageController,
                scrollDirection: Axis.vertical,
                itemCount: videos.length,
                onPageChanged: (index) {
                  videoProvider.checkToLoadMore(index);
                  videoProvider.playController(index);
                  if (index > 0) {
                    videoProvider
                        .pauseController(index - 1); // Pause the previous video
                  }
                  if (index < videos.length - 1) {
                    videoProvider.pauseController(
                        index + 1); // Pause the next video in case it's playing
                  }
                },
                itemBuilder: (context, index) {
                  final controller = videoProvider.getController(index);

                  if (controller == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // StreamController to manage the video progress
                  final StreamController<double> videoProgressController =
                      StreamController<double>();

                  // Listen to the video progress and add to stream
                  controller.addListener(() {
                    final progress = controller.value.position.inMilliseconds /
                        controller.value.duration.inMilliseconds;
                    videoProgressController.add(progress);
                  });

                  controller.addListener(() {
                    if (controller.value.position ==
                        controller.value.duration) {
                      controller.seekTo(Duration.zero); // Go back to the start
                      controller.play(); // Replay the video
                    }
                  });

                  final videoData = videoProvider.videos[index];
                  final String likes = videoData['likes'] != null
                      ? videoData['likes'].toString()
                      : '0';

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
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: ActionButtons(
                            isLiked: false,
                            likes: likes,
                            // isPlaying: controller.value.isPlaying,
                            // onPlayPausePressed: () {
                            //   if (controller.value.isPlaying) {
                            //     controller.pause();
                            //   } else {
                            //     controller.play();
                            //   }
                            // },
                          ),
                        ),
                        Positioned(
                          bottom: 10, // Adjust as needed for spacing
                          left: 10,
                          right: 10,
                          child: VideoProgressBar(
                            videoProgressController: videoProgressController,
                            videoPlayerController: controller,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: VideoDescription(
                            title: videoData['title'] ??
                                'Unknown Title', // Passing title
                            description: videoData['description'] ??
                                'No Description Available', // Passing description
                            isReadMore: true,
                            onReadMore: () {
                              videoProvider.toggleReadMore(index);
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
