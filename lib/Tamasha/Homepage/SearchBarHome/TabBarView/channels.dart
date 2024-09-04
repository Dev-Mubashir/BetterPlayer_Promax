import 'package:flutter/material.dart';

class ChannelsPage extends StatelessWidget {
  final List<Map<String, dynamic>> results;
  final Widget Function(Map<String, dynamic> item) buildGridItem;

  const ChannelsPage({
    Key? key,
    required this.results,
    required this.buildGridItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
          childAspectRatio: 1,
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

// Example usage for circular thumbnails:
Widget buildGridItem(Map<String, dynamic> item) {
  return ClipOval(
    child: Image.network(
      item['image'], // Use the correct key for the image URL
      fit: BoxFit.cover,
    ),
  );
}
