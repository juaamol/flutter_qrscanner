import 'package:flutter/material.dart';
import 'package:flutter_qrscanner/src/models/scan.model.dart';
import 'package:url_launcher/url_launcher.dart';

openScan(BuildContext context, ScanModel scan) async {
  if (scan.type == 'http' || scan.type == 'https') {
    if (await canLaunch(scan.value)) {
      await launch(scan.value);
    } else {
      throw 'Could not launch ${scan.value}';
    }
  } else {
    Navigator.pushNamed(context, 'maps', arguments: scan);
  }
}
