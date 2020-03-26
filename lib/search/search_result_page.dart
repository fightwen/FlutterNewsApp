import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/news/news_detail_page.dart';
import 'package:flutter_news_app/style/app_paddings.dart';
import 'package:flutter_news_app/views/line_widget.dart';
import 'package:flutter_news_app/views/network_error_widget.dart';

import 'controller/search_controller.dart';
import 'data/search_ui_item.dart';

const String ALL = "ALL";
const String TW = "TW";
const String US = "US";
const String JP = "JP";

class SearchResultPage extends StatefulWidget {
  String keyword;
  SearchResultPage({@required this.keyword});

  @override
  State<StatefulWidget> createState() {
    return _SearchResultPageState();
  }
}

class _SearchResultPageState extends State<SearchResultPage> {
  SearchController searchController= SearchController();

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
        child: FutureBuilder<List<SearchUIItem>>(
            future: searchController.getSearchUIItemList(
                context, widget.keyword, "zh"),
            builder: (context, snapshot) {
              if (snapshot.hasError) return NetworkErrorWidget();
              return snapshot.hasData && snapshot.data != null &&
                  snapshot.data.length != 0
                  ? _buildSearchedView(snapshot.data.length, snapshot.data)
                  : Center(child: CircularProgressIndicator());
            }
        ));
  }

  Widget _buildSearchedView(int length,List<SearchUIItem> searchUIItems) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildResultText(length.toString() + " results"),
          _buildNavigationBar(),
          Expanded(
              child: getListView(length, searchUIItems)

          ),
        ]);
  }



  Widget _buildNavigateText(String text){
    double textPadding = 8;
    return Padding(
      padding:EdgeInsets.symmetric(vertical: textPadding),
      child:Text(text,style: TextStyle(color: Colors.pink),) ,);
  }

  Map<String, Widget> getChilds() {
    Map<String, Widget> maps = Map<String, Widget>();
    maps.putIfAbsent(ALL, () => _buildNavigateText(ALL));
    maps.putIfAbsent(TW, () => _buildNavigateText(TW));
    maps.putIfAbsent(US, () => _buildNavigateText(US));
    maps.putIfAbsent(JP, () => _buildNavigateText(JP));
    return maps;
  }

  ListView getListView(int length,List<SearchUIItem> searchUIItems) => ListView.builder(
      itemCount: length,
      itemBuilder: (BuildContext context, int position) {
        return _buildRowWithTap(context,searchUIItems[position]);
      });

  void onPressedCard(BuildContext context, SearchUIItem uiItem) async {
//    var result =  await Navigator.push(
//        context, MaterialPageRoute(builder: (context) =>
//        NewsDetailPageRoute(
//            initialUrl: uiItem.url,
//            title: uiItem.title,
//            isAddedBookmark: uiItem.isAddedBookmark,
//            newsBookmarkDBItem: uiItem.dbItem)));

  }

  Widget _buildRowWithTap(BuildContext context,SearchUIItem searchUIItem){
    return InkWell(
      onTap: (){
        onPressedCard(context,searchUIItem);
      },
      child: getRow(searchUIItem) ,);
  }

  Widget _buidItemTitleText(String title){
    double keywordFontSize = 16;
    return Text(
      title,
      style: TextStyle(fontSize: keywordFontSize, color: Colors.black),
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,);
  }

  Widget _buidItemTimeText(String publishAt){
    double keywordFontSize = 12;
    return Text(
      publishAt,
      style: TextStyle(fontSize: keywordFontSize, color: Colors.grey[600]),
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,);
  }

  Widget _buildTextPadding(Widget widget){
    return Padding(padding: EdgeInsets.symmetric(vertical: 4),child: widget,);
  }

  Widget _buildItemContent(SearchUIItem searchUIItem){
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
              _buildTextPadding(_buidItemTitleText(searchUIItem.title)),
              _buildTextPadding(_buidItemTimeText(searchUIItem.publishAt))
            ],),),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.fiber_new),)
        ],)
      ,);
  }


  Widget getRow(SearchUIItem searchUIItem) {
    return Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          _buildItemContent(searchUIItem),
          LineWidget(Colors.grey[400])
        ],)
    );
  }
}
