import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPageRoute extends StatelessWidget {
  String mInitialUrl;
  NewsDetailPageRoute(String initialUrl){
    mInitialUrl = initialUrl;
  }

  @override
  Widget build(BuildContext context) {
    return _buildFullSecondPage(context);
  }

  Widget _buildTextButton(BuildContext context){
    return Center(
      child: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Go back!'),
      ),
    );
  }

  Widget _buildFullSecondPage(BuildContext context){
    print("GGGG!!! mInitialUrl "+mInitialUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: WebView(
        initialUrl: mInitialUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}