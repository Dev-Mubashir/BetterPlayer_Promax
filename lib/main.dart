import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
// import 'package:tamasha_bp/Tamasha/ExplorePage/tryyy/reeeels.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryyy/video_provider.dart';
import 'package:tamasha_bp/Tamasha/LoginPage/login.dart';
import 'package:tamasha_bp/bottom_navbar.dart';
// import 'package:tamasha_bp/splash_screen.dart';
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
    return ScreenUtilInit(
        designSize: const Size(390, 884),
        builder: (context, child) {
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
            // home: Login(),
            home: BottomNavBar(),
          );
        });
  }
}
