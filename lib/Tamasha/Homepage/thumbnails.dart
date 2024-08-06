// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tamasha_bp/Tamasha/Homepage/specific_genre_movies.dart';
// import 'package:tamasha_bp/utils/colors.dart';
// // import 'genre_movie_list_page.dart'; // Import the newly created page

// Widget buildGenreRow(
//   BuildContext context,
//   String genre,
//   List<dynamic> movies,
// ) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Padding(
//         padding: const EdgeInsets.only(left: 16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               genre,
//               style: GoogleFonts.openSans(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Color(kwhitecolor),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Navigate to full list of movies for this genre
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => GenreMovieListPage(
//                       genre: genre,
//                       movies: movies
//                           .where((movie) =>
//                               movie['genres'] != null &&
//                               movie['genres'].isNotEmpty &&
//                               movie['genres'].first == genre)
//                           .toList(),
//                     ),
//                   ),
//                 );
//               },
//               child: Text(
//                 'View more',
//                 style: GoogleFonts.openSans(
//                   fontSize: 12,
//                   fontWeight: FontWeight.normal,
//                   color: Color(kwhitecolor),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       Container(
//         height: 150,
//         padding: const EdgeInsets.symmetric(horizontal: 6.0),
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: movies.length > 10 ? 10 : movies.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(4.0),
//                 child: Image.network(movies[index]['thumbnail']),
//               ),
//             );
//           },
//         ),
//       ),
//     ],
//   );
// }

// class MovieList extends StatelessWidget {
//   final List<dynamic> movies;

//   MovieList({Key? key, required this.movies}) : super(key: key);

//   final genres = [
//     'Horror',
//     'Action',
//     'Comedy',
//     'Drama',
//     'Crime',
//     'Mystery',
//     'Adventure'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         for (final genre in genres)
//           buildGenreRow(
//             context,
//             genre,
//             movies
//                 .where((movie) =>
//                     movie['genres'] != null &&
//                     movie['genres'].isNotEmpty &&
//                     movie['genres'].first == genre)
//                 .toList(),
//           ),
//       ],
//     );
//   }
// }
