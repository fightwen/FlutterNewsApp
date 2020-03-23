import 'package:flutter/material.dart';
import 'package:flutter_news_app/database/news_database.dart';
import 'package:flutter_news_app/tool/share_tool.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'news_bookmark_icon.dart';
import 'news_share_icon.dart';

class NewsDetailPageRoute extends StatefulWidget {
  String initialUrl;
  String title;
  NewsBookmarkDBItem newsBookmarkDBItem;
  bool isAddedBookmark = false;

  NewsDetailPageRoute(
      {this.initialUrl,
      this.title,
      this.isAddedBookmark,
      this.newsBookmarkDBItem});

  @override
  State<StatefulWidget> createState() {
    return _NewsDetailPageRouteState(
        initialUrl: initialUrl,
        title: title,
        isAddedBookmark: isAddedBookmark,
        newsBookmarkDBItem: newsBookmarkDBItem);
  }
}

class _NewsDetailPageRouteState extends State<NewsDetailPageRoute> {
  String initialUrl;
  String title;
  bool _isLoadingPage = true;
  bool isAddedBookmark = false;
  NewsBookmarkDBItem newsBookmarkDBItem;

  _NewsDetailPageRouteState(
      {this.initialUrl,
      this.title,
      this.isAddedBookmark,
      this.newsBookmarkDBItem});

  @override
  Widget build(BuildContext context) {
    return _buildFullSecondPage(context);
  }

  Widget _buildFullSecondPage(BuildContext context) {
    double iconWidthHeightSize = 30;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, isAddedBookmark);
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: NewsShareIcon(
                    width: iconWidthHeightSize,
                    height: iconWidthHeightSize,
                    iconSize: iconWidthHeightSize,
                    title: title,
                    initialUrl: initialUrl),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 18),
                  child: NewsBookmarkIcon(
                    width: iconWidthHeightSize,
                    height: iconWidthHeightSize,
                    iconSize: iconWidthHeightSize,
                    isAddedBookmark: isAddedBookmark,
                    newsBookmarkDBItem: newsBookmarkDBItem,
                    clickBookmarkCallBack: (isAdded) {
                      isAddedBookmark = isAdded;
                    },
                  )),
            ],
          ),
          body:
              _isLoadingPage ? _buildLoadingWebview() : _buildLoadedWebview()),
    );
  }

  Widget _buildLoadingWebview() {
    return Stack(
      children: <Widget>[
        _buildWebview(),
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }

  Widget _buildLoadedWebview() {
    return Stack(
      children: <Widget>[
        _buildWebview(),
      ],
    );
  }

  void _handleLoad(String value) {
    setState(() {
      _isLoadingPage = false;
    });
  }

  Widget _buildWebview() {
    return WebView(
      onPageFinished: _handleLoad,
      initialUrl: initialUrl,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
