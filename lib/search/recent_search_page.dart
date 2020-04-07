

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/style/app_paddings.dart';
import 'package:flutter_news_app/views/network_error_widget.dart';

import 'controller/search_controller.dart';



class RecentSearchPage extends StatefulWidget{
  Function(String) searchCallBack;
  RecentSearchPage({@required this.searchCallBack});

  @override
  State<StatefulWidget> createState() {
    return _RecentSearchPageState();
  }


}

class _RecentSearchPageState extends State<RecentSearchPage> {
  static const double leftPadding = AppPaddings.leftPadding;
  static const double rightPadding = 8;
  var searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      _buildRecentSearch(),
      FutureBuilder<List<String>>(
        future: searchController.readKeywordToFile(),
         builder: (context, snapshot) {
           if (snapshot.hasError) return NetworkErrorWidget();
           if(snapshot.connectionState == ConnectionState.waiting){
             return Center(child: CircularProgressIndicator(),);
           }

           return snapshot.hasData &&
               snapshot.data != null &&
               snapshot.data.length != 0
               ? Expanded(child: getListView(snapshot.data),)
               : Container();
         }
      ),
    ],);
  }

  ListView getListView(List<String> keywords) => ListView.builder(
      itemCount: keywords.length,
      itemBuilder: (BuildContext context, int position) {
        return getRowWithTap(keywords[position]);
      });

  Widget getRowWithTap(String keyword){
    return getRow(keyword);
  }


  Widget getRow(String keyword) {
    double topBottomPadding = 10;
    double keywordFontSize = 18;
    return Container(
        color: Colors.white,
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                  widget.searchCallBack(keyword);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: leftPadding,
                      right: rightPadding,
                      top: topBottomPadding,
                      bottom: topBottomPadding),
                  child: Text(
                    keyword,
                    style: TextStyle(
                        fontSize: keywordFontSize, color: Colors.black),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,)
                  ,)
            )));
  }

  Widget _buildRecentSearch() {
    return Row(children: <Widget>[
      Expanded(
        child: Padding(
            padding: EdgeInsets.only(left: leftPadding, top: 10, bottom: 10),
            child: Text("Recent Searches",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),)),),
      Padding(
        padding: EdgeInsets.only(right: rightPadding),
        child: InkWell(
          onTap: () {
            Future<FileSystemEntity> result = searchController.clear();
            result.whenComplete(() => {setState(() {})});
          },
          child: Text(
              "Clear", style: TextStyle(fontSize: 16, color: Colors.red)),),
      )

    ],);
  }

}