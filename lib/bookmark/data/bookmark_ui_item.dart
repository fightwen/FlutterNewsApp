
import 'package:flutter_news_app/database/news_database.dart';

class BookmarkUIItem{
  BookmarkUIItem({
    this.name,
    this.title,
    this.savedAt,
    this.urlToImage,
    this.url,
    this.isAddedBookmark,
    this.dbItem});
  String name;
  String title;
  String savedAt;
  String urlToImage;
  String url;
  bool isAddedBookmark;
  NewsBookmarkDBItem dbItem;
}