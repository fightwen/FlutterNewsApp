

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/database/news_database.dart';

import 'data/NewsUIItem.dart';



class NewsBookmarkIcon extends StatefulWidget{
  bool isAdded = false;
  double width;
  double height;
  double iconSize;
  NewsBookmarkDBItem newsBookmarkDBItem;
  NewsBookmarkIcon({this.width,this.height,this.iconSize,this.isAdded,this.newsBookmarkDBItem});

  @override
  State<StatefulWidget> createState() {
    return _NewsBookmarkIconState(width:width,height:height,isAdded:isAdded,iconSize:iconSize);
  }

}

class _NewsBookmarkIconState extends State<NewsBookmarkIcon>{
  bool isAdded = false;
  double width;
  double height;
  double iconSize;
  NewsBookmarkDBItem newsBookmarkDBItem;
  _NewsBookmarkIconState({this.width,this.height,this.iconSize,this.isAdded,this.newsBookmarkDBItem});

  void _addBookmark(){
    NewsDatabase.insertNews(newsBookmarkDBItem);
    setState(() {
      isAdded = true;
    });

  }

  void _deleteBookmark(){
    NewsDatabase.deleteNews(newsBookmarkDBItem.name);
    setState(() {
      isAdded = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        width: width,height: height,
        child:IconButton(
          padding:EdgeInsets.all(0),
          iconSize: iconSize,
          icon: Icon(isAdded?Icons.bookmark:Icons.bookmark_border),
          onPressed: isAdded?_deleteBookmark:_addBookmark,));
  }

}