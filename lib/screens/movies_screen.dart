import 'package:flutter/material.dart';
import 'package:popcornmate_app/api/api.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';
import 'package:popcornmate_app/widgets/carousel_movies.dart';
import 'package:popcornmate_app/widgets/carousel_large_movies.dart';
import 'package:popcornmate_app/widgets/section_title.dart';
import 'package:popcornmate_app/theme/colors.dart';
import 'package:popcornmate_app/screens/movie_details_screen.dart';

// Defines the movies screen as a stateful widget (dynamic state management).
class MoviesScreen extends StatefulWidget {
  final String title;
  const MoviesScreen({super.key, required this.title});

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  // List to store the movies retrieved from the API.
  List<ResultTrendingMovies> _movies = [];
  // Flag to indicate if data is still loading.
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Calls the method to fetch movies as soon as the widget initializes.
    _fetchMovies();
  }

  // Method to fetch movies from the API.
  Future<void> _fetchMovies() async {
    try {
      Api api = Api(); // Creates an instance of the API class.
      List<ResultTrendingMovies> trendingMovies = await api.getTrendingMovies(); // Fetches the movies.
      setState(() {
        _movies = trendingMovies; // Updates the movies list.
        _isLoading = false; // Indicates loading is complete.
      });
    } catch (e) {
      // Handles errors and stops loading even on failure.
      print('Error fetching movies: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Navigates to the movie details screen when a movie is tapped
  void _navigateToMovieDetails(BuildContext context, ResultTrendingMovies movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary, // Background color
        foregroundColor: AppColors.text, // Text and icon color
        elevation: 0, // Removes shadow from the AppBar
        title: Text(
          widget.title,
          style: const TextStyle(
            color: AppColors.accent,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Centers the title.
      ),
      body: _isLoading
          // Shows a loading indicator while data is not ready
          ? const Center(child: CircularProgressIndicator())
          // Displays a message if no movies are available.
          : _movies.isEmpty
              ? const Center(child: Text('No movies available'))
              // Displays movies in a list with organized sections
              : ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // Section for popular movies
                    const SectionTitle(title: 'Popular'),
                    SizedBox(
                      height: 300,
                      child: CarouselLargeMovies(
                        movies: _movies,
                        onTap: (context, index) {
                          _navigateToMovieDetails(context, _movies[index % _movies.length]);
                        },
                      ),
                    ),
                    // Section for top-rated movies
                    const SectionTitle(title: 'Top-rated'),
                    SizedBox(
                      height: 250,
                      child: CarouselMovies(
                        movies: _movies,
                        onTap: (context, index) {
                          _navigateToMovieDetails(context, _movies[index % _movies.length]);
                        },
                      ),
                    ),
                    // Section for new releases
                    const SectionTitle(title: 'New Releases'),
                    SizedBox(
                      height: 250,
                      child: CarouselMovies(
                        movies: _movies,
                        onTap: (context, index) {
                          _navigateToMovieDetails(context, _movies[index % _movies.length]);
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
