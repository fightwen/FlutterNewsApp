import 'package:flutter/material.dart';
import 'package:flutter_news_app/bookmark/bookmark_card_item.dart';
import 'package:flutter_news_app/database/news_database.dart';
import 'package:flutter_news_app/views/network_error_widget.dart';

import 'bookmark_inheritedwidget.dart';
import 'controller/bookmark_controller.dart';
import 'data/bookmark_ui_item.dart';

class BookmarkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookmarkPageState();
  }
}

class _BookmarkPageState extends State<BookmarkPage> {
  BookmarkController controller = BookmarkController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<List<BookmarkUIItem>>(
              future: controller.fetchBookmarkList(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return NetworkErrorWidget();
                return snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data.length != 0
                    ? getListView(snapshot.data.length, snapshot.data)
                    : Center(child: CircularProgressIndicator());
              })),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.remove),
      ),
    );
  }

  ListView getListView(int length, List<BookmarkUIItem> list) {
    return ListView.builder(
        itemCount: length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(list[position]);
        });
  }

  Widget getRow(BookmarkUIItem uiItem) {
    return BookmarkCardItem(uiItem, () {
      setState(() {});
    });
  }
}
