

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/style/app_paddings.dart';



class RecentSearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RecentSearchPageState();
  }


}

class _RecentSearchPageState extends State<RecentSearchPage> {
  static const double leftPadding = AppPaddings.leftPadding;
  static const double rightPadding = 8;
  static const double searchleftRightPadding = 6;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      _buildRecentSearch(),
      Expanded(child: getListView(),)
    ],);
  }

  ListView getListView() => ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });


  Widget getRow(int i) {
    double topBottomPadding = 10;
    double keywordFontSize = 18;
    return Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
              left: leftPadding, right: rightPadding, top: topBottomPadding, bottom: topBottomPadding),
          child: Text(
            "KeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeyword",
            style: TextStyle(fontSize: keywordFontSize, color: Colors.black),
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,)
          ,)
    );
  }

  Widget _buildRecentSearch() {
    return Row(children: <Widget>[
      Expanded(
        child: Padding(
            padding: EdgeInsets.only(left: leftPadding,top: 10,bottom: 10),
            child: Text("Recent Searches",style: TextStyle(fontSize: 14,color: Colors.grey[600]),)),),
      Padding(
        padding: EdgeInsets.only(right: rightPadding),
        child: Text("Clear",style: TextStyle(fontSize: 16,color: Colors.red)),
      )

    ],);
  }

}