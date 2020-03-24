

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NewsDatabase{
  static String TABLE_NAME = "news";
  static Future<Database> database;

  static void init() async {
    database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'news_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE " + TABLE_NAME + "(name TEXT PRIMARY KEY, savedAt INTEGER, title TEXT,"
              " urlToImage TEXT, url TEXT, publishedAt TEXT, description TEXT, content TEXT, author TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

  }

  static Future<void> insertNews(NewsBookmarkDBItem newsBookmarkItem) async {
    if(database == null){
      init();
    }


    // Get a reference to the database.
    final Database db = await database;

    // Insert the NewsBookmarkItem into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      TABLE_NAME,
      newsBookmarkItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print("db insert GGGG "+newsBookmarkItem.name);
  }

  static Future<List<NewsBookmarkDBItem>> news() async {
    if(database == null){
      init();
    }


    // Get a reference to the database.
    final Database db = await database;

    if(db == null)
      return null;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

    if(maps == null)
      return null;

    // Convert the List<Map<String, dynamic> into a List<NewsBookmarkItem>.
    return List.generate(maps.length, (i) {
      return NewsBookmarkDBItem(
        name: maps[i]['name'],
        title: maps[i]['title'],
        urlToImage: maps[i]['urlToImage'],
        url: maps[i]['url'],
        savedAt: maps[i]['savedAt'],
        description: maps[i]['description'],
        author: maps[i]['author'],
        content: maps[i]['content'],
      );
    });
  }

  static Future<List<String>> newsNames() async {
    if(database == null){
      init();
    }


    // Get a reference to the database.
    final Database db = await database;

    if(db == null)
      return null;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

    if(maps == null)
      return null;

    // Convert the List<Map<String, dynamic> into a List<NewsBookmarkItem>.
    return List.generate(maps.length, (i) {
      return maps[i]['name'];
    });
  }

  static Future<void> updateNews(NewsBookmarkDBItem newsBookmarkItem) async {
    if(database == null){
      init();
    }

    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      TABLE_NAME,
      newsBookmarkItem.toMap(),
      // Ensure that the Dog has a matching id.
      where: "name = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [newsBookmarkItem.name],
    );
  }

  static Future<void> deleteNews(String name) async {
    if(database == null){
      init();
    }

    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      TABLE_NAME,
      // Use a `where` clause to delete a specific dog.
      where: "name = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [name],
    );
  }

}

class NewsBookmarkDBItem {
  final String name;
  final String title;
  final String urlToImage;
  final String url;
  final String publishedAt;
  final String description;
  final String content;
  final String author;
  final int savedAt;

  NewsBookmarkDBItem({
    this.name,
    this.title,
    this.urlToImage,
    this.url,
    this.savedAt,
    this.publishedAt,
    this.description,
    this.author,
    this.content});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'urlToImage': urlToImage,
      'savedAt': savedAt,
      'url': url,
      'publishedAt': publishedAt,
      'description': description,
      'author': author,
      'content': content,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'NewsBookmarkItem{ name: $name, title: $title, urlToImage: $urlToImage, savedAt: $savedAt, url: $url, publishedAt: $publishedAt,description: $description, content: $content, author: $author}';
  }
}