

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_news_app/database/news_database.dart';
import 'package:flutter_news_app/network/web_service.dart';
import 'package:flutter_news_app/search/data/search_ui_item.dart';
import 'package:flutter_news_app/tool/md5_tool.dart';

import '../../news/data/news_item.dart';
import '../file/search_keywords_file.dart';

class SearchController {
  var file = SearchKeywordsFile();
  var service = WebService();

  void saveKeywordToFile(String keywords) {
    file.writeKeywords(keywords);
  }

  Future<List<String>> readKeywordToFile() {
    return file.readKeywords();
  }

  Future<FileSystemEntity> clear(){
    return file.clearKeywords();
  }

  Future<List<SearchUIItem>> getSearchUIItemList(BuildContext context,String qkey,String lang) async {
    List<SearchUIItem> list = List<SearchUIItem>();
    var result = await service.getSearchNewsItemList(context, qkey, lang);
    var dbNewsNameList = await NewsDatabase.newsNames();

    result.articles.forEach((element) {

      list.add(SearchUIItem(title:element.title == null ?"":element.title,
          url:element.url,
          publishAt:element.publishedAt,
          isAddedBookmark:dbNewsNameList.contains(generateMd5(element.title)),
          articlesFromServer:element));
    });

    return list;
  }

  NewsBookmarkDBItem getNewsBookmarkDBItem(Articles articles){
    return NewsBookmarkDBItem(
        name: generateMd5(articles.title == null?"":articles.title),
        title: articles.title == null?"": articles.title,
        author: articles.author,
        publishedAt: articles.publishedAt,
        url: articles.url,
        urlToImage: articles.urlToImage,
        savedAt: 0,
        description: articles.description,
        content: articles.content);
  }
}