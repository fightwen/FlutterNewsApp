import 'package:flutter/cupertino.dart';
import 'package:flutter_news_app/tool/md5_tool.dart';

import 'data/news_ui_item.dart';

class NewsBookmarkInheritedWidget extends InheritedWidget {
  List<NewsArticleUIItem> list;

  NewsBookmarkInheritedWidget({@required this.list, @required Widget child}):super(child: child);

  @override
  bool updateShouldNotify(NewsBookmarkInheritedWidget old) =>
      list != old.list;

  static NewsBookmarkInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NewsBookmarkInheritedWidget>();
  }

  int getListlength(){
    if(list == null)
      return 0;
    return list.length;
  }

  NewsArticleUIItem getItem(int position){
    return list[position];
  }

  void updateBookmark(String name,bool isAddedBookmark){
    for (var value in list) {
        if(value.title != null && generateMd5(value.title) == name){
            value.isAddedBookmark = isAddedBookmark;
        }
    }
  }

  bool isAddedBookmark(String name){
    if(list == null || name == null)
      return false;

    for (var value in list) {
      if(value.title != null && generateMd5(value.title) == name){
         return value.isAddedBookmark;
      }
    }
    return false;
  }
}