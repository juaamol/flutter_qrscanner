import 'package:flutter/material.dart';
import 'package:flutter_qrscanner/src/pages/locations.page.dart';
import 'package:flutter_qrscanner/src/pages/maps.page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () {},
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
        BottomNavigationBarItem(
            icon: Icon(Icons.map), title: Text('Locations')),
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Locations'))
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
}
