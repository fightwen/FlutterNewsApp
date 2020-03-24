
import 'news_item.dart';

class NewsArticleUIItem{
  NewsArticleUIItem({this.title,this.url,this.urlToImage,this.isAddedBookmark,this.articlesFromServer});
  String title;
  String url;
  String urlToImage;
  bool isAddedBookmark = false;
  Articles articlesFromServer;
}