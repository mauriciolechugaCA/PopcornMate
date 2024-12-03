import 'package:popcornmate_app/models/moviedetails.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';
import 'package:popcornmate_app/models/resulttrendingtvshows.dart';
import 'package:popcornmate_app/models/tvdetails.dart';
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


}