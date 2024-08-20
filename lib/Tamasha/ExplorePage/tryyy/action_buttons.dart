import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class ActionButtons extends StatelessWidget {
  final bool isLiked;
  final String likes;
  const ActionButtons({
    super.key,
    required this.isLiked,
    required this.likes,
  });

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
              likes,
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
