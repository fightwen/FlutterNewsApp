import 'dart:async';
import 'dart:convert';
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
    List<String> list = await readKeywords();
    list.add(keywords);
    String jsonString = jsonEncode(list);
    // Write the file.
    return file.writeAsString('$jsonString');
  }

  Future<List<String>> readKeywords() async {
    try {
      final file = await _localFile;

      // Read the file.
      String keywords = await file.readAsString();
      List<String> result = (jsonDecode(keywords)as List<dynamic>).cast<String>();

      return result;
    } catch (e) {
      // If encountering an error, return 0.
      return List<String>();
    }
  }

  Future<FileSystemEntity> clearKeywords() async {
      final file = await _localFile;
      return file.delete();
  }
}