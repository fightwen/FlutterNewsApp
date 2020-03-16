import 'package:flutter/material.dart';

import 'news/news_page.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _HomePageState();
  }

}

class TabFullPageGenerater{
  List<String> titles = ["Top","Business","Entertainment","Health","Science","Sports","Technology"];
  List<String> keys = ["top","business","entertainment","health","science","sports","technology"];
  TabFullPageGenerater(){

  }

  List<TabInfo> getTabInfo(){
    List<TabInfo> tabs =List<TabInfo>();
    for(int i = 0;i< keys.length;i++){
      TabInfo info = TabInfo(keys[i],titles[i]);
      tabs.add(info);
    }
    return tabs;
  }


   List<Tab> getTabFullPages(){
     List<Tab> tabs =[];
     for(int i = 0;i< titles.length;i++){
       tabs.add(Tab(child: Text(titles[i],style: TextStyle(color:Colors.black))));
     }

    return tabs;
  }
}

class TabInfo{
  String mKey;
  String mTitle;
  TabInfo(String key,String title){
    mKey = key;
    mTitle = title;
  }

}

class _HomePageState extends State<HomePage> {
  TabFullPageGenerater tabFullPageGenerater = TabFullPageGenerater();
  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = tabFullPageGenerater.getTabFullPages();
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
          children: tabs.map((Tab tab) {
            return NewsPage();
          }).toList()

        ,
        ),
      ),

    );
  }

}