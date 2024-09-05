import 'package:flutter/material.dart';

class EpisodesPage extends StatelessWidget {
  final List<Map<String, dynamic>> results;
  final Widget Function(Map<String, dynamic> item) buildListItem;

  const EpisodesPage({
    Key? key,
    required this.results,
    required this.buildListItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return buildListItem(item);
      },
    );
  }
}
