import 'package:flutter_news_app/bookmark/data/bookmark_ui_item.dart';
import 'package:flutter_news_app/database/news_database.dart';
import 'package:intl/intl.dart';

class BookmarkController{
  //TODO need fix!!
  BookmarkUIItem convertDBItemToBookmarkUIItem(NewsBookmarkDBItem dbItem){
//    DateTime date = DateTime(dbItem.savedAt);
//    String time = DateFormat("Saved on MM月 dd, yyyy").format(date);

    var uiItem = BookmarkUIItem(
        name:dbItem.name,
        title: dbItem.title == null?"": dbItem.title,
        savedAt: "",
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
}