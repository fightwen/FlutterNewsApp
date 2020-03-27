
import 'package:flutter_news_app/database/news_database.dart';
import 'package:flutter_news_app/news/data/news_item.dart';


class SearchUIItem{
  SearchUIItem({this.title,this.url,this.publishAt,this.isAddedBookmark,this.articlesFromServer});
  String title;
  String publishAt;
  String url;
  bool isAddedBookmark = false;
  Articles articlesFromServer;
}