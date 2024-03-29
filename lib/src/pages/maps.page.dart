import 'package:flutter/material.dart';
import 'package:flutter_qrscanner/src/bloc/scans.bloc.dart';
import 'package:flutter_qrscanner/src/models/scan.model.dart';
import 'package:flutter_qrscanner/src/utils/scans.util.dart' as utils;

class MapsPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.obtainScans();

    return StreamBuilder(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(
            child: Text('No data'),
          );
        }

        return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (BuildContext context, int i) => Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) => scansBloc.deleteScan(scans[i].id),
                  child: ListTile(
                    onTap: () => utils.openScan(context, scans[i]),
                    leading: Icon(Icons.map,
                        color: Theme.of(context).primaryColor),
                    title: Text(scans[i].value),
                    subtitle: Text('ID: ${scans[i].id}'),
                    trailing:
                        Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  ),
                ));
      },
    );
  }
}
