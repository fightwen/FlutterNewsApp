import 'package:flutter/material.dart';

import 'news/news_page.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _HomePageState();
  }

}

class TabFullPageGenerater{
   List<Tab> getTabFullPages(){
     List<Tab> tabs =[];
     List<String> titles = ["推薦","前端","後端","Android","iOS","人工智能","開發工具","代碼人生","閱讀"];

     for(int i = 0;i< titles.length;i++){
       tabs.add(Tab(child: Text(titles[i],style: TextStyle(color:Colors.black))));
     }

    return tabs;
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
            return new NewsPage();
          }).toList()

        ,
        ),
      ),

    );
  }

}