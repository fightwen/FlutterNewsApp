

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/database/news_database.dart';

import 'bookmark_inheritedwidget.dart';
import 'data/NewsUIItem.dart';



class NewsBookmarkIcon extends StatefulWidget{

  String name;
  double width;
  double height;
  double iconSize;
  NewsBookmarkDBItem newsBookmarkDBItem;
  NewsBookmarkIcon({this.width,this.height,this.iconSize,this.name,this.newsBookmarkDBItem});

  @override
  State<StatefulWidget> createState() {
    return _NewsBookmarkIconState(width:width,height:height,name:name,iconSize:iconSize,newsBookmarkDBItem: newsBookmarkDBItem);
  }

}

class _NewsBookmarkIconState extends State<NewsBookmarkIcon>{
  String name;
  double width;
  double height;
  double iconSize;
  NewsBookmarkDBItem newsBookmarkDBItem;
  _NewsBookmarkIconState({this.width,this.height,this.iconSize,this.name,this.newsBookmarkDBItem});

  void _addBookmark(){
    NewsDatabase.insertNews(newsBookmarkDBItem);
    setState(() {
      BookmarkInheritedWidget.of(context).updateBookmark(name, true);

    });

  }

  void _deleteBookmark(){
    NewsDatabase.deleteNews(newsBookmarkDBItem.name);
    setState(() {
      BookmarkInheritedWidget.of(context).updateBookmark(name, false);
    });
  }
  @override
  Widget build(BuildContext context) {
    var bookmarkInheritedWidget = BookmarkInheritedWidget.of(context);
    bool isAdded = bookmarkInheritedWidget!=null && bookmarkInheritedWidget.isAddedBookmark(name);
    return  SizedBox(
        width: width,height: height,
        child:IconButton(
          padding:EdgeInsets.all(0),
          iconSize: iconSize,
          icon: Icon(isAdded?Icons.bookmark:Icons.bookmark_border),
          onPressed: isAdded?_deleteBookmark:_addBookmark,));
  }

}