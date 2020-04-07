import 'package:flutter/cupertino.dart';
import 'package:flutter_news_app/database/news_database.dart';
import 'package:flutter_news_app/network/web_service.dart';
import 'package:flutter_news_app/news/data/news_article_ui_listInfo.dart';
import 'package:flutter_news_app/news/data/news_ui_item.dart';
import 'package:flutter_news_app/preferences/setting_preferences.dart';
import 'package:flutter_news_app/tool/md5_tool.dart';

class NewsController{
  var service = WebService();

  Future<NewsArticleUIListInfo> getNewsArticleUIItemList(BuildContext context,String qkey) async {
    List<NewsArticleUIItem> list = List<NewsArticleUIItem>();
    var result = await service.getNewsItemList(context,qkey);
    var dbNewsNameList = await NewsDatabase.newsNames();
    var pref = SettingPreference();
    var isTextOnly = await pref.isTextOnlyMode();

    result.articles.forEach((element) {

      list.add(NewsArticleUIItem(title:element.title == null ?"":element.title,
          url:element.url,
          urlToImage:element.urlToImage,
          isAddedBookmark:dbNewsNameList.contains(generateMd5(element.title)),
          articlesFromServer:element));
    });
//    await  Future.delayed(const Duration(milliseconds: 1000));

    return NewsArticleUIListInfo(isTextOnly:isTextOnly,newsArticleUIItemList:list);
  }
}