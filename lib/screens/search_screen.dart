import 'package:flutter/material.dart';
import 'package:popcornmate_app/api/api.dart';
import 'package:popcornmate_app/api/apidetails.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';
import 'package:popcornmate_app/models/resulttrendingtvshows.dart';
import 'package:popcornmate_app/widgets/section_title.dart';
import 'package:popcornmate_app/widgets/search_result.dart';
import 'package:popcornmate_app/theme/colors.dart';



class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Api api = Api();
  List<ResultTrendingMovies> _movieResults = [];
  List<ResultTrendingTvShows> _tvResults = [];
  bool _isLoading = true;
  //Control the selected tab
  bool _isMoviesSelected = true; 

  //Search keyword to search
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _loadSearchResults();
  }

  //Load the search result list
  Future<void> _loadSearchResults() async {
    //Start the loading
    setState(() {
      _isLoading = true;
    });

    //Checkig if the user is searching for Movies or TV
    if (_isMoviesSelected) 
    {
      //TODO: Call the API to search for Movies passing the search keyword
      final movies = await api.getTrendingMovies();
      setState(() {
        _movieResults = movies;
      });
    } 
    else 
    {
      //TODO: Call the API to search for TV passing the search keyword
      final tvShows = await api.getTrendingTvShows();
      setState(() {
        _tvResults = tvShows;
      });
    }

    //Stop the loading
    setState(() {
      _isLoading = false;
    });
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
      body: Column(
        children: [
          const SectionTitle(title: 'What are you looking for?'),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: TextField(
              onSubmitted: (value) {
                setState(() {
                  _searchKeyword = value;
                });
                _loadSearchResults();
              },
              decoration: InputDecoration(
                hintText: 'Actors, movies, genres, directors...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Radio button to select if Movies or TV Shows
              // Movies
              Radio<bool>(
                value: true,
                groupValue: _isMoviesSelected,
                onChanged: (value) {
                  setState(() {
                    _isMoviesSelected = value!;
                  });
                  // Reload the search results when the radio button is clicked
                  _loadSearchResults();
                },
              ),
              const Text('Movies'),
              // TV Shows
              Radio<bool>(
                value: false,
                groupValue: _isMoviesSelected,
                onChanged: (value) {
                  setState(() {
                    _isMoviesSelected = value!;
                  });
                  _loadSearchResults();
                },
              ),
              const Text('TV Shows'),
            ],
          ),
          //Loading screen or the result list
          _isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: SearchResultList(
                    results: _isMoviesSelected ? _movieResults : _tvResults,
                    isMoviesSelected: _isMoviesSelected,
                  ),
                ),
        ],
      ),
    );
  }
}
