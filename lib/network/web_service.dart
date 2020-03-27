


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_news_app/database/news_database.dart';
import 'package:flutter_news_app/home/data/tab_page_generater.dart';
import 'package:flutter_news_app/news/data/news_item.dart';
import 'package:flutter_news_app/news/data/news_ui_item.dart';
import 'package:flutter_news_app/search/search_result_page.dart';
import 'package:flutter_news_app/tool/md5_tool.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class WebService {
  bool isLocalTest = true;
  Client client = Client();

  // Parses newsItems.json File
  Future<NewsItem> getSearchNewsItemList(BuildContext context,String qkey,String lang) async {
    if(isLocalTest){
      return getSearchBitcoinListFile(context,qkey,lang);
    }
    return fetchSearchNews(qkey,lang);
  }

  Future<NewsItem> fetchSearchNews(String qkey,String lang) async {
    String url = "https://gitlab.com/fightmz/testinfo/-/raw/master/search_"+qkey+"_"+lang+".json";

    if(lang.isEmpty){
      url = "https://gitlab.com/fightmz/testinfo/-/raw/master/search_"+qkey+".json";
    }

    if(qkey != "bitcoin"){
      url = "https://gitlab.com/fightmz/testinfo/-/raw/master/search_empty.json";
    }

    final response = await client.get(url);
    if(response.statusCode == 200) {

      final body = jsonDecode(response.body);
      return NewsItem.fromJson(body);
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  // Parses newsItems.json File
  Future<NewsItem> getNewsItemList(BuildContext context,String qkey) async {
    if(isLocalTest){
      return getNewsItemListFile(context,qkey);
    }
    return fetchNews(qkey);
  }

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

  // Parses searchBitcoin.json File
  Future<NewsItem> getSearchBitcoinListFile(BuildContext context,String qkey,String lang) async {

    String loadString = mappingLoadingSearchJson(qkey,lang);

    if(loadString == null || loadString.isEmpty){
      return null;
    }

    String jsonString = await DefaultAssetBundle.of(context).loadString(loadString);
    Map<String,dynamic> jsonData = jsonDecode(jsonString);


    NewsItem newsItems = NewsItem.fromJson(jsonData);
    return newsItems;
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

  String mappingLoadingSearchJson(String qkey,String lang){


    String loadString = "assets/texts/searchBitcoinEmpty.json";

    if(qkey != "bitcoin"){
      return loadString;
    }
    switch(lang){
      case "":
        loadString = "assets/texts/searchBitcoin.json";
        break;
      case "zh":
        loadString = "assets/texts/searchBitcoinZh.json";
        break;
      case "en":
        loadString = "assets/texts/searchBitcoinEn.json";
        break;
      case "jp":
        loadString = "assets/texts/searchBitcoinJp.json";
        break;

    }
    return loadString;
  }
}