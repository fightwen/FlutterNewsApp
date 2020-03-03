import 'package:flutter/material.dart';
import 'news_card_item.dart';


class NewsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NewsPageState();
  }

}

class _NewsPageState extends State<NewsPage> {
  Future<void> _onRefreshList() async{

  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color:Colors.grey[200],
        child:RefreshIndicator(
            onRefresh: _onRefreshList,
            child:Center(
            child: getListView(),
        ))
    );
  }

  ListView getListView() => ListView.builder(
      itemCount: 100,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int i) {
    return NewsCardItem();
  }

}



