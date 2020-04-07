import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/tool/share_tool.dart';

class NewsShareIcon extends StatefulWidget {
  double width;
  double height;
  double iconSize;
  String title;
  String initialUrl;

  NewsShareIcon(
      {this.width, this.height, this.iconSize, this.title, this.initialUrl});

  @override
  State<StatefulWidget> createState() {
    return _NewsShareIconState(
        width: width,
        height: height,
        iconSize: iconSize,
        title: title,
        initialUrl: initialUrl);
  }
}

class _NewsShareIconState extends State<NewsShareIcon> {
  double width;
  double height;
  double iconSize;
  String title;
  String initialUrl;
  ShareTool shareTool = ShareTool();

  _NewsShareIconState(
      {this.width, this.height, this.iconSize, this.title, this.initialUrl});

  void _shareNews() {
    shareTool.share(title, initialUrl);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: IconButton(
            padding:EdgeInsets.all(0),
            icon: Icon(Icons.share),
            iconSize: iconSize,
            onPressed: _shareNews));
  }
}
