import 'package:flutter/material.dart';
import 'package:popcornmate_app/theme/colors.dart';
import 'package:popcornmate_app/services/database_helper.dart';
import 'package:popcornmate_app/screens/tv_show_details_screen.dart';
import 'package:popcornmate_app/screens/movie_details_screen.dart';
import 'package:popcornmate_app/api/api.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key, required this.title});

  final String title;

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Map<String, dynamic>>> _loadFavorites(String type) async {
    return await _dbHelper.getFavorites(type);
  }

  Future<void> _loadAndNavigateToMovieDetails(int movieId) async {
    try {
      final api = Api(); 
      final movieDetails = await api.getMovieDetails(movieId);
      
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailsScreen(
            movie: ResultTrendingMovies(
              adult: movieDetails.adult,
              backdropPath: movieDetails.backdropPath,
              genreIds: movieDetails.genres.map((g) => g.id).toList(),
              id: movieDetails.id,
              originalLanguage: movieDetails.originalLanguage,
              originalTitle: movieDetails.originalTitle,
              overview: movieDetails.overview,
              popularity: movieDetails.popularity,
              posterPath: movieDetails.posterPath,
              releaseDate: movieDetails.releaseDate,
              title: movieDetails.title,
              video: movieDetails.video,
              voteAverage: movieDetails.voteAverage,
              voteCount: movieDetails.voteCount,
            ),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading movie details')),
      );
    }
  }

  Widget _buildFavoritesList(String type) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _loadFavorites(type),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = snapshot.data!;
        if (items.isEmpty) {
          return Center(
            child: Text('No favorite ${type}s yet'),
          );
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item['posterPath'],
                    width: 50,
                    height: 75,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.no_photography,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
                title: Text(item['title']),
                subtitle: Text(item['year']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await _dbHelper.removeFavorite(item['itemId']);
                    setState(() {});
                  },
                ),
                onTap: () {
                  if (type == 'tv') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TvShowDetailsScreen(
                          id: item['itemId'].toString(),
                          title: item['title'],
                          description: '', 
                          imageUrl: item['posterPath'],
                          year: item['year'],
                        ),
                      ),
                    );
                  } else {
                    // For movies, we need to fetch the movie details first
                    _loadAndNavigateToMovieDetails(item['itemId']);
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

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
          _buildFavoritesList('movie'),
          _buildFavoritesList('tv'),
        ],
      ),
    );
  }
}