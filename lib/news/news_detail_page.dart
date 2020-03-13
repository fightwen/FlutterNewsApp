import 'package:flutter/material.dart';

class NewsDetailPageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildFullSecondPage(context);
  }

  Widget _buildFullSecondPage(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}