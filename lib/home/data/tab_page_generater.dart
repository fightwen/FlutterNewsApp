



import 'package:flutter/cupertino.dart';
import 'package:flutter_news_app/generated/i18n.dart';

const String KEY_TOP = "top";
const String KEY_BUSINESS = "business";
const String KEY_ENTERTAINMENT = "entertainment";
const String KEY_HEALTH = "health";
const String KEY_SCIENCE = "science";
const String KEY_SPORTS = "sports";
const String KEY_TECHNOLOGY = "technology";

class TabFullPageGenerater{

  static List<TabInfo> getTabInfos(BuildContext context){
    List<TabInfo> tabInfos = [
      TabInfo(key:KEY_TOP,title:S.of(context).top),
      TabInfo(key:KEY_BUSINESS,title:S.of(context).business),
      TabInfo(key:KEY_ENTERTAINMENT,title:S.of(context).entertainment),
      TabInfo(key:KEY_HEALTH,title:S.of(context).health),
      TabInfo(key:KEY_SCIENCE,title:S.of(context).science),
      TabInfo(key:KEY_SPORTS,title:S.of(context).sports),
      TabInfo(key:KEY_TECHNOLOGY,title:S.of(context).technology),
    ];
    return tabInfos;
  }


}

class TabInfo{
  String mKey;
  String mTitle;
  TabInfo({@required String key,@required String title}){
    mKey = key;
    mTitle = title;
  }

}