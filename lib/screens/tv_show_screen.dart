import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:popcornmate_app/api/api.dart';
import 'package:popcornmate_app/models/resulttrendingtvshows.dart';
import 'package:popcornmate_app/screens/tv_show_details_screen.dart';
import 'package:popcornmate_app/theme/colors.dart';

class TvShowScreen extends StatelessWidget {
  final String title;

  const TvShowScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final api = Api(); // Instance of the API class to fetch data

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(  // This enables scrolling for the entire screen
        child: Column(
          children: [
            // Popular TV Shows Carousel
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Popular',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            FutureBuilder<List<ResultTrendingTvShows>>(
              future: api.getTrendingTvShows(), // Placeholder for "Popular"
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final tvShows = snapshot.data ?? [];
                if (tvShows.isEmpty) {
                  return const Center(child: Text("No shows available."));
                }

                return CarouselSlider.builder(
                  itemCount: tvShows.length,
                  itemBuilder: (context, index, realIndex) {
                    final tvShow = tvShows[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TvShowDetailsScreen(
                              id: tvShow.id.toString(),
                              title: tvShow.name,
                              description: tvShow.overview,
                              imageUrl: 'https://image.tmdb.org/t/p/w500${tvShow.backdropPath}',
                              year: tvShow.firstAirDate?.year.toString() ?? 'Unknown',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFFFAC41),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${tvShow.backdropPath}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 180,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 50),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                tvShow.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 250,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    viewportFraction: 0.4,
                  ),
                );
              },
            ),

            // Top Rated TV Shows Carousel
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Top Rated',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            FutureBuilder<List<ResultTrendingTvShows>>(
              future: api.getTrendingTvShows(), // Placeholder for "Top Rated"
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final tvShows = snapshot.data ?? [];
                if (tvShows.isEmpty) {
                  return const Center(child: Text("No shows available."));
                }

                return CarouselSlider.builder(
                  itemCount: tvShows.length,
                  itemBuilder: (context, index, realIndex) {
                    final tvShow = tvShows[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TvShowDetailsScreen(
                              id: tvShow.id.toString(),
                              title: tvShow.name,
                              description: tvShow.overview,
                              imageUrl: 'https://image.tmdb.org/t/p/w500${tvShow.backdropPath}',
                              year: tvShow.firstAirDate?.year.toString() ?? 'Unknown',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFFFAC41),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${tvShow.backdropPath}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 180,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 50),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                tvShow.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 250,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    viewportFraction: 0.4,
                  ),
                );
              },
            ),

            // Upcoming TV Shows Carousel
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Upcoming',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            FutureBuilder<List<ResultTrendingTvShows>>(
              future: api.getTrendingTvShows(), // Placeholder for "Upcoming"
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final tvShows = snapshot.data ?? [];
                if (tvShows.isEmpty) {
                  return const Center(child: Text("No shows available."));
                }

                return CarouselSlider.builder(
                  itemCount: tvShows.length,
                  itemBuilder: (context, index, realIndex) {
                    final tvShow = tvShows[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TvShowDetailsScreen(
                              id: tvShow.id.toString(),
                              title: tvShow.name,
                              description: tvShow.overview,
                              imageUrl: 'https://image.tmdb.org/t/p/w500${tvShow.backdropPath}',
                              year: tvShow.firstAirDate?.year.toString() ?? 'Unknown',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFFFAC41),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${tvShow.backdropPath}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 180,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 50),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                                                tvShow.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 250,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    viewportFraction: 0.4,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}