import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qrscanner/secretdata/secretdata.dart';
import 'package:flutter_qrscanner/src/models/scan.model.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  MapController map = new MapController();

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
              map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: Center(
        child: _createFlutterMap(scan),
      ),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(center: scan.getLatLng(), zoom: 10),
      layers: [_createMap(), _createMarkers(scan)],
    );
  }

  _createMap() {
    Map<String, String> additionalOpts = {
      'accessToken': SecretData.mapBoxApi,
      'id': 'mapbox.streets'
    };

    return TileLayerOptions(
        urlTemplate:
            'https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: additionalOpts);
  }

  MarkerLayerOptions _createMarkers(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          height: 100,
          width: 100,
          point: scan.getLatLng(),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 70,
                  color: Theme.of(context).primaryColor,
                ),
              ))
    ]);
  }
}
