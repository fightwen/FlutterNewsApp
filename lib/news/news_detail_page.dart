import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPageRoute extends StatefulWidget {
  String initialUrl;
  String title;

  NewsDetailPageRoute({this.initialUrl, this.title});

  @override
  State<StatefulWidget> createState() {
    return _NewsDetailPageRouteState(initialUrl: initialUrl, title: title);
  }
}

class _NewsDetailPageRouteState extends State<NewsDetailPageRoute> {
  String initialUrl;
  String title;
  bool isLoaded = false;
  num _stackToView = 1;

  _NewsDetailPageRouteState({this.initialUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return _buildFullSecondPage(context);
  }

  Widget _buildFullSecondPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: IndexedStack(
        index: _stackToView,
        children: <Widget>[
          Expanded(
            child: _buildWebview(),
          ),
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
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
