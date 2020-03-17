import 'package:flutter/material.dart';
import 'package:flutter_news_app/newwork/web_service.dart';
import 'package:flutter_news_app/style/app_colors.dart';
import 'data/NewsItem.dart';
import 'news_card_item.dart';


class NewsPage extends StatelessWidget{
  String qkey;
  NewsPage({this.qkey});

  @override
  Widget build(BuildContext context) {
    print("gggg NewsPageListView "+qkey);
    return Container(
        color:AppColors.backgroundColor,
        child:NewsPageListView(qkey: qkey)
    );
  }

}

class NewsPageListView extends StatefulWidget{

  String qkey;

  NewsPageListView({this.qkey});

  @override
  State<StatefulWidget> createState() {
    return _NewsPageListViewState(qkey: qkey);
  }

}

class _NewsPageListViewState extends State<NewsPageListView>{

  String qkey;

  _NewsPageListViewState({this.qkey});

  Future<void> _onRefreshList() async {
    setState(() {

    });
  }

  ListView getListView(List<Articles> list) => ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(list[position]);
      });

  Widget getRow(Articles item) {
    return NewsCardItem(item);
  }

  @override
  Widget build(BuildContext context) {
    var service = Webservice();
    return RefreshIndicator(
        onRefresh: _onRefreshList,
        child:Center(
          child: FutureBuilder<NewsItem>(
              future:service.getNewsItemList(context,qkey),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? getListView(snapshot.data.articles)
                    : Center(child: CircularProgressIndicator());
              }
          ),
        ));
  }

}




