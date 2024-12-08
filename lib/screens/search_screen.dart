import 'package:flutter/material.dart';
import 'package:popcornmate_app/api/api.dart';
import 'package:popcornmate_app/models/moviesearch.dart';
import 'package:popcornmate_app/models/tvsearch.dart';
import 'package:popcornmate_app/widgets/section_title.dart';
import 'package:popcornmate_app/widgets/search_result.dart';
import 'package:popcornmate_app/theme/colors.dart';

// Made by Fernando Souza

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  final Api api = Api();
  late TabController _tabController;
  List<ResultMovieSearch> _movieResults = [];
  List<ResultTVSearch> _tvResults = [];
  bool _isLoading = false;
  String _searchKeyword = '';
  String? _msgNoResults = '';

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

  Future<void> _loadSearchResults() async {
    if (_searchKeyword.isEmpty) return;

    setState(() {
      _isLoading = true;
      _msgNoResults = null;
    });

    final isMovieTab = _tabController.index == 0;

    final results = isMovieTab
        ? await api.getMovieSearch(_searchKeyword)
        : await api.getTVSearch(_searchKeyword);

    if (!mounted) return; // Verifica se o widget ainda está ativo

    setState(() {
      if (results != null) {
        if (isMovieTab) {
          _movieResults = results.cast<ResultMovieSearch>();
        } else {
          _tvResults = results.cast<ResultTVSearch>();
        }
      } else {
        _msgNoResults = 'No results found.';
      }
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
        bottom: TabBar(
          controller: _tabController,
          onTap: (_) => _loadSearchResults(),
          tabs: const [
            Tab(icon: Icon(Icons.movie), text: 'Movies'),
            Tab(icon: Icon(Icons.tv), text: 'TV Shows'),
          ],
        ),
      ),
      body: Column(
        children: [
          // const SectionTitle(title: 'What are you looking for?'),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: TextField(
              onSubmitted: (value) {
                setState(() {
                  _searchKeyword = value;
                });
                _loadSearchResults();
              },
              decoration: InputDecoration(
                hintText: 'What are you looking for?',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _msgNoResults != null
                    ? Center(
                        child: Text(
                          _msgNoResults!,
                          style: const TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      )
                    : TabBarView(
                        controller: _tabController,
                        children: [
                          SearchResultList(results: _movieResults, isMoviesSelected: true),
                          SearchResultList(results: _tvResults, isMoviesSelected: false),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
