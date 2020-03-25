import 'package:flutter/material.dart';
import 'package:flutter_news_app/database/news_database.dart';
import 'package:flutter_news_app/tool/md5_tool.dart';
import 'package:transparent_image/transparent_image.dart';
import 'news_bookmark_inheritedwidget.dart';
import 'data/news_item.dart';
import 'data/news_ui_item.dart';
import 'news_bookmark_icon.dart';
import 'news_detail_page.dart';
import 'news_share_icon.dart';

class NewsCardItem extends StatefulWidget {
  NewsArticleUIItem item;
  NewsCardItem(this.item);


  @override
  State<StatefulWidget> createState() {
    return NewsCardItemState(item);
  }
}

class NewsCardItemState extends State<NewsCardItem>{
  NewsArticleUIItem item;
  double radius = 8.0;
  bool isAdded =false;

  NewsCardItemState(this.item);



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
          child: Image.network(getImageUrl(item.urlToImage)),
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
        name: generateMd5(articles.title == null?"":articles.title),
        title: articles.title == null?"": articles.title,
        author: articles.author,
        publishedAt: articles.publishedAt,
        url: articles.url,
        urlToImage: articles.urlToImage,
        savedAt: 0,
        description: articles.description,
        content: articles.content);
  }

  Widget _buildCardItems(BuildContext context,bool isAdded,NewsBookmarkDBItem dbItem) {

    return Column(
      children: <Widget>[
        _buildCardImage(),
        _buildCardToolbar(isAdded,dbItem)
      ],
    );
  }

  Widget _buildCardToolbar(bool isAdded,NewsBookmarkDBItem newsBookmarkDBItem){
    double iconWidthHeight = 24;
    double iconSize = 22;

    return Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            NewsBookmarkIcon(
                width: iconWidthHeight,
                height: iconWidthHeight,
                iconSize: iconSize,
                isAddedBookmark: isAdded,
                newsBookmarkDBItem:newsBookmarkDBItem,clickBookmarkCallBack: (isAdded){
                   updateBookmarkAndSetupFlag(context,isAdded,newsBookmarkDBItem.name);
                },
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
        )
    );
  }



  void onPressedCard(BuildContext context,String name) async{
    String url = item.url == null ? "" : item.url;
    String title = item.title == null ? "" : item.title;

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewsDetailPageRoute(
                initialUrl: url,
                title: title,
                isAddedBookmark:isAdded,
                newsBookmarkDBItem:_getNewsBookmarkDBItem(item.articlesFromServer),
            )));

    setState(() {
      updateBookmarkAndSetupFlag(context,result,name);
    });

  }
  
  void updateBookmarkAndSetupFlag(BuildContext context,bool result,String name){
    this.isAdded = result;
    NewsBookmarkInheritedWidget.of(context).updateBookmark(name, isAdded);
  }


  @override
  Widget build(BuildContext context) {
    NewsBookmarkDBItem dbItem = _getNewsBookmarkDBItem(item.articlesFromServer);
    isAdded = NewsBookmarkInheritedWidget.of(context).isAddedBookmark(dbItem.name);

    return GestureDetector(
        onTap: () => onPressedCard(context,dbItem.name),
        child: Card(
          margin: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: _buildCardItems(context,isAdded,dbItem),
        ));
  }

}

