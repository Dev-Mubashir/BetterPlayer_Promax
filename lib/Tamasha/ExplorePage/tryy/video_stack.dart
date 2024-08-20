// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:tamasha_bp/Tamasha/ExplorePage/tryyy/action_buttons.dart';
// import 'package:tamasha_bp/Tamasha/ExplorePage/tryyy/reels_description.dart';
// import 'package:tamasha_bp/Tamasha/ExplorePage/tryy/reels_progress_bar.dart';
// import 'package:video_player/video_player.dart';

// class VideoStack extends StatefulWidget {
//   final int index;
//   final Widget child;
//   final VideoPlayerController videoPlayerController;
//   final bool isLiked;

//   const VideoStack({
//     super.key,
//     required this.index,
//     required this.child,
//     required this.videoPlayerController,
//     required this.isLiked,
//   });

//   @override
//   VideoStackState createState() => VideoStackState();
// }

// class VideoStackState extends State<VideoStack> {
//   bool isReadMore = false;
//   late StreamController<double> videoProgressController;

//   @override
//   void initState() {
//     super.initState();
//     videoProgressController = StreamController<double>();
//     widget.videoPlayerController.addListener(_onVideoProgress);

//     // Start playing the video but only up to 3 seconds
//     if (widget.videoPlayerController.value.duration.inSeconds > 3) {
//       widget.videoPlayerController.setLooping(false);
//       widget.videoPlayerController.setVolume(0);
//       widget.videoPlayerController.play();
//     }
//   }

//   void _onVideoProgress() {
//     final position = widget.videoPlayerController.value.position.inMilliseconds;
//     final duration = widget.videoPlayerController.value.duration.inMilliseconds;

//     if (duration > 0) {
//       final progress = position / duration;
//       videoProgressController.add(progress);

//       // Pause the video after 3 seconds
//       if (widget.videoPlayerController.value.position.inSeconds >= 3) {
//         widget.videoPlayerController.pause();
//       }
//     }
//   }

//   @override
//   void dispose() {
//     widget.videoPlayerController.removeListener(_onVideoProgress);
//     videoProgressController.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         widget.child,
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: VideoDescription(
//             isReadMore: isReadMore,
//             onReadMore: () {
//               setState(() {
//                 isReadMore = !isReadMore;
//               });
//             },
//           ),
//         ),
//         Positioned(
//           bottom: 0,
//           right: 10,
//           child: ActionButtons(
//             isLiked: widget.isLiked,
//           ),
//         ),
//         VideoProgressBar(
//           videoProgressController: videoProgressController,
//           videoPlayerController: widget.videoPlayerController,
//         ),
//       ],
//     );
//   }
// }
