import 'package:flutter/material.dart';
import 'package:flutter_news_app/network/web_service.dart';
import 'package:flutter_news_app/news/controller/news_controller.dart';
import 'package:flutter_news_app/style/app_colors.dart';
import 'package:flutter_news_app/views/network_error_widget.dart';
import 'data/news_article_ui_listInfo.dart';
import 'news_bookmark_inheritedwidget.dart';
import 'data/news_item.dart';
import 'data/news_ui_item.dart';
import 'news_card_item.dart';


class NewsPage extends StatelessWidget{
  String qkey;
  NewsPage({this.qkey});

  @override
  Widget build(BuildContext context) {
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
  var controller = NewsController();

  _NewsPageListViewState({this.qkey});

  Future<void> _onRefreshList() async {
    setState(() {

    });
  }

  ListView getListView(BuildContext context,int size,bool isTextOnly) => ListView.builder(
      itemCount: size,
      itemBuilder: (BuildContext context, int position) {
        return getRow(NewsBookmarkInheritedWidget.of(context).getItem(position),position,isTextOnly);
      });

  Widget getRow(NewsArticleUIItem item,int position,bool isTextOnly) {
    if(item!=null){
      if(position == 0){
        return NewsCardItem(item,false);
      }
      return NewsCardItem(item,isTextOnly);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _onRefreshList,
        child: Center(
          child: FutureBuilder<NewsArticleUIListInfo>(
              future: controller.getNewsArticleUIItemList(context, qkey),
              builder: (context, snapshot) {
                if (snapshot.hasError) return NetworkErrorWidget();
                return snapshot.hasData && snapshot.data != null &&
                    snapshot.data.newsArticleUIItemList.length != 0
                    ? NewsBookmarkInheritedWidget(
                    list: snapshot.data.newsArticleUIItemList,
                    child: getListView(
                        context, snapshot.data.newsArticleUIItemList.length,
                        snapshot.data.isTextOnly))
                    : Center(child: CircularProgressIndicator());
              }
          ),
        ));
  }

}




