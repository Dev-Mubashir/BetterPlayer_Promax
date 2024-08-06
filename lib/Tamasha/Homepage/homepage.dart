// import 'package:betterplayer/Tamasha/Homepage/tamasha_videoplayer.dart';
// import 'package:betterplayer/Tamasha/Homepage/carousal.dart';
// import 'package:betterplayer/utils/colors.dart';
// import 'package:betterplayer/Tamasha/Homepage/json_conversion.dart';
// import 'package:betterplayer/Tamasha/Homepage/thumbnails.dart';
// import 'package:flutter/material.dart';

// class TamashaHomePage extends StatefulWidget {
//   const TamashaHomePage({super.key});

//   @override
//   _MyTamashaHomePageState createState() => _MyTamashaHomePageState();
// }

// class _MyTamashaHomePageState extends State<TamashaHomePage> {
//   void _navigateToDetailPage() {
//     // Navigate to your new page here
//     // You can pass the imageUrl as an argument if needed
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => const TamashaVideoPlayer(
//                 title: 'Tamasha Video Player',
//               )),
//     );
//   }

//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(kbgcolor),
//       appBar: AppBar(
//         backgroundColor: Color(kbgcolor),
//         title: const Center(
//           child: Text(
//             "Tamasha",
//             style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
//           ),
//         ),
//       ),
//       body: ListView(
//         children: [
//           GestureDetector(
//               onTap: () => _navigateToDetailPage(), child: CarouselExample()),
//           FutureBuilder<List<dynamic>>(
//             future: loadmovies(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return MovieList(movies: snapshot.data!);
//               } else if (snapshot.hasError) {
//                 print(snapshot.error);
//                 return const Text('Error loading movies');
//               } else {
//                 return const CircularProgressIndicator();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
