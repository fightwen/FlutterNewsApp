import 'package:flutter/material.dart';
import 'package:flutter_news_app/network/web_service.dart';
import 'package:flutter_news_app/style/app_colors.dart';
import 'package:flutter_news_app/views/network_error_widget.dart';
import 'data/NewsItem.dart';
import 'data/NewsUIItem.dart';
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

  ListView getListView(List<NewsArticleUIItem> list) => ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(list[position]);
      });

  Widget getRow(NewsArticleUIItem item) {
    if(item!=null){
      return NewsCardItem(item:item);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    var service = Webservice();
    return RefreshIndicator(
        onRefresh: _onRefreshList,
        child:Center(
          child: FutureBuilder<List<NewsArticleUIItem>>(
              future:service.getNewsArticleUIItemList(context,qkey),
              builder: (context, snapshot) {
                print("data!!!!"+(snapshot.data!=null).toString());
                if(snapshot.data!=null){
                  print("data length !!!!"+(snapshot.data.length).toString());
                }

                if (snapshot.hasError) return NetworkErrorWidget();
                return snapshot.hasData && snapshot.data!=null && snapshot.data.length !=0
                    ? getListView(snapshot.data)
                    : Center(child: CircularProgressIndicator());
              }
          ),
        ));
  }

}




