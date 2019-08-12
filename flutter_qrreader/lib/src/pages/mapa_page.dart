//file:mapa_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_qrreader/src/models/scan_model.dart';

class MapaPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ScanModel oScan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Coordenadas QR"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){},
          )
        ],
      ),

      body: Center(
        child: Text(oScan.valor),
      )

    );
  }

}