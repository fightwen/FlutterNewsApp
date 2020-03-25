import 'package:flutter/material.dart';
import 'package:flutter_news_app/bookmark/bookmark_card_item.dart';
import 'package:flutter_news_app/database/news_database.dart';
import 'package:flutter_news_app/views/network_error_widget.dart';

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

  Widget _buildEmptyView(){
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Icon(Icons.note_add,size:150,color: Colors.grey[400],),
      Text("Empty list",style: TextStyle(fontSize: 18),)
    ],) );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<List<BookmarkUIItem>>(
              future: controller.fetchBookmarkList(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return NetworkErrorWidget();
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }

                return snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data.length != 0
                    ? getListView(snapshot.data.length, snapshot.data)
                    : _buildEmptyView();
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: _buildPopMenuButton(),
      ),
    );
  }

  void clearOlderThanOneWeekAndUpdateList() async{
    var result = await controller.clearOlderThanOneWeek();
    if(result){
      setState(() {});
    }
  }

  void clearOlderThanMonthAndUpdateList() async{
    var result = await controller.clearOlderThanMonth();
    if(result){
      setState(() {});
    }
  }

  void clearAllAndUpdateList() {
    var result = controller.clearAllBookmarkList();
    result.whenComplete(() => {
      setState(() {})
    });
  }

  Widget _buildPopMenuButton() {
    return PopupMenuButton(
      onSelected: (value){
        switch (value){
          case 1:
            clearAllAndUpdateList();
            break;
          case 2:
            clearOlderThanOneWeekAndUpdateList();
            break;
          case 3:
            clearOlderThanMonthAndUpdateList();
            break;

        }

      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text("Clear All"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Older than 1 week"),
        ),
        PopupMenuItem(
          value: 3,
          child: Text("Older than 1 month"),
        ),
      ],
      offset: Offset(80, -180),
      icon: Image(
        width: 20,
        height: 20,
        image:  AssetImage('assets/images/trash_icon.png') ,),
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
