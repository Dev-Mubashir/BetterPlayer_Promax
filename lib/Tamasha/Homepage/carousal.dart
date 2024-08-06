// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class CarouselWithIndicator extends StatefulWidget {
//   final List<String> imgList;

//   const CarouselWithIndicator({super.key, required this.imgList});

//   @override
//   State<CarouselWithIndicator> createState() => _CarouselWithIndicatorState();
// }

// class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
//   int _current = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider(
//           items: widget.imgList.map((item) {
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               child: Image.network(
//                 item,
//                 fit: BoxFit.cover,
//                 width:
//                     double.infinity, // Ensure the image covers the full width
//               ),
//             );
//           }).toList(),
//           options: CarouselOptions(
//             autoPlay: true,
//             enlargeCenterPage: false,
//             aspectRatio:
//                 16 / 9, // Adjust this if you want a different aspect ratio
//             viewportFraction: 1.0, // Make sure each item takes the full width
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _current = index;
//               });
//             },
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: widget.imgList.map((url) {
//             int index = widget.imgList.indexOf(url);
//             return Container(
//               width: 8.0,
//               height: 8.0,
//               margin:
//                   const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: _current == index
//                     ? Color.fromARGB(228, 149, 147, 147)
//                     : const Color.fromRGBO(0, 0, 0, 0.4),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }

// class CarouselExample extends StatelessWidget {
//   final List<String> imgList = [
//     'https://wallpapercave.com/wp/wp8525542.jpg',
//     'https://www.breakingasia.com/wp-content/uploads/IPMAN-3-BANNER.jpg',
//     'https://c4.wallpaperflare.com/wallpaper/182/1016/914/movies-007-skyfall-daniel-craig-wallpaper-preview.jpg',
//     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiKO85iWMCQ8B7FWGapmb3Jz0l5MvdwkwXNQ&s',
//     'https://1847884116.rsc.cdn77.org/tamil/gallery/movies/kannagi2023/main.jpg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return CarouselWithIndicator(imgList: imgList);
//   }
// }
