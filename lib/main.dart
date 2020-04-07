import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:developer' as developer;

import 'bookmark/bookmark_page.dart';
import 'database/news_database.dart';
import 'generated/i18n.dart';
import 'home/home_page.dart';
import 'search/search_page.dart';
import 'setting/settings_page.dart';

void main() => runApp(NewsApp());


class NewsApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    NewsDatabase.init();

    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: "News",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Builder(
        builder: (BuildContext context) {
          return Localizations.override(
            context: context,
            locale: Localizations.localeOf(context),
            child: MyHomePage(title: S.of(context).title),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const double _iconSize = 30;
  final pages = [HomePage(), SearchPage(), BookmarkPage(), SettingsPage()];

  List<String> getPageTitle(BuildContext context){
    return [S.of(context).title, S.of(context).search, S.of(context).saved_stories, S.of(context).settings];
  }


  void _onItemTapped(int index) {
    setState(() {
      widget.title = getPageTitle(context)[index];
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center( child: Text(widget.title)), elevation: 0.0
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: _iconSize,),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,size: _iconSize,),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark,size: _iconSize,),
            title: Text('Bookmark'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,size: _iconSize,),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),

    );
  }
}
