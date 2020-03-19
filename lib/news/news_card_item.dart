import 'package:flutter/material.dart';
import 'package:flutter_news_app/database/news_database.dart';
import 'package:transparent_image/transparent_image.dart';
import 'data/NewsItem.dart';
import 'data/NewsUIItem.dart';
import 'news_bookmark_icon.dart';
import 'news_detail_page.dart';
import 'news_share_icon.dart';

class NewsCardItem extends StatelessWidget {
  NewsArticleUIItem item;
  double radius = 8.0;

  NewsCardItem({this.item});

  String getImageUrl(String urlToImage) {
    String imgUrl = urlToImage == null
        ? 'https://rent.dyu.edu.tw/Picture/00/0.jpg'
        : item.urlToImage;
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
            image: getImageUrl(item.urlToImage),
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
            item.title,
            style: TextStyle(color: Colors.white, fontSize: 26.0),
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  NewsBookmarkDBItem _getNewsBookmarkDBItem(Articles articles){
    return NewsBookmarkDBItem(
        name: articles.source.name,
        author: articles.author,
        publishedAt: articles.publishedAt,
        url: articles.url,
        urlToImage: articles.urlToImage,
        savedAt: 0,
        description: articles.description,
        content: articles.content);
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
                  isAdded: item.isAddedBookmark,
                  newsBookmarkDBItem:_getNewsBookmarkDBItem(item.articlesFromServer),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 8),
                  child: NewsShareIcon(
                      width: iconWidthHeight,
                      height: iconWidthHeight,
                      iconSize: iconSize,
                      title: item.title,
                      initialUrl: item.url),
                )
              ],
            ))
      ],
    );
  }

  void onPressedCard(BuildContext context) {
    String url = item.url == null ? "" : item.url;
    String title = item.title == null ? "" : item.title;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewsDetailPageRoute(
                  initialUrl: url,
                  title: title,
                  newsBookmarkDBItem:_getNewsBookmarkDBItem(item.articlesFromServer)
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
