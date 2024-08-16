import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
