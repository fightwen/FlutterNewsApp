

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/database/news_database.dart';

import 'news_bookmark_inheritedwidget.dart';
import 'data/news_ui_item.dart';



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

  NewsBookmarkDBItem _getSavedDBItem(NewsBookmarkDBItem dbItem){
    NewsBookmarkDBItem savedDBItem = NewsBookmarkDBItem(
        name:dbItem.name,
        title:dbItem.title,
        urlToImage:dbItem.urlToImage,
        url: dbItem.url,
        savedAt: DateTime.now().millisecondsSinceEpoch,
        publishedAt: dbItem.publishedAt,
        description: dbItem.description,
        author: dbItem.author,
        content: dbItem.content
    );
    return savedDBItem;
  }

  void _addBookmark(){
    NewsBookmarkDBItem dbItem = widget.newsBookmarkDBItem;
    NewsBookmarkDBItem savedDBItem = _getSavedDBItem(dbItem);

    NewsDatabase.insertNews(savedDBItem);
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

