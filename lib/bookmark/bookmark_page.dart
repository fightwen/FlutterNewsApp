import 'package:flutter/material.dart';
import 'package:flutter_news_app/bookmark/bookmark_card_item.dart';


class BookmarkPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BookmarkPageState();
  }

}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child:
          getListView(),
        ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.remove),
      ),

    );
  }

  ListView getListView() => ListView.builder(
      itemCount: 100,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int i) {
    return BookmarkCardItem();
  }

}