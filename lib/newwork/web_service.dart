


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_news_app/news/data/NewsItem.dart';

class Webservice {

//  Future<List<Movie>> fetchMovies(String keyword) async {
//
//    final url = "http://www.omdbapi.com/?s=$keyword&apikey=YOURAPIKEYHERE";
//    final response = await http.get(url);
//    if(response.statusCode == 200) {
//
//      final body = jsonDecode(response.body);
//      final Iterable json = body["Search"];
//      return json.map((movie) => Movie.fromJson(movie)).toList();
//
//    } else {
//      throw Exception("Unable to perform request!");
//    }
//  }

  // Parses newsItems.json File
  Future<NewsItem> getPokemonsList(BuildContext context) async {
    String jsonString = await DefaultAssetBundle.of(context).loadString("assets/texts/newItems.json");
    dynamic jsonData = jsonDecode(jsonString);

    NewsItem newsItems = NewsItem.map(jsonData);
    return newsItems;
  }
}