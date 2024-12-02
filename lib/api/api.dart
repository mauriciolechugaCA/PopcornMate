import 'package:popcornmate_app/models/resulttrendingmovies.dart';
import 'dart:convert';
import 'apidetails.dart';
import "package:http/http.dart" as http;
import 'package:http/http.dart';


class Api 
{
  //Base URL to get the Trendng Movies list from the API
  static const trendingMoviesUrl = 'https://api.themoviedb.org/3/trending/movie/week?api_key=${ApiDetails.apiKey}';





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


  



}