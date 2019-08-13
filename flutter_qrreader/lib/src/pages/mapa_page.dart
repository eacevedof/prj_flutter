//file:mapa_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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

      body:_crear_fluttermap(oScan),
    );//scaffold

  }//build

  Widget _crear_fluttermap(ScanModel oScan){
    return FlutterMap(
      options: MapOptions(
          center: oScan.getLatLng(),
          zoom: 10,
      ),
      //capas de información que se quiere poner
      layers: [
        _get_mapbox_map() //primer layer mapa 
        //segundo layer marcadores
      ],
    );
  }//_crear_fluttermap

  _get_mapbox_map(){
    return TileLayerOptions(
      urlTemplate: "https://api.tiles.mapbox.com/v4/"
                    //2x: doble de resolucion
                    //z: zoom
                    "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
      additionalOptions: {
        "accessToken":"pk.eyJ1IjoiaW9lZHUiLCJhIjoiY2p6YTdwMWdnMDBubTNnbzVvcHBpNHpocSJ9.RG-89XIV8LGViG-XaB5Jdg",
        "id": "mapbox.streets"
      }
    );
  }//_get_mapbox_map

}//class MapaPage