// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:tamasha_bp/bottom_navbar.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   SplashScreenState createState() => SplashScreenState();
// }

// class SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Adding 3 seconds of delay
//     Timer(const Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const BottomNavBar()));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Center(
//           child: SizedBox(
//             width: 120,
//             height: 120,
//             child: Image.asset("assets/tamasha_logo.jpg"),
//           ),
//         ),
//       ),
//     );
//   }
// }
