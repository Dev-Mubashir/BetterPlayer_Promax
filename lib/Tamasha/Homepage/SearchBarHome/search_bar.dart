import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tamasha_bp/Tamasha/Homepage/SearchBarHome/TabBarView/all.dart';
import 'package:tamasha_bp/Tamasha/Homepage/SearchBarHome/TabBarView/channels.dart';
import 'package:tamasha_bp/Tamasha/Homepage/SearchBarHome/TabBarView/episodes.dart';
import 'package:tamasha_bp/Tamasha/Homepage/SearchBarHome/TabBarView/programs.dart';
import 'package:tamasha_bp/Tamasha/Homepage/SearchBarHome/get_reels_data.dart';

class MovieSearchBar extends StatefulWidget {
  const MovieSearchBar({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<MovieSearchBar> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> allResults = [];
  List<Map<String, dynamic>> channelResults = [];
  List<Map<String, dynamic>> programResults = [];
  List<Map<String, dynamic>> vodResults = [];

  void _searchAndCategorize(String query) async {
    if (query.length < 3) return;

    List<Map<String, dynamic>> results = await fetchDataAndDecrypt(query);

    // Filter out inaccessible thumbnails and handle null values properly
    List<Map<String, dynamic>> accessibleResults = (await Future.wait(
      results.map((item) async {
        if (item != null && await _isThumbnailAccessible(item['image'])) {
          return item;
        }
        return null;
      }).toList(),
    ))
        .whereType<Map<String, dynamic>>()
        .toList();

    setState(() {
      allResults = accessibleResults;
      channelResults =
          accessibleResults.where((item) => item['type'] == 'channel').toList();
      programResults =
          accessibleResults.where((item) => item['type'] == 'program').toList();
      vodResults =
          accessibleResults.where((item) => item['type'] == 'vod').toList();
    });
  }

  Future<bool> _isThumbnailAccessible(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode != 403;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 250,
              child: TextField(
                controller: _controller,
                onChanged: _searchAndCategorize,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(99, 255, 255, 255)),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              onPressed: () {
                _controller.clear();
                setState(() {
                  allResults = [];
                  channelResults = [];
                  programResults = [];
                  vodResults = [];
                });
              },
              icon: const Icon(Icons.close, size: 20),
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Channels'),
                Tab(text: 'Programs'),
                Tab(text: 'Episodes'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AllPage(
                    channelResults: channelResults,
                    programResults: programResults,
                    vodResults: vodResults,
                    buildGridItem: (item, type) => _buildGridItem(item, type),
                  ),
                  ChannelsPage(
                    results: channelResults,
                    buildGridItem: _buildChannelGridItem,
                  ),
                  ProgramsPage(
                    results: programResults,
                    buildGridItem: _buildProgramGridItem,
                  ),
                  EpisodesPage(
                    results: vodResults,
                    buildListItem: (item) => ListTile(
                      leading: Image.network(
                        item['image'],
                        // scale: 1,
                      ),
                      title: Text(item['name']),
                      subtitle: Text(item['type']),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Circular thumbnails for channels
  Widget _buildChannelGridItem(Map<String, dynamic> item) {
    return ClipOval(
      child: Image.network(
        item['image'],
        fit: BoxFit.cover,
      ),
    );
  }

  // Rectangular thumbnails with custom height for programs
  Widget _buildProgramGridItem(Map<String, dynamic> item) {
    return ClipRRect(
      // borderRadius: BorderRadius.circular(8.0), // Slightly rounded corners
      child: Container(
        height: 150, // Custom height
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(item['image']),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Generic grid item builder based on the type (all, channels, programs)
  Widget _buildGridItem(Map<String, dynamic> item, String type) {
    if (type == 'channel') {
      return _buildChannelGridItem(item);
    } else if (type == 'program') {
      return _buildProgramGridItem(item);
    } else {
      return _buildProgramGridItem(item); // Default to program style for 'all'
    }
  }
}
