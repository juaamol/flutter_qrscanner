import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._private();

  DBProvider._private();

  get database async {
    if (_database != null) {
      return db;
    }

    _database = await initDB();
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'scansdb.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      final sql =
          'CREATE TABLE Scans(id INTEGER PRIMARY KEY, type TEXT, value TEXT)';
      await db.execute(sql);
    });
  }
}
