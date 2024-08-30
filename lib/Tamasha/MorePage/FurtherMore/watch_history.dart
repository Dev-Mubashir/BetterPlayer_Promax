import 'package:flutter/material.dart';

class WatchHistory extends StatelessWidget {
  const WatchHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watch History'),
          bottom: const TabBar(
            indicatorColor: Colors.blue, // Color of the underline
            indicatorWeight: 3.0, // Thickness of the underline
            labelColor: Colors.white, // Active tab text color
            unselectedLabelColor: Colors.grey, // Inactive tab text color
            tabs: [
              Tab(text: 'Live TV Channels'),
              Tab(text: 'Movies & Dramas'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LiveTVChannelsTab(),
            MoviesAndDramasTab(),
          ],
        ),
      ),
    );
  }
}

class LiveTVChannelsTab extends StatelessWidget {
  const LiveTVChannelsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Example list of channels; replace with your actual data
    final channels = [
      'Channel 1',
      'Channel 2',
      'Channel 3',
      'Channel 4',
      'Channel 5',
      'Channel 6',
      'Channel 7',
      'Channel 8',
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 avatars per row
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: channels.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            CircleAvatar(
              radius: 25,
              child: Text(
                channels[index][0], // Display first letter of channel name
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              channels[index],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    );
  }
}

class MoviesAndDramasTab extends StatelessWidget {
  const MoviesAndDramasTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Example list of movies and dramas; replace with your actual data
    final items = [
      'Movie 1',
      'Drama 1',
      'Movie 2',
      'Drama 2',
      'Movie 3',
      'Drama 3',
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.movie),
          title: Text(items[index]),
        );
      },
    );
  }
}
