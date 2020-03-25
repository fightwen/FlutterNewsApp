import 'package:flutter_news_app/bookmark/data/bookmark_ui_item.dart';
import 'package:flutter_news_app/database/news_database.dart';
import 'package:intl/intl.dart';

class BookmarkController{

  BookmarkUIItem convertDBItemToBookmarkUIItem(NewsBookmarkDBItem dbItem){
    var date = new DateTime.fromMillisecondsSinceEpoch(dbItem.savedAt);
    String time = DateFormat("MM/dd, yyyy").format(date);

    var uiItem = BookmarkUIItem(
        name:dbItem.name,
        title: dbItem.title == null?"": dbItem.title,
        savedAt: time,
        urlToImage: dbItem.urlToImage,
        url: dbItem.url,
        isAddedBookmark: true,
        dbItem: dbItem);
    return uiItem;
  }

  Future<List<BookmarkUIItem>> fetchBookmarkList() async{
    List<BookmarkUIItem> bookmarkItems = List<BookmarkUIItem>();
    List<NewsBookmarkDBItem> items = await NewsDatabase.news();

    for (var value in items) {
      var item = convertDBItemToBookmarkUIItem(value);
      bookmarkItems.add(item);
    }

    return bookmarkItems;
  }


  Future<bool> clearAllBookmarkList() async{
    bool result = await NewsDatabase.deleteAll();
    return result;
  }

  Future<bool> clearOlderThanOneWeek() async{
    bool isDeleted = false;
    List<NewsBookmarkDBItem> list = await NewsDatabase.news();
    for (var value in list) {
      if(checkOlderThanOneWeekBookmark(value.savedAt)){
        NewsDatabase.deleteNews(value.name);
        isDeleted = true;
      }
    }
    return isDeleted;
  }

  Future<bool> clearOlderThanMonth() async{
    bool isDeleted = false;
    List<NewsBookmarkDBItem> list = await NewsDatabase.news();
    for (var value in list) {
      if(checkOlderThanMonthBookmark(value.savedAt)){
        NewsDatabase.deleteNews(value.name);
        isDeleted = true;
      }
    }
    return isDeleted;
  }

  bool checkOlderThanOneWeekBookmark(int saveTime){
    DateTime currentDateTime = DateTime.now();
    int currentMonth = currentDateTime.month;
    int currentYear = currentDateTime.year;
    int currentDay = currentDateTime.day;
    DateTime savedDateTime = DateTime.fromMillisecondsSinceEpoch(saveTime);
    int savedMonth = savedDateTime.month;
    int savedYear = savedDateTime.year;
    int savedDay = savedDateTime.day;

    if(savedYear < currentYear){
      return true;
    }

    if(savedMonth <currentMonth){
      return true;
    }

    if(currentDay - savedDay > 7){
      return true;
    }

    return false;
  }

  bool checkOlderThanMonthBookmark(int saveTime){
    DateTime currentDateTime = DateTime.now();
    int currentMonth = currentDateTime.month;
    int currentYear = currentDateTime.year;
    DateTime savedDateTime = DateTime.fromMillisecondsSinceEpoch(saveTime);
    int savedMonth = savedDateTime.month;
    int savedYear = savedDateTime.year;

    if(savedYear < currentYear){
      return true;
    }

    if(savedMonth <currentMonth){
      return true;
    }

    return false;
  }
}