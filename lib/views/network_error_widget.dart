import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/generated/i18n.dart';

class NetworkErrorWidget extends StatelessWidget{


  Widget _buildErrorView(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
              width: 200,
              height: 200,
              image: AssetImage('assets/images/no_connection.png')),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(S.of(context).no_connection,style: TextStyle(fontSize: 26,color: Colors.black),),),
          Padding(
            padding: EdgeInsets.all(4),
            child: Text(S.of(context).try_again,style: TextStyle(fontSize: 20,color: Colors.grey[600]),),)
        ],
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return _buildErrorView(context);
  }
}