

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class NewsBookmarkIcon extends StatefulWidget{
  double width;
  double height;
  double iconSize;
  NewsBookmarkIcon({this.width,this.height,this.iconSize});

  @override
  State<StatefulWidget> createState() {
    return _NewsBookmarkIconState(width:width,height:height,iconSize:iconSize);
  }

}

class _NewsBookmarkIconState extends State<NewsBookmarkIcon>{
  double width;
  double height;
  double iconSize;
  _NewsBookmarkIconState({this.width,this.height,this.iconSize});

  void _addBookmark(){

  }
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        width: width,height: height,
        child:IconButton(
          padding:EdgeInsets.all(0),
          iconSize: iconSize,
          icon: Icon(Icons.bookmark_border),
          onPressed: _addBookmark,));
  }

}