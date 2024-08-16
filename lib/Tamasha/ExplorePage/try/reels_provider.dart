// import 'package:flutter/foundation.dart';
// import 'getReelsData.dart';

// class ReelsProvider with ChangeNotifier {
//   List<dynamic> _videos = [];
//   bool _isLoading = false;
//   int _currentPage = 0;
//   final int _pageSize = 10;
//   final int _preloadCount = 5;

//   List<dynamic> get videos => _videos;
//   bool get isLoading => _isLoading;

//   Future<void> fetchMoreVideos() async {
//     if (_isLoading) return;
//     _isLoading = true;
//     notifyListeners();

//     final newVideos = await fetchDataAndDecrypt();
//     _videos.addAll(newVideos);
//     _isLoading = false;
//     _currentPage++;
//     notifyListeners();
//   }
// }
