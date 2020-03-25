import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SearchKeywordsFile{
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/search_keywords.json');
  }

  Future<File> writeKeywords(String keywords) async {
    final file = await _localFile;

    // Write the file.
    return file.writeAsString('$keywords');
  }

  Future<List<String>> readKeywords() async {
    try {
      final file = await _localFile;

      // Read the file.
      String keywords = await file.readAsString();

      return int.parse(keywords);
    } catch (e) {
      // If encountering an error, return 0.
      return List<String>();
    }
  }
}