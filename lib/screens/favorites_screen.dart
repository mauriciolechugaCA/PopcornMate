import 'package:flutter/material.dart';
import 'package:popcornmate_app/theme/colors.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key, required this.title});

  final String title;

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data. Replace with the info from the database
  final List<Map<String, dynamic>> _favoriteMovies = [
    {'title': 'Inception', 'year': 2010, 'poster': 'https://example.com/inception.jpg'},
    {'title': 'The Matrix', 'year': 1999, 'poster': 'https://example.com/matrix.jpg'},
  ];

  final List<Map<String, dynamic>> _favoriteTVShows = [
    {'title': 'Breaking Bad', 'year': 2008, 'poster': 'https://example.com/breakingbad.jpg'},
    {'title': 'Stranger Things', 'year': 2016, 'poster': 'https://example.com/strangerthings.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildFavoritesList(List<Map<String, dynamic>> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: ClipRRect(
              // ClipRRect is used to clip the image to a rounded rectangle. ChatGPT helped me with this. ^ML
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                item['poster'],
                width: 50,
                height: 75,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 50,
                    height: 75,
                    color: Colors.grey[300],
                    child: const Icon(Icons.movie, color: Colors.grey),
                  );
                },
              ),
            ),
            title: Text(
              item['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  items.removeAt(index);
                });
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.text,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: AppColors.accent,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.movie), text: 'Movies'),
            Tab(icon: Icon(Icons.tv), text: 'TV Shows'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFavoritesList(_favoriteMovies),
          _buildFavoritesList(_favoriteTVShows),
        ],
      ),
      // Optional: Empty state handling
      // body: _favoriteMovies.isEmpty && _favoriteTVShows.isEmpty
      //     ? Center(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Icon(Icons.favorite_border, size: 100, color: Colors.grey[300]),
      //             const SizedBox(height: 20),
      //             const Text(
      //               'No favorites yet',
      //               style: TextStyle(fontSize: 18, color: Colors.grey),
      //             ),
      //           ],
      //         ),
      //       )
      //     : TabBarView(
      //         controller: _tabController,
      //         children: [
      //           _buildFavoritesList(_favoriteMovies),
      //           _buildFavoritesList(_favoriteTVShows),
      //         ],
      //       ),
    );
  }
}