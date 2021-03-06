import 'package:flutter/material.dart';
import 'package:flutter_news_app/bookmark/bookmark_card_item.dart';
import 'package:flutter_news_app/database/news_database.dart';
import 'package:flutter_news_app/generated/i18n.dart';
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
  // the GlobalKey is needed to animate the list
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<BookmarkUIItem> _globalListData = List<BookmarkUIItem>();

  Widget _buildEmptyView(){
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Icon(Icons.note_add,size:150,color: Colors.grey[400],),
      Text(S.of(context).no_stories,style: TextStyle(fontSize: 18),)
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
                _globalListData.addAll(snapshot.data);

                return snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data.length != 0
                    ? getListView(_globalListData.length, _globalListData)
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
          child: Text(S.of(context).clear_all),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(S.of(context).older_than_1_week),
        ),
        PopupMenuItem(
          value: 3,
          child: Text(S.of(context).older_than_1_month),
        ),
      ],
      offset: Offset(80, -180),
      icon: Image(
        width: 20,
        height: 20,
        image:  AssetImage('assets/images/trash_icon.png') ,),
    );
  }


  AnimatedList getListView(int length, List<BookmarkUIItem> list) {
    return AnimatedList(
        key: _listKey,
        initialItemCount: length,
        itemBuilder: (BuildContext context, int position,animation) {
          return _buildItem(animation,position,list[position]);
        });
  }

  Widget _buildItem(Animation animation,int index,BookmarkUIItem uiItem){
    return SizeTransition(
      sizeFactor: animation,
      child: getRow(uiItem,index),);
  }

  Widget getRow(BookmarkUIItem uiItem,int index) {
    return BookmarkCardItem(uiItem,index, (removeIndex,removeUiItem) {
      _globalListData.removeAt(removeIndex);
      AnimatedListRemovedItemBuilder builder = (context, animation) {
        // A method to build the Card widget.
        return _buildItem(animation,removeIndex,removeUiItem);
      };
      _listKey.currentState.removeItem(removeIndex, builder);
    });
  }
}
