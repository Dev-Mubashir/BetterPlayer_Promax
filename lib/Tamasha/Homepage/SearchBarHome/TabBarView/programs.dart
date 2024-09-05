import 'package:flutter/material.dart';

class ProgramsPage extends StatelessWidget {
  final List<Map<String, dynamic>> results;
  final Widget Function(Map<String, dynamic> item) buildGridItem;

  const ProgramsPage({
    Key? key,
    required this.results,
    required this.buildGridItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7, // Adjust as needed for custom height
        ),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final item = results[index];
          return buildGridItem(item);
        },
      ),
    );
  }
}

// Example usage for rectangular thumbnails:
Widget buildGridItem(Map<String, dynamic> item) {
  return ClipRRect(
    // borderRadius: BorderRadius.circular(8.0), // Slightly rounded corners
    child: Container(
      height: 150, // Custom height
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              item['image']), // Use the correct key for the image URL
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
