import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/news/news_detail_page.dart';
import 'package:flutter_news_app/news/news_share_icon.dart';
import 'package:flutter_news_app/views/line_widget.dart';
import 'package:path/path.dart';

import '../database/news_database.dart';
import 'data/bookmark_ui_item.dart';

class BookmarkCardItem extends StatelessWidget {
  BookmarkUIItem uiItem;
  Function(int,BookmarkUIItem) callBackUpdateList;
  int index = 0;

  BookmarkCardItem(this.uiItem,this.index,this.callBackUpdateList);

  Widget _buildImage() {
    String imgUrl = uiItem.urlToImage == null?'https://rent.dyu.edu.tw/Picture/00/0.jpg':uiItem.urlToImage;
    return Container(
      alignment: Alignment.topLeft,
      width: 100,
      height: 90,
      child: Image.network(imgUrl),
    );
  }



  Widget _buildRowIconsInItem(BuildContext context) {
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
              onPressed: (){
                _neverSatisfied(context,uiItem.name);
              },
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

  Future<void> _neverSatisfied(BuildContext context,String name) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Article'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to '),
                Text('remove this article?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),FlatButton(
              child: Text('Remove'),
              onPressed: () {
                NewsDatabase.deleteNews(name);
                callBackUpdateList(index,uiItem);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
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
      callBackUpdateList(index,uiItem);
    }
  }

  Widget _buildTexts(BuildContext context) {
    double titleFontSize = 18;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: <Widget>[
            Text(uiItem.title, style: TextStyle(fontSize: titleFontSize)),
            _buildRowIconsInItem(context)
          ],
        ),
      ),
    );
  }

  Widget _buildCardImageAndText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[_buildImage(), _buildTexts(context)],
    );
  }

  @override
  Widget build(BuildContext context) {
    double padding = 16;
    return InkWell(
        onTap: () => onPressedCard(context,uiItem),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: padding,left: padding,right:padding),
              child: _buildCardImageAndText(context),
            ),
            LineWidget(Colors.grey[300])
          ],
        ));
  }
}
