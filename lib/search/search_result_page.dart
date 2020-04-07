import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/news/news_detail_page.dart';
import 'package:flutter_news_app/search/search_bookmark_inheritedwidget.dart';
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
  SearchController searchController = SearchController();
  String groupValue = ALL;
  String language = "";
  Color selectColor = Colors.white;

  Widget _buildResultText(String searchResultText) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPaddings.leftPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          searchResultText,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  void updateSegmentControl(String value) {
    groupValue = value;
    switch (value) {
      case ALL:
        language = "";
        break;
      case TW:
        language = "zh";
        break;
      case US:
        language = "en";
        break;
      case JP:
        language = "jp";
        break;
    }
  }

  Widget _buildNavigationBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPaddings.leftPadding),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CupertinoSegmentedControl(
              padding: EdgeInsets.only(
                  top: AppPaddings.topBottomPadding,
                  bottom: AppPaddings.topBottomPadding),
              groupValue: groupValue,
              pressedColor: Colors.black,
              selectedColor: Colors.black,
              borderColor: Colors.black,
              unselectedColor: Colors.white,
              onValueChanged: (String newValue) {
                setState(() {
                  updateSegmentControl(newValue);
                });
              },
              children: getChilds(),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: AppPaddings.topBottomPadding),
        child: FutureBuilder<List<SearchUIItem>>(
            future: searchController.getSearchUIItemList(
                context, widget.keyword, language),
            builder: (context, snapshot) {
              if (snapshot.hasError) return NetworkErrorWidget();
              bool isLoading =
                  snapshot.connectionState == ConnectionState.waiting;
              return snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data.length != 0
                  ? SearchBookmarkInheritedWidget(
                      list: snapshot.data,
                      child:
                          _buildSearchedView(isLoading, snapshot.data.length))
                  : isLoading? _buildLoadingView():_buildEmptyView();
            }));
  }

  Widget _buildEmptyView() {
    return Center(child:Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.search,size: 200,color: Colors.grey,),
        Padding(padding: EdgeInsets.all(10),
          child: Text("No Search Results",
            style: TextStyle(color: Colors.black, fontSize: 26),),),
        Padding(padding: EdgeInsets.all(10),
          child: Text(
            "No results found. Please revise\n your search and try again.",
            style: TextStyle(color: Colors.grey, fontSize: 16),),)
      ],));
  }

  Widget _buildLoadingView() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildSearchedView(bool isLoading, int length) {
    String resultLengthString = length == 0? "No results":length.toString() + " results";
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildResultText(resultLengthString),
          _buildNavigationBar(),
          Expanded(
            child: isLoading ? _buildLoadingView() : getListView(length),
          ),
        ]);
  }

  Widget _buildNavigateText(
      String text, String selectValue, String groupValue) {
    double textPadding = 8;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: textPadding),
      child: Text(
        text,
        style:
            TextStyle(color: _buildNavigateTextColor(selectValue, groupValue)),
      ),
    );
  }

  Color _buildNavigateTextColor(String value, String groupValue) {
    if (value == groupValue) {
      return Colors.white;
    }
    return Colors.black;
  }

  Map<String, Widget> getChilds() {
    Map<String, Widget> maps = Map<String, Widget>();
    maps.putIfAbsent(ALL, () => _buildNavigateText(ALL, ALL, groupValue));
    maps.putIfAbsent(TW, () => _buildNavigateText(TW, TW, groupValue));
    maps.putIfAbsent(US, () => _buildNavigateText(US, US, groupValue));
    maps.putIfAbsent(JP, () => _buildNavigateText(JP, JP, groupValue));
    return maps;
  }

  ListView getListView(int length) => ListView.builder(
      itemCount: length,
      itemBuilder: (BuildContext context, int position) {
        SearchBookmarkInheritedWidget widget =
            SearchBookmarkInheritedWidget.of(context);
        List<SearchUIItem> list = widget == null || widget.list == null
            ? List<SearchUIItem>()
            : widget.list;
        return getRow(context, list[position]);
      });

  void onPressedCard(BuildContext context, SearchUIItem uiItem) async {
    var dbItem =
        searchController.getNewsBookmarkDBItem(uiItem.articlesFromServer);
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewsDetailPageRoute(
                initialUrl: uiItem.url,
                title: uiItem.title,
                isAddedBookmark: uiItem.isAddedBookmark,
                newsBookmarkDBItem: dbItem)));
    SearchBookmarkInheritedWidget.of(context)
        .updateBookmark(dbItem.name, result);
  }

  Widget _buidItemTitleText(String title) {
    double keywordFontSize = 16;
    return Text(
      title,
      style: TextStyle(fontSize: keywordFontSize, color: Colors.black),
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    );
  }

  Widget _buidItemTimeText(String publishAt) {
    double keywordFontSize = 12;
    return Text(
      publishAt,
      style: TextStyle(fontSize: keywordFontSize, color: Colors.grey[600]),
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildTextPadding(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: widget,
    );
  }

  Widget _buildItemContent(SearchUIItem searchUIItem) {
    double topBottomPadding = 10;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.leftPadding, vertical: topBottomPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextPadding(_buidItemTitleText(searchUIItem.title)),
                _buildTextPadding(_buidItemTimeText(searchUIItem.publishAt))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.fiber_new),
          )
        ],
      ),
    );
  }

  Widget getRow(BuildContext context, SearchUIItem searchUIItem) {
    return Container(
        color: Colors.white,
        child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onPressedCard(context, searchUIItem);
              },
              child: Column(
                children: <Widget>[
                  _buildItemContent(searchUIItem),
                  LineWidget(Colors.grey[400])
                ],
              ),
            )));
  }
}
