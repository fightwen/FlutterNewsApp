import 'package:flutter/cupertino.dart';
import 'package:flutter_news_app/bookmark/controller/bookmark_controller.dart';
import 'package:flutter_news_app/database/news_database.dart';
import 'package:flutter_news_app/tool/md5_tool.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  BookmarkController controller = BookmarkController();
  testWidgets('BookmarkController convertDBItemToBookmarkUIItem test', (WidgetTester tester) async {
    var savedAt = DateTime(2020,3,25);
    var dbItem = NewsBookmarkDBItem(
        name: generateMd5("Global stocks are getting clobbered after Thursday's historic Wall Street rout - CNN"),
        title: "Global stocks are getting clobbered after Thursday's historic Wall Street rout - CNN",
        urlToImage: "https://cdn.cnn.com/cnnnext/dam/assets/200312182343-nyse-exterior-0312-super-tease.jpg",
        url: "https://www.cnn.com/2020/03/12/investing/stock-futures-bear-market/index.html",
        savedAt: savedAt.millisecondsSinceEpoch,
        publishedAt: "2020-03-13T08:24:50Z",
        description: "A historic wave of selling in global stock markets eased on Friday as nervous investors looked to central banks and governments for support as the economic costs of the novel coronavirus outbreak continued to mount.",
        author: "Jill Disis and Laura He, CNN Business",
        content: null);
    var uiItem = controller.convertDBItemToBookmarkUIItem(dbItem);
    expect(uiItem.savedAt == "03/25, 2020",true);
    expect(uiItem.name == generateMd5(uiItem.title),true);
    expect(uiItem.title !=null,true);
    expect(uiItem.isAddedBookmark,true);

  });

  testWidgets('BookmarkController checkOlderThanMonthBookmark test', (WidgetTester tester) async {
    var savedAt = DateTime(2020,3,25);

    var fakeCurrentTime = DateTime(2020,3,25);
    var result = controller.checkOlderThanMonthBookmark2(savedAt.millisecondsSinceEpoch,fakeCurrentTime);
    expect(result,false);

    savedAt = DateTime(2020,2,1);

    result = controller.checkOlderThanMonthBookmark2(savedAt.millisecondsSinceEpoch,fakeCurrentTime);
    expect(result,true);

    savedAt = DateTime(2019,4,28);
    result = controller.checkOlderThanMonthBookmark2(savedAt.millisecondsSinceEpoch,fakeCurrentTime);
    expect(result,true);

  });

  testWidgets('BookmarkController checkOlderThanMonthBookmark test', (WidgetTester tester) async {
    var savedAt = DateTime(2020,3,25);

    var fakeCurrentTime = DateTime(2020,3,25);
    var result = controller.checkOlderThanMonthBookmark2(savedAt.millisecondsSinceEpoch,fakeCurrentTime);
    expect(result,false);

    savedAt = DateTime(2020,2,1);

    result = controller.checkOlderThanMonthBookmark2(savedAt.millisecondsSinceEpoch,fakeCurrentTime);
    expect(result,true);

    savedAt = DateTime(2019,4,28);
    result = controller.checkOlderThanMonthBookmark2(savedAt.millisecondsSinceEpoch,fakeCurrentTime);
    expect(result,true);

    savedAt = DateTime(2021,4,28);
    result = controller.checkOlderThanMonthBookmark2(savedAt.millisecondsSinceEpoch,fakeCurrentTime);
    expect(result,false);

    savedAt = DateTime(2019,4,28);
    result = controller.checkOlderThanMonthBookmark(savedAt.millisecondsSinceEpoch);
    expect(result,true);

    savedAt = DateTime(2020,2,1);
    result = controller.checkOlderThanMonthBookmark(savedAt.millisecondsSinceEpoch);
    expect(result,true);

  });

  testWidgets('BookmarkController checkOlderThanOneWeekBookmark test', (WidgetTester tester) async {
    var savedAt = DateTime(2020,3,25);

    var fakeCurrentTime = DateTime(2020,3,25);
    var result = controller.checkOlderThanOneWeekBookmark2(savedAt.millisecondsSinceEpoch,fakeCurrentTime);
    expect(result,false);

    savedAt = DateTime(2020,2,1);

    result = controller.checkOlderThanOneWeekBookmark2(savedAt.millisecondsSinceEpoch,fakeCurrentTime);
    expect(result,true);

    savedAt = DateTime(2019,4,28);
    result = controller.checkOlderThanOneWeekBookmark2(savedAt.millisecondsSinceEpoch,fakeCurrentTime);
    expect(result,true);

    savedAt = DateTime(2020,3,17);
    result = controller.checkOlderThanOneWeekBookmark2(savedAt.millisecondsSinceEpoch,fakeCurrentTime);
    expect(result,true);

    savedAt = DateTime(2021,4,28);
    result = controller.checkOlderThanOneWeekBookmark2(savedAt.millisecondsSinceEpoch,fakeCurrentTime);
    expect(result,false);

    savedAt = DateTime(2019,4,28);
    result = controller.checkOlderThanOneWeekBookmark(savedAt.millisecondsSinceEpoch);
    expect(result,true);

    savedAt = DateTime(2020,2,1);
    result = controller.checkOlderThanOneWeekBookmark(savedAt.millisecondsSinceEpoch);
    expect(result,true);

  });






}
