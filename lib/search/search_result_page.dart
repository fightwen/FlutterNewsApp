import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/style/app_paddings.dart';
import 'package:flutter_news_app/views/line_widget.dart';

class SearchResultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchResultPageState();
  }
}

class _SearchResultPageState extends State<SearchResultPage> {

  Widget _buildResultText(String searchResultText) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPaddings.leftPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          searchResultText,
          style: TextStyle(fontSize: 14),
        ),),);
  }

  Widget _buildNavigationBar(){
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: AppPaddings.leftPadding),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CupertinoSegmentedControl(
              padding: EdgeInsets.only(top:AppPaddings.topBottomPadding,bottom: AppPaddings.topBottomPadding),
              pressedColor: Colors.black,
              selectedColor: Colors.grey,
              borderColor: Colors.black,
              unselectedColor: Colors.white,
              onValueChanged: (String newValue) {

              },
              children: getChilds(),
            ),
          )
        ],
      ),);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: AppPaddings.topBottomPadding,
            bottom: AppPaddings.topBottomPadding),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildResultText("2234 results"),
              _buildNavigationBar(),
              Expanded(child: getListView(),)

            ]));
  }

  String ALL = "ALL";
  String ARTICLES = "Articles";
  String VIDEOS = "Videos";
  String GALLERIES = "Galleries";

  Widget _buildNavigateText(String text){
    double textPadding = 8;
    return Padding(
      padding:EdgeInsets.symmetric(vertical: textPadding),
      child:Text(text,style: TextStyle(color: Colors.pink),) ,);
  }

  Map<String, Widget> getChilds() {
    Map<String, Widget> maps = Map<String, Widget>();
    maps.putIfAbsent(ALL, () => _buildNavigateText(ALL));
    maps.putIfAbsent(ARTICLES, () => _buildNavigateText(ARTICLES));
    maps.putIfAbsent(VIDEOS, () => _buildNavigateText(VIDEOS));
    maps.putIfAbsent(GALLERIES, () => _buildNavigateText(GALLERIES));
    return maps;
  }

  ListView getListView() => ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget _buidItemTitleText(){
    double keywordFontSize = 16;
    return Text(
      "KeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeyword",
      style: TextStyle(fontSize: keywordFontSize, color: Colors.black),
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,);
  }

  Widget _buidItemTimeText(){
    double keywordFontSize = 12;
    return Text(
      "KeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeywordKeyword",
      style: TextStyle(fontSize: keywordFontSize, color: Colors.grey[600]),
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,);
  }

  Widget _buildTextPadding(Widget widget){
    return Padding(padding: EdgeInsets.symmetric(vertical: 4),child: widget,);
  }

  Widget _buildItemContent(){
    double topBottomPadding = 10;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.leftPadding,
          vertical: topBottomPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTextPadding(_buidItemTitleText()),
              _buildTextPadding(_buidItemTimeText())
            ],),),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.fiber_new),)
        ],)
      ,);
  }


  Widget getRow(int i) {
    return Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          _buildItemContent(),
          LineWidget(Colors.grey[400])
        ],)
    );
  }
}
