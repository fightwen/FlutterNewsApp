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

  Widget _buildCardItems() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildImage(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Title"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child:Text("Time")),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                    Icon(Icons.bookmark),
                    Icon(Icons.share)
                  ],)
                  ,)

            ],),
          ],
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onPressedCard(context),
        child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: _buildCardItems(),),
                _buildLine()
          ],) 
    );
  }

}