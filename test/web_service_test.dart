// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter/material.dart';
import 'package:flutter_news_app/home/data/tab_page_generater.dart';
import 'package:flutter_news_app/home/home_page.dart';
import 'package:flutter_news_app/news/data/NewsItem.dart';
import 'package:flutter_news_app/newwork/web_service.dart';
import 'package:flutter_news_app/todo_list.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_news_app/main.dart';

void main() {
  testWidgets('WebService getNewsItemListFile test', (WidgetTester tester) async {

    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          var service = Webservice();

          //KEY_TOP
          Future<NewsItem> result = service.getNewsItemListFile(context,KEY_TOP);
          result.then((data) => {
             expect(data!= null && data.articles.length == data.totalResults, true)
          });

          result.then((data) => {
            expect(data!= null && data.status == "ok", true)
          });

          //KEY_BUSINESS
          result = service.getNewsItemListFile(context,KEY_BUSINESS);
          result.then((data) => {
            expect(data!= null && data.articles.length == data.totalResults, true)
          });

          result.then((data) => {
            expect(data!= null && data.status == "ok", true)
          });

          //error
          result = service.getNewsItemListFile(context,"");
          result.then((data) => {
            expect(data == null, true)
          });

          // The builder function must return a widget.
          return Placeholder();
        },
      ),
    );

  });

  test('mappingLoadingNewsJson', () {
    var service = Webservice();
    String result = service.mappingLoadingNewsJson(KEY_BUSINESS);
    expect(result, "assets/texts/newItemsBusiness.json");

    result = service.mappingLoadingNewsJson(KEY_ENTERTAINMENT);
    expect(result, "assets/texts/newItemsEntertainment.json");

    result = service.mappingLoadingNewsJson(KEY_HEALTH);
    expect(result, "assets/texts/newItemsHealth.json");

    result = service.mappingLoadingNewsJson(KEY_SCIENCE);
    expect(result, "assets/texts/newItemsScience.json");

    result = service.mappingLoadingNewsJson(KEY_SPORTS);
    expect(result, "assets/texts/newItemsSports.json");

    result = service.mappingLoadingNewsJson(KEY_TECHNOLOGY);
    expect(result, "assets/texts/newItemsTechnology.json");
  });

}
