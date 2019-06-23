import 'package:flutter/material.dart';
import 'package:flutter_qrscanner/src/models/scan.model.dart';

class MapPage extends StatefulWidget {

  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
       appBar: AppBar(
         title: Text('Coordinates QR'),
         actions: <Widget>[
           IconButton(
             icon: Icon(Icons.my_location),
             onPressed: () {

             },
           )
         ],
       ),
       body: Center(
         child: Text(scan.value),
       ),
    );
  }
}