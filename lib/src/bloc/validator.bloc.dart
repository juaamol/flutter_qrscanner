import 'dart:async';

import 'package:flutter_qrscanner/src/models/scan.model.dart';

class Validator {
  final validateGeolocation = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      final geoScans = scans.where((s) => s.type == 'geo').toList();
      sink.add(geoScans);
    }
  );
  final validateHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      final geoScans = scans.where((s) => s.type == 'http' || s.type == 'https').toList();
      sink.add(geoScans);
    }
  );
}