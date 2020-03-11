import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/news/news_detail_page.dart';

class BookmarkCardItem extends StatelessWidget {

  Widget _buildImage(){
    return Container(
      width: 100,
      height: 100,
      color: Colors.pink,
      child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/%E7%A6%8F%E5%B7%9E%E7%86%8A%E7%8C%AB%E4%B8%96%E7%95%8C-%E7%86%8A%E7%8C%AB%E5%B7%B4%E6%96%AF02.jpg/800px-%E7%A6%8F%E5%B7%9E%E7%86%8A%E7%8C%AB%E4%B8%96%E7%95%8C-%E7%86%8A%E7%8C%AB%E5%B7%B4%E6%96%AF02.jpg') ,);
  }

  Widget _buildRowIconsInItem(){
    return  Row(
      mainAxisSize:MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

        Expanded(
          child:Text("Time",)
        ),

        Container(
            color: Colors.pink,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 0.0),
            child:Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.bookmark),
            )
        ),

        Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 0.0),
            child:Padding(
                padding: EdgeInsets.all(8),
                child:Icon(Icons.share)
            )
        ),
      ],
    );
  }

  void onPressedCard(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewsDetailPageRoute()));
  }

  Widget _buildLine(){
    return Container(
      height: 1.0,
      width: double.infinity,
      color: Colors.grey,
    );
  }

  Widget _buildTexts(){
    return Expanded(child: Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(children: <Widget>[
        Text("TitleTitleTitleTitleTitleTitleTitleTitleTitle",style: TextStyle(fontSize: 30)),
        _buildRowIconsInItem()
      ],),
    ),);
  }

  Widget _buildCardTest2Image() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildImage(),
        _buildTexts()
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onPressedCard(context),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child:_buildCardTest2Image(),

              ),

              _buildLine()
            ],)
    );
  }

}