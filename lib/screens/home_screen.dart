import 'package:flutter/material.dart';
import 'package:popcornmate_app/widgets/carousel_large.dart';
import 'package:popcornmate_app/widgets/section_title.dart';
import 'package:popcornmate_app/theme/colors.dart';
import 'package:popcornmate_app/api/api.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';
import 'package:popcornmate_app/models/resulttrendingtvshows.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Api api = Api();
  List<ResultTrendingMovies> _trendingMovies = [];
  List<ResultTrendingTvShows> _trendingTvShows = []; 
  bool _isLoading = true;
  bool _mounted = true; // Add mounted tracker to avoid calling setState on unmounted widget

  @override
  void initState() {
    super.initState();
    _loadTrendingContent();
  }

  @override
  void dispose() {
    _mounted = false; 
    super.dispose();
  }

  Future<void> _loadTrendingContent() async {
    try {
      final movies = await api.getTrendingMovies();
      final tvShows = await api.getTrendingTvShows();
      if (_mounted) { 
        setState(() {
          _trendingMovies = movies;
          _trendingTvShows = tvShows;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (_mounted) { 
        setState(() {
          _isLoading = false;
        });
      }
    }
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
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SectionTitle(title: 'Trending Movies'),
                  SizedBox(
                      height: 300,
                      child: CarouselLarge(items: _trendingMovies)),
                  const SectionTitle(title: 'Trending TV Shows'),
                  SizedBox(
                      height: 300,
                      child: CarouselLarge(items: _trendingTvShows)),
                ],
              ),
            ),
    );
  }
}
