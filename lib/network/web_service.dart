


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_news_app/database/news_database.dart';
import 'package:flutter_news_app/home/data/tab_page_generater.dart';
import 'package:flutter_news_app/news/data/NewsItem.dart';
import 'package:flutter_news_app/news/data/NewsUIItem.dart';
import 'package:flutter_news_app/tool/md5_tool.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Webservice {
  bool isLocalTest = true;
  Client client = Client();

  Future<NewsItem> fetchNews(String qkey) async {

    final url = "https://gitlab.com/fightmz/testinfo/-/raw/master/news_"+qkey+".json";
    final response = await client.get(url);
    if(response.statusCode == 200) {

      final body = jsonDecode(response.body);
      return NewsItem.fromJson(body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  Future<List<NewsArticleUIItem>> getNewsArticleUIItemList(BuildContext context,String qkey) async {
    List<NewsArticleUIItem> list = List<NewsArticleUIItem>();
    var result = await getNewsItemList(context,qkey);
    var dbNewsNameList = await NewsDatabase.newsNames();

    result.articles.forEach((element) {

      list.add(NewsArticleUIItem(title:element.title == null ?"":element.title,
          url:element.url,
          urlToImage:element.urlToImage,
          isAddedBookmark:dbNewsNameList.contains(generateMd5(element.title)),
          articlesFromServer:element));
    });

    return list;
  }

  // Parses newsItems.json File
  Future<NewsItem> getNewsItemList(BuildContext context,String qkey) async {
    if(isLocalTest){
      return getNewsItemListFile(context,qkey);
    }
    return fetchNews(qkey);
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