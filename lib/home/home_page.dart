import 'package:flutter/material.dart';

import '../news/news_page.dart';
import 'data/tab_page_generater.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _HomePageState();
  }

}

List<Tab> getTabFullPages(List<TabInfo> tabInfos){
  List<Tab> tabs =[];
  for(int i = 0;i< tabInfos.length;i++){
    tabs.add(Tab(child: Text(tabInfos[i].mTitle,style: TextStyle(color:Colors.black))));
  }

  return tabs;
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    List<TabInfo> tabInfos = TabFullPageGenerater.tabInfos;
    List<Tab> tabs = getTabFullPages(tabInfos);
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor:Colors.red,
          isScrollable:true,
          tabs: tabs,
        ),
        body: TabBarView(
          children: tabInfos.map((TabInfo info) {
            if(info.mKey!=null){
              return NewsPage(qkey:info.mKey);
            }else{
              return Center(child: Icon(Icons.not_interested),);
            }

          }).toList()

        ,
        ),
      ),

    );
  }

}