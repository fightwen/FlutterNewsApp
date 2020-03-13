import 'package:flutter/material.dart';
import 'package:flutter_news_app/style/app_colors.dart';
import 'news_card_item.dart';


class NewsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        color:AppColors.backgroundColor,
        child:NewsPageListView()
    );
  }

}

class NewsPageListView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NewsPageListViewState();
  }

}

class _NewsPageListViewState extends State<NewsPageListView>{
  Future<void> _onRefreshList() async {

  }

  ListView getListView() => ListView.builder(
      itemCount: 100,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int i) {
    return NewsCardItem();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _onRefreshList,
        child:Center(
          child: getListView(),
        ));
  }

  @override
  void initState() {
    super.initState();


  }


}




