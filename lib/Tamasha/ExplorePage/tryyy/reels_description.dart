// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoDescription extends StatelessWidget {
  final String title; // Add title field
  final String description;
  final bool isReadMore;
  final VoidCallback onReadMore;

  const VideoDescription({
    super.key,
    required this.title,
    required this.description,
    required this.isReadMore,
    required this.onReadMore,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: onReadMore,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 70, left: 18),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  constraints: isReadMore
                      ? null // No constraints if expanded
                      : const BoxConstraints(
                          maxHeight: 50), // Show limited lines when collapsed
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 70, left: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          description,
                          maxLines: isReadMore
                              ? null
                              : 2, // Set max lines based on isReadMore
                          overflow: isReadMore
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        );
      },
    );
  }
}
