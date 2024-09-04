import 'package:flutter/material.dart';

class AllPage extends StatelessWidget {
  final List<Map<String, dynamic>> channelResults;
  final List<Map<String, dynamic>> programResults;
  final List<Map<String, dynamic>> vodResults;
  final Widget Function(Map<String, dynamic> item, String type) buildGridItem;

  const AllPage({
    Key? key,
    required this.channelResults,
    required this.programResults,
    required this.vodResults,
    required this.buildGridItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Channels'),
          _buildChannelGridSection(channelResults),
          _buildSectionTitle('Programs'),
          _buildProgramGridSection(programResults),
          _buildSectionTitle('Episodes'),
          _buildEpisodeListSection(vodResults),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Channels section
  Widget _buildChannelGridSection(List<Map<String, dynamic>> results) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1, // Adjust as needed
        ),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final item = results[index];
          return buildGridItem(item, 'channel');
        },
      ),
    );
  }

  // Programs section with rectangular thumbnails and custom height
  Widget _buildProgramGridSection(List<Map<String, dynamic>> results) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio:
              0.7, // Adjust the aspect ratio for rectangular items
        ),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final item = results[index];
          return buildGridItem(item, 'program');
        },
      ),
    );
  }

  // Episodes section with list view style
  Widget _buildEpisodeListSection(List<Map<String, dynamic>> results) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final item = results[index];
          return Row(children: [
            Image.network(
              item['image'],
              fit: BoxFit.cover,
              height: 60, // Custom height
              width: 120, // Custom width
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(item['type']),
                ],
              ),
            ),
          ]);
          // return ListTile(
          //   leading: Image.network(
          //     item['image'],
          //     fit: BoxFit.cover,
          //     height: 60, // Custom height
          //     width: 120, // Custom width
          //   ),
          //   title: Text(
          //     item['name'],
          //     style: const TextStyle(fontSize: 14),
          //   ),
          //   subtitle: Text(item['type']),
          // );
        },
      ),
    );
  }
}
