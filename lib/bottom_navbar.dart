import 'package:flutter/material.dart';
// import 'package:tamasha_bp/Tamasha/ExplorePage/try/reels.dart';
// import 'package:tamasha_bp/Tamasha/ExplorePage/tryy/reeels.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryyy/reeeels.dart';
import 'package:tamasha_bp/Tamasha/Homepage/Movies_data/home.dart';
import 'package:tamasha_bp/Tamasha/LiveTvPage/tamasha_livetvplayer.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    // const Home(),
    const Home(),
    const Tamasha_liveTvPlayer(
      title: 'Tamasha LiveTV Player',
    ),
    const Reeeels(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 143, 143, 143),
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        iconSize: 22,
        selectedFontSize: 9,
        unselectedFontSize: 9,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Live TV',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Reels',
          ),
        ],
      ),
    );
  }
}
