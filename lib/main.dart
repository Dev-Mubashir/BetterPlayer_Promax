import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryyy/reeeels.dart';
import 'package:tamasha_bp/bottom_navbar.dart';
import 'package:tamasha_bp/utils/colors.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => VideoProvider()..loadInitialVideos(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
            color: Color(kbgcolor),
          )),
      home: const BottomNavBar(),
    );
  }
}
