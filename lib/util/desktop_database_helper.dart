/// @create at 8/20/21 15:16
/// @create by kevin
/// @desc
///
///
///
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DesktopDatabaseHelper {
  DesktopDatabaseHelper._interval();

  static final DesktopDatabaseHelper _instance = DesktopDatabaseHelper._interval();

  static DesktopDatabaseHelper get instance {
    return _instance;
  }

  Database? _db;

  Database? get db => _db;

  /// 初始化
  initialDatabase() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    print(tempPath);
    print(appDocPath);

    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    var path = join(tempPath, "county.sqlite");
    print(path);
    var exists = await databaseFactory.databaseExists(path);
    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      // Copy from asset
      ByteData data = await rootBundle.load('assets/county.sqlite');
      print(join('assets', 'county.sqlite'));
      // ByteData data = await rootBundle.load(join('assets','express.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    // open the database
    this._db = await databaseFactory.openDatabase(path);
    print(path);
  }
}
