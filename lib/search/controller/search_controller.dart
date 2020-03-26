

import 'dart:io';

import '../file/search_keywords_file.dart';

class SearchController {
  var file = SearchKeywordsFile();

  void saveKeywordToFile(String keywords) {
    file.writeKeywords(keywords);
  }

  Future<List<String>> readKeywordToFile() {
    return file.readKeywords();
  }

  Future<FileSystemEntity> clear(){
    return file.clearKeywords();
  }
}