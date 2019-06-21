import 'dart:async';

import 'package:flutter_qrscanner/src/providers/db.service.dart';

class ScansBloc {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    obtainScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }

  addScan(ScanModel scan) async{
    await DBProvider.db.newScan(scan);
    obtainScans();
  }

  obtainScans() async {
    _scansController.sink.add(await DBProvider.db.getAllScans());
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtainScans();
  }
  
  deleteAllScans() async {
    await DBProvider.db.getAllScans();
    obtainScans();
  }
}