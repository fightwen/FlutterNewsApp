

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_app/search/file/search_keywords_file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var searchKeywordsFile = SearchKeywordsFile();
  WidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Create a temporary directory.
    final directory = await Directory.systemTemp.createTemp();

    // Mock out the MethodChannel for the path_provider plugin.
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      // If you're getting the apps documents directory, return the path to the
      // temp directory on the test environment instead.
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return directory.path;
      }
      return null;
    });
  });


  test('SearchKeywordsFile writeKeywords and readKeywords test',()  async{


    File result  = await  searchKeywordsFile.writeKeywords("GG");
    print("test writeKeywords!!!"+(result!=null).toString());

    List<dynamic> list =await searchKeywordsFile.readKeywords();
    expect(list[0], "GG");

    await  searchKeywordsFile.writeKeywords("KK");
    list = await searchKeywordsFile.readKeywords();
    expect(list[0], "GG");
    expect(list[1], "KK");


  });

}