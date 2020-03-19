

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NewsDatabase{

  void init() async {
    final Future<Database> database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'news_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE news(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );



    Future<void> insertDog(Dog dog) async {
      // Get a reference to the database.
      final Database db = await database;

      // Insert the Dog into the correct table. Also specify the
      // `conflictAlgorithm`. In this case, if the same dog is inserted
      // multiple times, it replaces the previous data.
      await db.insert(
        'dogs',
        dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<List<Dog>> dogs() async {
      // Get a reference to the database.
      final Database db = await database;

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('dogs');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(maps.length, (i) {
        return Dog(
          id: maps[i]['id'],
          name: maps[i]['name'],
          age: maps[i]['age'],
        );
      });
    }

    Future<void> updateDog(Dog dog) async {
      // Get a reference to the database.
      final db = await database;

      // Update the given Dog.
      await db.update(
        'dogs',
        dog.toMap(),
        // Ensure that the Dog has a matching id.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [dog.id],
      );
    }

    Future<void> deleteDog(int id) async {
      // Get a reference to the database.
      final db = await database;

      // Remove the Dog from the database.
      await db.delete(
        'dogs',
        // Use a `where` clause to delete a specific dog.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
    }


  }

}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}