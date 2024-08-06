// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:tamasha_bp/utils/colors.dart';

// class CustomPlaceholder extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: CircularProgressIndicator(
//         valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//       ),
//     );
//   }
// }

// class CustomErrorWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Icon(
//         Icons.error,
//         color: Colors.red,
//         size: 40.0,
//       ),
//     );
//   }
// }

// class GenreMovieListPage extends StatelessWidget {
//   final String genre;
//   final List<dynamic> movies;

//   const GenreMovieListPage(
//       {Key? key, required this.genre, required this.movies})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(kbgcolor),
//       appBar: AppBar(
//         title: Text(genre),
//       ),
//       body: ListView.builder(
//         itemCount:
//             (movies.length / 3).ceil(), // Calculate number of rows needed
//         itemBuilder: (context, rowIndex) {
//           // Create a row with 3 movie thumbnails
//           return Container(
//             height: 200,
//             child: Row(
//               children: List.generate(3, (index) {
//                 final movieIndex = rowIndex * 3 + index;
//                 if (movieIndex < movies.length) {
//                   final movie = movies[movieIndex];
//                   if (movie != null &&
//                       movie['thumbnail'] != null &&
//                       movie['thumbnail'] is String) {
//                     return Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(4.0),
//                           child: CachedNetworkImage(
//                             imageUrl: movie['thumbnail'],
//                             fit: BoxFit.cover,
//                             placeholder: (context, url) =>
//                                 CustomPlaceholder(), // Custom placeholder widget
//                             errorWidget: (context, url, error) =>
//                                 CustomErrorWidget(), // Custom error widget
//                           ),
//                         ),
//                       ),
//                     );
//                   } else {
//                     return SizedBox(); // Return empty space if thumbnail is not available
//                   }
//                 } else {
//                   return SizedBox(); // Return empty space if there are no more movies
//                 }
//               }),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
