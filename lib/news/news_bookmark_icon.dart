

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/database/news_database.dart';

import 'bookmark_inheritedwidget.dart';
import 'data/NewsUIItem.dart';



class NewsBookmarkIcon extends StatefulWidget{
  bool isAddedBookmark;
  double width;
  double height;
  double iconSize;
  NewsBookmarkDBItem newsBookmarkDBItem;
  Function(bool) clickBookmarkCallBack;

  NewsBookmarkIcon({
    this.width,
    this.height,
    this.iconSize,
    this.isAddedBookmark,
    this.newsBookmarkDBItem,
    this.clickBookmarkCallBack});

  @override
  State<StatefulWidget> createState() {
    return _NewsBookmarkIconState();
  }

}

class _NewsBookmarkIconState extends State<NewsBookmarkIcon>{

  void _addBookmark(){
    NewsDatabase.insertNews(widget.newsBookmarkDBItem);
    setState(() {
      widget.isAddedBookmark = true;
      if(widget.clickBookmarkCallBack!=null){
        widget.clickBookmarkCallBack(widget.isAddedBookmark);

      }

    });

  }



  void _deleteBookmark(){
    NewsDatabase.deleteNews(widget.newsBookmarkDBItem.name);
    setState(() {
      widget.isAddedBookmark = false;
      if(widget.clickBookmarkCallBack!=null){
        widget.clickBookmarkCallBack(widget.isAddedBookmark);
      }

    });
  }
  @override
  Widget build(BuildContext context) {

    return  SizedBox(
        width: widget.width,height: widget.height,
        child:IconButton(
          padding:EdgeInsets.all(0),
          iconSize: widget.iconSize,
          icon: Icon(widget.isAddedBookmark?Icons.bookmark:Icons.bookmark_border),
          onPressed: widget.isAddedBookmark?_deleteBookmark:_addBookmark,));
  }

}

