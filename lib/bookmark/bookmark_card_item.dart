import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/news/news_detail_page.dart';
import 'package:flutter_news_app/news/news_share_icon.dart';
import 'package:flutter_news_app/views/line_widget.dart';

import 'bookmark_inheritedwidget.dart';
import 'data/bookmark_ui_item.dart';

class BookmarkCardItem extends StatelessWidget {
  BookmarkUIItem uiItem;
  Function callBackUpdateList;

  BookmarkCardItem(this.uiItem,this.callBackUpdateList);

  Widget _buildImage() {
    String imgUrl = uiItem.urlToImage == null?'https://rent.dyu.edu.tw/Picture/00/0.jpg':uiItem.urlToImage;
    return Container(
      alignment: Alignment.topLeft,
      width: 100,
      height: 90,
      child: Image.network(imgUrl),
    );
  }

  void onPressDelete() {}

  Widget _buildRowIconsInItem() {
    double timeFontSize = 14;
    double size = 20;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
            child:
                Text(uiItem.savedAt, style: TextStyle(fontSize: timeFontSize))),
        Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              iconSize: size,
              onPressed: onPressDelete,
              icon: Image(
                width: size,
                height: size,
                image: AssetImage('assets/images/delete.png'),
              ),
            )),
        Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: NewsShareIcon(
              width: size,
              height: size,
              iconSize: size,
              title: uiItem.title,
              initialUrl: uiItem.url,
            )),
      ],
    );
  }

  void onPressedCard(BuildContext context, BookmarkUIItem uiItem) async {
    var result =  await Navigator.push(
        context, MaterialPageRoute(builder: (context) =>
        NewsDetailPageRoute(
            initialUrl: uiItem.url,
            title: uiItem.title,
            isAddedBookmark: uiItem.isAddedBookmark,
            newsBookmarkDBItem: uiItem.dbItem)));

    if(!result){
      callBackUpdateList();
    }
  }

  Widget _buildTexts() {
    double titleFontSize = 18;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: <Widget>[
            Text(uiItem.title, style: TextStyle(fontSize: titleFontSize)),
            _buildRowIconsInItem()
          ],
        ),
      ),
    );
  }

  Widget _buildCardImageAndText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[_buildImage(), _buildTexts()],
    );
  }

  @override
  Widget build(BuildContext context) {
    double padding = 16;
    return GestureDetector(
        onTap: () => onPressedCard(context,uiItem),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: padding,left: padding,right:padding),
              child: _buildCardImageAndText(),
            ),
            LineWidget(Colors.grey[300])
          ],
        ));
  }
}
