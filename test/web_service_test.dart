// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/home/data/tab_page_generater.dart';
import 'package:flutter_news_app/home/home_page.dart';
import 'package:flutter_news_app/network/web_service.dart';
import 'package:flutter_news_app/news/data/NewsItem.dart';
import 'package:flutter_news_app/todo_list.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_news_app/main.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {

  testWidgets('WebService fetchNews test', (WidgetTester tester) async {

    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          var service = Webservice();

          //success
          service.client = MockClient((request) async {
            final mapJson = await DefaultAssetBundle.of(context).loadString(service.mappingLoadingNewsJson(KEY_TOP));
            return Response(jsonEncode(mapJson),200);


          });

          var result = service.fetchNews(KEY_TOP);
          result.then((value) =>{
             expect(value.status, "ok")
          } );

          //error
          service.client = MockClient((request) async {
            final mapJson = await DefaultAssetBundle.of(context).loadString(service.mappingLoadingNewsJson(""));
            return Response(jsonEncode(mapJson),400);


          });

          result = service.fetchNews("");
          result.catchError((error){
            expect(error!=null, true);
          });


          // The builder function must return a widget.
          return Placeholder();
        },
      ),
    );

  });


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
