

import 'package:flutter/cupertino.dart';

const String KEY_TOP = "top";
const String KEY_BUSINESS = "business";
const String KEY_ENTERTAINMENT = "entertainment";
const String KEY_HEALTH = "health";
const String KEY_SCIENCE = "science";
const String KEY_SPORTS = "sports";
const String KEY_TECHNOLOGY = "technology";

class TabFullPageGenerater{

  static List<TabInfo> tabInfos = [
    TabInfo(key:KEY_TOP,title:"Top"),
    TabInfo(key:KEY_BUSINESS,title:"Business"),
    TabInfo(key:KEY_ENTERTAINMENT,title:"Entertainment"),
    TabInfo(key:KEY_HEALTH,title:"Health"),
    TabInfo(key:KEY_SCIENCE,title:"Science"),
    TabInfo(key:KEY_SPORTS,title:"Sports"),
    TabInfo(key:KEY_TECHNOLOGY,title:"Technology"),
  ];

}

class TabInfo{
  String mKey;
  String mTitle;
  TabInfo({@required String key,@required String title}){
    mKey = key;
    mTitle = title;
  }

}