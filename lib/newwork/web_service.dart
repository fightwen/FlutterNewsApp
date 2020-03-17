


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_news_app/home/data/tab_page_generater.dart';
import 'package:flutter_news_app/news/data/NewsItem.dart';

class Webservice {

//  Future<NewsItem> fetchMovies(String keyword) async {
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
  Future<NewsItem> getNewsItemList(BuildContext context,String qkey) async {
    bool isLocalTest = true;
    if(isLocalTest){
      return getNewsItemListFile(context,qkey);
    }
    return getNewsItemListFile(context,qkey);
  }

  // Parses newsItems.json File
  Future<NewsItem> getNewsItemListFile(BuildContext context,String qkey) async {
    String loadString = mappingLoadingNewsJson(qkey);

    if(loadString == null || loadString.isEmpty){
      return null;
    }

    String jsonString = await DefaultAssetBundle.of(context).loadString(loadString);
    Map<String,dynamic> jsonData = jsonDecode(jsonString);

    NewsItem newsItems = NewsItem.fromJson(jsonData);
    return newsItems;
  }

  String mappingLoadingNewsJson(String qkey){

    String loadString = "";
    switch(qkey){
      case KEY_TOP:
        loadString = "assets/texts/newItems.json";
        break;
      case KEY_BUSINESS:
        loadString = "assets/texts/newItemsBusiness.json";
        break;
      case KEY_ENTERTAINMENT:
        loadString = "assets/texts/newItemsEntertainment.json";
        break;
      case KEY_HEALTH:
        loadString = "assets/texts/newItemsHealth.json";
        break;
      case KEY_SCIENCE:
        loadString = "assets/texts/newItemsScience.json";
        break;
      case KEY_SPORTS:
        loadString = "assets/texts/newItemsSports.json";
        break;
      case KEY_TECHNOLOGY:
        loadString = "assets/texts/newItemsTechnology.json";
        break;
    }
    return loadString;
  }
}