///
/// @date: 8/18/21 15:23
/// @author: kevin
/// @description: dart
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._interval();

  static final DatabaseHelper _instance = DatabaseHelper._interval();

  static DatabaseHelper get instance {
    return _instance;
  }

  Database? _db;

  Database? get db => _db;

  initialDatabase() async {
// Construct a file path to copy database to
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();

    Directory? sdCard = await getExternalStorageDirectory();

    print(sdCard?.path);

    String path = join(sdCard!.path, "county.sqlite");

    print(path);
// Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assets', 'county.sqlite'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }

    this._db = await openDatabase(path);

    var result = await _db!.query(
      'country',
      // columns: ['id', 'short_name'],
      where: 'id >= ?',
      whereArgs: [
        100,
      ],
    );

    print(result);
  }
}
