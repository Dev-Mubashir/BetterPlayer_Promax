// import 'package:flutter/material.dart';
// import 'package:tamasha_bp/Tamasha/ExplorePage/tryy/video_stack.dart';
// import 'package:tamasha_bp/Tamasha/ExplorePage/utils/videos_list.dart';
// import 'package:whitecodel_reels/whitecodel_reels.dart';

// // ignore: must_be_immutable
// class Reeels extends StatelessWidget {
//   Reeels({super.key});

//   bool isLiked = false;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'WhiteCodel Reeels',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//               child: WhiteCodelReels(
//                 key: UniqueKey(),
//                 context: context,
//                 loader: const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 isCaching: true,
//                 videoList:
//                     videos.take(3).toList(), // Load only 3 videos at a time
//                 builder: (context, index, child, videoPlayerController,
//                     pageController) {
//                   // Set the video controller to load only the first 3 seconds
//                   if (videoPlayerController.value.duration.inSeconds > 6) {
//                     // videoPlayerController.setLooping(false);
//                     // videoPlayerController.setVolume(0);
//                     videoPlayerController.play();
//                     // videoPlayerController.seekTo(Duration.zero);
//                   }

//                   // Listen for when the page is fully visible to start loading the full video
//                   pageController.addListener(() {
//                     if (pageController.page?.round() == index) {
//                       // Load the full video once the user starts watching it
//                       if (!videoPlayerController.value.isInitialized) {
//                         videoPlayerController.initialize().then((_) {
//                           videoPlayerController.setVolume(1);
//                           videoPlayerController.play();
//                         });
//                       }
//                     }
//                   });

//                   return VideoStack(
//                     index: index,
//                     videoPlayerController: videoPlayerController,
//                     isLiked: isLiked,
//                     child: child,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
