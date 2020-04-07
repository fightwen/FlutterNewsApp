import 'package:flutter/cupertino.dart';

import 'news_ui_item.dart';

class NewsArticleUIListInfo{
  NewsArticleUIListInfo({@required this.isTextOnly,@required this.newsArticleUIItemList});
  bool isTextOnly = false;
  List<NewsArticleUIItem> newsArticleUIItemList;

}