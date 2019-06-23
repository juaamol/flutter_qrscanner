import 'package:flutter/material.dart';
import 'package:flutter_qrscanner/src/pages/home.page.dart';
import 'package:flutter_qrscanner/src/pages/map.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRReader',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'map': (BuildContext context) => MapPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepOrange
      ),
    );
  }
}
