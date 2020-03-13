import 'package:flutter/material.dart';
import 'data/NewsItem.dart';
import 'news_detail_page.dart';

class NewsCardItem extends StatelessWidget {
  ArticlesBean _item;
  NewsCardItem(ArticlesBean item){
    _item = item;
  }

  Widget _buildCardImage() {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
              'https://i.ytimg.com/vi/fq4N0hgOWzU/maxresdefault.jpg'),
        ),
        Container(
            width: double.infinity,
            constraints: BoxConstraints.expand(height: 150.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87]))
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            _item.title,
            style: TextStyle(color: Colors.white, fontSize: 26.0),
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),

      ],
    );
  }

  Widget _buildCardItems() {
    return Column(
      children: <Widget>[
        _buildCardImage(),
        Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(Icons.bookmark_border),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Icon(Icons.share),
                )
              ],)
        )
      ],
    );
  }

  void onPressedCard(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewsDetailPageRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onPressedCard(context),
        child: Card(
          margin: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: _buildCardItems(),
        )
    );
  }

}