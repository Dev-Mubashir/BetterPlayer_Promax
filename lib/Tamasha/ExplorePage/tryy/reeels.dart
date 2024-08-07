import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/tryy/videoStack.dart';
import 'package:tamasha_bp/Tamasha/ExplorePage/utils/videosList.dart';
import 'package:whitecodel_reels/whitecodel_reels.dart';

// ignore: must_be_immutable
class Reeels extends StatelessWidget {
  Reeels({super.key});

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhiteCodel Reeels',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: WhiteCodelReels(
                key: UniqueKey(),
                context: context,
                loader: const Center(
                  child: CircularProgressIndicator(),
                ),
                isCaching: false,
                videoList:
                    List.generate(videos.length, (index) => videos[index]),
                builder: (context, index, child, videoPlayerController,
                    pageController) {
                  return VideoStack(
                    index: index,
                    child: child,
                    videoPlayerController: videoPlayerController,
                    isLiked: isLiked,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final bool isLiked;

  const ActionButtons({Key? key, required this.isLiked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
              color: Colors.white,
            ),
            Text(
              '6.0K',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            Transform.rotate(
              angle: -math.pi / 4,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
