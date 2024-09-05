// import 'package:flutter/material.dart';
// import 'package:tamasha_bp/Tamasha/ExplorePage/utils/get_reels_data.dart';
// import 'package:video_player/video_player.dart';

// class VideoProvider extends ChangeNotifier {
//   // List<String> _videoUrls = [];
//   List<Map<String, String>> _videos = [];
//   final Map<int, VideoPlayerController> _controllers = {};
//   int _currentMax = 10;
//   int _currentIndex = 0;

//   final Map<int, bool> _isDescriptionExpanded = {};

//   // List<String> get videoUrls => _videoUrls;
//   List<Map<String, String>> get videos => _videos;
//   final Map<int, double> _visibilityMap = {};

//   // Future<void> loadInitialVideos() async {
//   //   final initialData = await fetchDataAndDecrypt();
//   //   _videoUrls =
//   //       initialData.map((video) => video['url'] as String).take(10).toList();
//   //   _preloadControllers();
//   //   notifyListeners();
//   // }

//   Future<void> loadInitialVideos() async {
//     final initialData = await fetchDataAndDecrypt();
//     _videos = initialData
//         .map((video) {
//           return {
//             'url': video['url'] as String,
//             'title': video['title'] as String, // Add title
//             'description': video['description'] as String, // Add description
//             'likes': video['likes'].toString(),
//           };
//         })
//         .take(10)
//         .toList();
//     _preloadControllers();
//     notifyListeners();
//   }

//   void updateVisibility(int index, double visibleFraction) {
//     _visibilityMap[index] = visibleFraction;
//     notifyListeners();
//   }

//   double getVisibility(int index) {
//     return _visibilityMap[index] ?? 0.0;
//   }

//   // Future<void> loadMoreVideos() async {
//   //   final newData = await fetchDataAndDecrypt();
//   //   _videoUrls.addAll(newData.map((video) => video['url'] as String).take(10));
//   //   _currentMax = _videoUrls.length;
//   //   _preloadControllers();
//   //   notifyListeners();
//   // }

//   Future<void> loadMoreVideos() async {
//     final newData = await fetchDataAndDecrypt();
//     _videos.addAll(newData.map((video) {
//       return {
//         'url': video['url'] as String,
//         'title': video['title'] as String,
//         'description': video['description'] as String,
//         'likes': video['likes'].toString()
//       };
//     }).take(10));
//     _currentMax = _videos.length;
//     _preloadControllers();
//     notifyListeners();
//   }

//   void checkToLoadMore(int index) {
//     _currentIndex = index;
//     if (index == _currentMax - 5) {
//       loadMoreVideos();
//     }
//     _preloadControllers();
//     _disposeUnusedControllers();
//   }

//   void _preloadControllers() {
//     final startIndex = (_currentIndex - 2).clamp(0, _videos.length - 1);
//     final endIndex = (_currentIndex + 3).clamp(0, _videos.length - 1);

//     for (int i = startIndex; i <= endIndex; i++) {
//       if (_controllers.containsKey(i)) continue;

//       final videoUrl = _videos[i]['url'];

//       if (videoUrl != null) {
//         final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
//           ..initialize().then((_) {
//             notifyListeners();
//           });
//         _controllers[i] = controller;
//       }
//     }
//   }

//   void _disposeUnusedControllers() {
//     final keysToRemove = _controllers.keys
//         .where((key) => key < _currentIndex - 2 || key > _currentIndex + 3)
//         .toList();

//     for (final key in keysToRemove) {
//       _controllers[key]?.dispose();
//       _controllers.remove(key);
//     }
//   }

//   VideoPlayerController? getController(int index) {
//     return _controllers[index];
//   }

//   void playController(int index) {
//     final controller = _controllers[index];
//     if (controller != null &&
//         controller.value.isInitialized &&
//         !controller.value.isPlaying) {
//       controller.play();
//     }
//   }

//   void pauseController(int index) {
//     final controller = _controllers[index];
//     if (controller != null &&
//         controller.value.isInitialized &&
//         controller.value.isPlaying) {
//       controller.pause();
//     }
//   }

//   // Method to toggle the expanded/collapsed state of the description
//   void toggleReadMore(int index) {
//     _isDescriptionExpanded[index] = !(_isDescriptionExpanded[index] ?? false);
//     notifyListeners();
//   }

//   // Method to check if the description is expanded
//   bool isDescriptionExpanded(int index) {
//     return _isDescriptionExpanded[index] ?? false;
//   }

//   @override
//   void dispose() {
//     for (var controller in _controllers.values) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
// }
