import 'package:popcornmate_app/models/moviedetails.dart';
import 'package:popcornmate_app/models/moviesearch.dart';
import 'package:popcornmate_app/models/movietoprated.dart';
import 'package:popcornmate_app/models/movieupcoming.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';
import 'package:popcornmate_app/models/resulttrendingtvshows.dart';
import 'package:popcornmate_app/models/tvdetails.dart';
import 'package:popcornmate_app/models/tvsearch.dart';
import 'package:popcornmate_app/models/tvtoprated.dart';
import 'package:popcornmate_app/models/tvupcoming.dart';
import 'dart:convert';
import 'apidetails.dart';
import "package:http/http.dart" as http;
import 'package:http/http.dart';


class Api 
{
  //Base URL to get the Trendng Movies list from the API
  static const trendingMoviesUrl = 'https://api.themoviedb.org/3/trending/movie/week?api_key=${ApiDetails.apiKey}';

  //Base URL to get the Trendng TV Shows list from the API
  static const trendingTvShowUrl = 'https://api.themoviedb.org/3/trending/tv/week?api_key=${ApiDetails.apiKey}';

  //Base URL to get the TV Show details from the API
  static const tvDetailsUrl = 'https://api.themoviedb.org/3/tv/';

  //Base URL to get the Movie details from the API
  static const movieDetailsUrl = 'https://api.themoviedb.org/3/movie/';

  //Base URL to get the Movie search list from the API
  static const movieSearchUrl = 'https://api.themoviedb.org/3/search/movie?api_key=${ApiDetails.apiKey}&query=';

  //Base URL to get the TV Show search list from the API
  static const tvSearchUrl = 'https://api.themoviedb.org/3/search/tv?api_key=${ApiDetails.apiKey}&query=';

  //Base URL to get the Top Rated Movies list from the API
  static const topRatedMoviesUrl = 'https://api.themoviedb.org/3/movie/top_rated?api_key=${ApiDetails.apiKey}';

  //Base URL to get the Top Rated TV Shows list from the API
  static const topRatedTvShowsUrl = 'https://api.themoviedb.org/3/tv/top_rated?api_key=${ApiDetails.apiKey}';

  //Base URL to get the Upcoming Movies list from the API
  static const upcomingMoviesUrl = 'https://api.themoviedb.org/3/movie/upcoming?api_key=${ApiDetails.apiKey}';

  //Base URL to get the Upcoming TV Shows list from the API
  static const upcomingTvShowsUrl = 'https://api.themoviedb.org/3/tv/on_the_air?api_key=${ApiDetails.apiKey}';



  //https://api.flutter.dev/flutter/dart-async/Future-class.html
  //Future is an async method. Doesn't provide the result/return immmediately
  Future<List<ResultTrendingMovies>> getTrendingMovies() async {

    //Getting the response from the api/ await http.get
    Response responseFromAPI = await http.get(Uri.parse(trendingMoviesUrl));

    //Checking if the response is OK. 200 is OK
    if (responseFromAPI.statusCode == 200) {
      
      //Decoding the Json
      final data = jsonDecode(responseFromAPI.body);

      //Get the list from the Jspn
      final List<dynamic> results = data["results"];

      //Mapping each item from JSON using the ResultTrending constructor
      //VSCode add some words. Clean line: return results.map((item) => ResultTrending.fromJson(item)).toList();
      return results.map((item) => ResultTrendingMovies.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load trending movies");
    }
  }


  Future<List<ResultTrendingTvShows>> getTrendingTvShows() async 
  {

    //Getting the response from the api/ await http.get
    Response responseFromAPI = await http.get(Uri.parse(trendingTvShowUrl));

    //Checking if the response is OK. 200 is OK
    if (responseFromAPI.statusCode == 200) 
    {
      
      //Decoding the Json
      final data = jsonDecode(responseFromAPI.body);

      //Get the list from the Jspn
      final List<dynamic> results = data["results"];

      //Mapping each item from JSON using the ResultTrending constructor
      //VSCode add some words. Clean line: return results.map((item) => ResultTrending.fromJson(item)).toList();
      return results.map((item) => ResultTrendingTvShows.fromJson(item)).toList();
    } 
    else 
    {
      throw Exception("Failed to load trending tv shows");
    }
  }
  
  //I need to receive the series id to get the details
  Future<TvDetails> getTvDetails(int id) async 
  {
    //Concatenating the URL with the id
    Response responseFromAPI = await http.get(Uri.parse(tvDetailsUrl + id.toString() + '?api_key=${ApiDetails.apiKey}'));

    //Checking if the response is OK. 200 is OK
    if (responseFromAPI.statusCode == 200) 
    {
      
      //Decoding the Json
      final data = jsonDecode(responseFromAPI.body);

      //Get the list from the Jspn
      return TvDetails.fromJson(data);
    } 
    else 
    {
      throw Exception("Failed to load tv details");
    }
  }

  //I need to receive the movie id to get the details
  Future<MovieDetails> getMovieDetails(int id) async 
  {
    //Concatenating the URL with the id
    Response responseFromAPI = await http.get(Uri.parse(movieDetailsUrl + id.toString() + '?api_key=${ApiDetails.apiKey}'));

    //Checking if the response is OK. 200 is OK
    if (responseFromAPI.statusCode == 200) 
    {
      
      //Decoding the Json
      final data = jsonDecode(responseFromAPI.body);

      //Get the list from the Jspn
      return MovieDetails.fromJson(data);
    } 
    else 
    {
      throw Exception("Failed to load movie details");
    }
  }

  //Return the Movie search list. I need to receive the keyword to search
  Future<List<ResultMovieSearch>> getMovieSearch(String keyword) async 
  {
    //Concatenating the URL with the keyword
    Response responseFromAPI = await http.get(Uri.parse(movieSearchUrl + keyword));

    //Checking if the response is OK. 200 is OK
    if (responseFromAPI.statusCode == 200) 
    {
      
      //Decoding the Json
      final data = jsonDecode(responseFromAPI.body);

      //Get the list from the Jspn
      final List<dynamic> results = data["results"];

      //Mapping each item from JSON using the ResultTrending constructor
      //VSCode add some words. Clean line: return results.map((item) => ResultTrending.fromJson(item)).toList();
      return results.map((item) => ResultMovieSearch.fromJson(item)).toList();
    } 
    else 
    {
      throw Exception("Failed to load movie search");
    }
  }

  //Return the TV Show search list. I need to receive the keyword to search
  Future<List<ResultTVSearch>> getTVSearch(String keyword) async 
  {
    //Concatenating the URL with the keyword
    Response responseFromAPI = await http.get(Uri.parse(tvSearchUrl + keyword));

    //Checking if the response is OK. 200 is OK
    if (responseFromAPI.statusCode == 200) 
    {
      
      //Decoding the Json
      final data = jsonDecode(responseFromAPI.body);

      //Get the list from the Jspn
      final List<dynamic> results = data["results"];

      //Mapping each item from JSON using the ResultTrending constructor
      //VSCode add some words. Clean line: return results.map((item) => ResultTrending.fromJson(item)).toList();
      return results.map((item) => ResultTVSearch.fromJson(item)).toList();
    } 
    else 
    {
      throw Exception("Failed to load tv show search");
    }
  }

  //Return the Top Rated Movies list
  Future<List<ResultMovieTopRated>> getTopRatedMovies() async 
  {
    //Getting the response from the api/ await http.get
    Response responseFromAPI = await http.get(Uri.parse(topRatedMoviesUrl));

    //Checking if the response is OK. 200 is OK
    if (responseFromAPI.statusCode == 200) 
    {
      
      //Decoding the Json
      final data = jsonDecode(responseFromAPI.body);

      //Get the list from the Jspn
      final List<dynamic> results = data["results"];

      //Mapping each item from JSON using the ResultTrending constructor
      //VSCode add some words. Clean line: return results.map((item) => ResultTrending.fromJson(item)).toList();
      return results.map((item) => ResultMovieTopRated.fromJson(item)).toList();
    } 
    else 
    {
      throw Exception("Failed to load top rated movies");
    }
  }

  //Return the Top Rated TV Shows list
  Future<List<ResultTvTopRated>> getTopRatedTVShows() async 
  {
    //Getting the response from the api/ await http.get
    Response responseFromAPI = await http.get(Uri.parse(topRatedTvShowsUrl));

    //Checking if the response is OK. 200 is OK
    if (responseFromAPI.statusCode == 200) 
    {
      
      //Decoding the Json
      final data = jsonDecode(responseFromAPI.body);

      //Get the list from the Jspn
      final List<dynamic> results = data["results"];

      //Mapping each item from JSON using the ResultTrending constructor
      //VSCode add some words. Clean line: return results.map((item) => ResultTrending.fromJson(item)).toList();
      return results.map((item) => ResultTvTopRated.fromJson(item)).toList();
    } 
    else 
    {
      throw Exception("Failed to load top rated tv shows");
    }
  }

  //Return the Upcoming Movies list
  Future<List<ResultMovieUpcoming>> getUpcomingMovies() async 
  {
    //Getting the response from the api/ await http.get
    Response responseFromAPI = await http.get(Uri.parse(upcomingMoviesUrl));

    //Checking if the response is OK. 200 is OK
    if (responseFromAPI.statusCode == 200) 
    {
      
      //Decoding the Json
      final data = jsonDecode(responseFromAPI.body);

      //Get the list from the Jspn
      final List<dynamic> results = data["results"];

      //Mapping each item from JSON using the ResultTrending constructor
      //VSCode add some words. Clean line: return results.map((item) => ResultTrending.fromJson(item)).toList();
      return results.map((item) => ResultMovieUpcoming.fromJson(item)).toList();
    } 
    else 
    {
      throw Exception("Failed to load upcoming movies");
    }
  }

  //Return the Upcoming TV Shows list
  Future<List<ResultTvUpcoming>> getUpcomingTVShows() async 
  {
    //Getting the response from the api/ await http.get
    Response responseFromAPI = await http.get(Uri.parse(upcomingTvShowsUrl));

    //Checking if the response is OK. 200 is OK
    if (responseFromAPI.statusCode == 200) 
    {
      
      //Decoding the Json
      final data = jsonDecode(responseFromAPI.body);

      //Get the list from the Jspn
      final List<dynamic> results = data["results"];

      //Mapping each item from JSON using the ResultTrending constructor
      //VSCode add some words. Clean line: return results.map((item) => ResultTrending.fromJson(item)).toList();
      return results.map((item) => ResultTvUpcoming.fromJson(item)).toList();
    } 
    else 
    {
      throw Exception("Failed to load upcoming tv shows");
    }
  }

}