import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:popcornmate_app/widgets/carousel_movies.dart';
import 'package:popcornmate_app/widgets/carousel_large_movies.dart';
import 'package:popcornmate_app/widgets/section_title.dart';
import 'package:popcornmate_app/theme/colors.dart';
import 'package:popcornmate_app/screens/movie_details_screen.dart';
import 'package:popcornmate_app/models/movie.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  // Parte temporária para alimentar os dados fictícios
  void _fetchMovies() {
    _movies = [
      Movie(
        id: 1,
        title: 'Popular Movie 1',
        imageUrl: 'https://via.placeholder.com/150', // URL de imagem fixa para teste
        releaseDate: '2024-12-01',
        overview: 'Overview: This is an overview of Popular Movie 1.',
        popularity: 85.0,
        duration: '120 min', 
      ),
      Movie(
        id: 2,
        title: 'Popular Movie 2',
        imageUrl: 'https://via.placeholder.com/150', // URL de imagem fixa para teste
        releaseDate: '2023-11-11',
        overview: 'Overview: This is an overview of Popular Movie 2.',
        popularity: 78.5,
        duration: '110 min',
      ),
      Movie(
        id: 3,
        title: 'Popular Movie 3',
        imageUrl: 'https://via.placeholder.com/150', // URL de imagem fixa para teste
        releaseDate: '2022-10-21',
        overview: 'Overview: This is an overview of Popular Movie 3.',
        popularity: 70.0,
        duration: '130 min',
      ),
      Movie(
        id: 4,
        title: 'Popular Movie 4',
        imageUrl: 'https://via.placeholder.com/150', // URL de imagem fixa para teste
        releaseDate: '2021-09-01',
        overview: 'Overview: This is an overview of Popular Movie 4.',
        popularity: 65.0,
        duration: '100 min',
      ),
      Movie(
        id: 5,
        title: 'Popular Movie 5',
        imageUrl: 'https://via.placeholder.com/150', // URL de imagem fixa para teste
        releaseDate: '2020-08-31',
        overview: 'Overview: This is an overview of Popular Movie 5.',
        popularity: 60.0,
        duration: '90 min',
      ),
    ];
  }

  /*
  // Código comentado para integrar com a API
  Future<void> _fetchMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=YOUR_API_KEY&language=en-US&page=1'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      setState(() {
        _movies = results.map((json) => Movie.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }
  */

  void _navigateToMovieDetails(BuildContext context, Movie movie) {
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
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.text,
        elevation: 0,
        title: const Text(
          'Movies',
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _movies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
            ),
    );
  }
}
