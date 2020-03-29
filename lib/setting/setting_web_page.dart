import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingWebPageRoute extends StatefulWidget {
  String initialUrl;

  SettingWebPageRoute(
      {this.initialUrl});

  @override
  State<StatefulWidget> createState() {
    return _SettingWebPageRouteState(
        initialUrl: initialUrl);
  }
}

class _SettingWebPageRouteState extends State<SettingWebPageRoute> {
  String initialUrl;
  bool _isLoadingPage = true;

  _SettingWebPageRouteState(
      {this.initialUrl});

  @override
  Widget build(BuildContext context) {
    return _buildFullSecondPage(context);
  }

  Widget _buildFullSecondPage(BuildContext context) {
    double iconWidthHeightSize = 30;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          appBar: AppBar(),
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