import 'dart:io';

import 'package:flutter_qrscanner/src/models/scan.model.dart';
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

  // Create rows
  newScan(ScanModel newScan) async {
    final db = await database;
    final res = db.insert('Scans', newScan.toJson());

    return res;
  }

  // Select rows
  Future<ScanModel> getScanId(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    List<ScanModel> list = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
    return list;
  }

  Future<List<ScanModel>> getScansType(String type) async {
    final db = await database;
    final res = await db.query('Scans', where: 'type = ?', whereArgs: [type]);
    List<ScanModel> list = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
    return list;
  }
}
