import 'package:flutter/material.dart';
import 'package:flutter_news_app/newwork/web_service.dart';
import 'package:flutter_news_app/style/app_colors.dart';
import 'data/NewsItem.dart';
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
  List<ArticlesBean> _list = List<ArticlesBean>();
  Future<void> _onRefreshList() async {

  }

  ListView getListView() => ListView.builder(
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int i) {
    return NewsCardItem(_list[i]);
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
    Future<NewsItem> newsItem = Webservice().getPokemonsList(context);

    setState(() {
      newsItem.then((value) => _list = value.articles);
    });

  }


}




