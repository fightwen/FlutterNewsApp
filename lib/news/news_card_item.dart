import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'data/NewsItem.dart';
import 'news_bookmark_icon.dart';
import 'news_detail_page.dart';
import 'news_share_icon.dart';

class NewsCardItem extends StatelessWidget {
  Articles _item;
  double radius = 8.0;

  NewsCardItem(Articles item) {
    _item = item;
  }

  String getImageUrl(String urlToImage) {
    String imgUrl = urlToImage == null
        ? 'https://rent.dyu.edu.tw/Picture/00/0.jpg'
        : _item.urlToImage;
    return imgUrl;
  }

  Widget _buildCardImage() {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: getImageUrl(_item.urlToImage),
          ),
        ),
        Container(
            width: double.infinity,
            constraints: BoxConstraints.expand(height: 150.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87]))),
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
    double iconWidthHeight = 24;
    double iconSize = 22;
    return Column(
      children: <Widget>[
        _buildCardImage(),
        Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                NewsBookmarkIcon(
                  width: iconWidthHeight,
                  height: iconWidthHeight,
                  iconSize: iconSize,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 8),
                  child: NewsShareIcon(
                      width: iconWidthHeight,
                      height: iconWidthHeight,
                      iconSize: iconSize,
                      title: _item.title,
                      initialUrl: _item.url),
                )
              ],
            ))
      ],
    );
  }

  void onPressedCard(BuildContext context) {
    String url = _item.url == null ? "" : _item.url;
    String title = _item.title == null ? "" : _item.title;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewsDetailPageRoute(
                  initialUrl: url,
                  title: title,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onPressedCard(context),
        child: Card(
          margin: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: _buildCardItems(),
        ));
  }
}
