import 'package:flutter/material.dart';
import 'package:flutter_news_app/search/recent_search_page.dart';
import 'package:flutter_news_app/search/search_result_page.dart';
import 'package:flutter_news_app/style/app_colors.dart';
import 'package:flutter_news_app/style/app_paddings.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }

}

class _SearchPageState extends State<SearchPage> {
  static const double leftPadding = AppPaddings.leftPadding;
  static const double rightPadding = 8;
  static const double searchleftRightPadding = 6;
  Widget _buildTextFormFieldStyle() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        Padding(
          padding: EdgeInsets.only(left: searchleftRightPadding,right: searchleftRightPadding),
          child: Icon(Icons.search),),

        Expanded(child:
            Container(
              alignment: Alignment.center,
              height: 42,
              child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Find it on News'
              ),),)
        )
      ],
    );
  }

  Widget _buildTextFormFieldStyleWithRadius(){
    const double radius = 4.0;
    const double otherPadding = 8;
    return Container(
      margin: EdgeInsets.only(left: leftPadding,top:otherPadding,bottom: otherPadding,right: otherPadding),
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(radius),
            topRight: const Radius.circular(radius),
            bottomRight: const Radius.circular(radius),
            bottomLeft: const Radius.circular(radius),
          )
      ),
      child: _buildTextFormFieldStyle(),);
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.grey[300],
      child: Row(children: <Widget>[
        Expanded(
          child: _buildTextFormFieldStyleWithRadius(),),
        Padding(
          padding: EdgeInsets.only(right: rightPadding),
          child: Text("Cancel", style: TextStyle(fontSize: 16),),),

      ],),);
  }




  Widget _buildSearchPage(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      _buildSearchBar(),
      _generateSearchListPage(false),
    ],);
  }

  Widget _generateSearchListPage(bool isSearched){
    if(isSearched)
      return Expanded(child: RecentSearchPage(),);
    return Expanded(child:SearchResultPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
        body:_buildSearchPage()
    );
  }

}