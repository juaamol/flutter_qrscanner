import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_qrscanner/src/bloc/scans.bloc.dart';
import 'package:flutter_qrscanner/src/models/scan.model.dart';
import 'package:flutter_qrscanner/src/pages/locations.page.dart';
import 'package:flutter_qrscanner/src/pages/maps.page.dart';
import 'package:flutter_qrscanner/src/utils/scans.util.dart' as utils;
import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.deleteAllScans,
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _createBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Maps')),
        BottomNavigationBarItem(
            icon: Icon(Icons.directions), title: Text('Locations'))
      ],
    );
  }

  Widget _callPage(int actualPage) {
    switch (actualPage) {
      case 0:
        return MapsPage();
      case 1:
        return LocationsPage();
      default:
        return MapsPage();
    }
  }

  void _scanQR() async {
    // https://github.com/juaamol/flutter_qrscanner
    // geo:40.714865545932355,-73.96474256953127
    String futureString = 'https://github.com/juaamol/flutter_qrscanner';

    // try {
    //   futureString = await new QRCodeReader().scan();
    // } catch(e) {
    //   futureString = e.toString();
    // }

    if (futureString != null) {
      final newScan = ScanModel(value: futureString);
      scansBloc.addScan(newScan);

      final newScan2 = ScanModel(value: 'geo:40.714865545932355,-73.96474256953127');
      scansBloc.addScan(newScan2);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750));
      }
      utils.openScan(newScan);
      print('???');
    }
  }
}
