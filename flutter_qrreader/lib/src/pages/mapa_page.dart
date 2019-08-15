//file:mapa_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_qrreader/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapController map = new MapController();

  //por esta variable necesito un statefulwidget
  String strtipomapa = "streets";

  @override
  Widget build(BuildContext context) {
    
    final ScanModel oScan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Coordenadas QR"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move(oScan.getLatLng(),15);
            },
          )
        ],
      ),

      body:_crear_fluttermap(oScan),

      floatingActionButton: _get_float_button(context),
    );//scaffold

  }
  Widget _crear_fluttermap(ScanModel oScan){
    return FlutterMap(
      mapController: map,
      options: MapOptions(
          center: oScan.getLatLng(),
          zoom: 15,
      ),
      //capas de información que se quiere poner
      layers: [
        _get_mapbox_map(), //primer layer mapa 
        _get_marked_layer_options(oScan),//segundo layer marcadores
      ],
    );
  }
  _get_mapbox_map(){
    return TileLayerOptions(
      urlTemplate: "https://api.tiles.mapbox.com/v4/"
                    //2x: doble de resolucion
                    //z: zoom
                    "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
      additionalOptions: {
        "accessToken":"pk.eyJ1IjoiaW9lZHUiLCJhIjoiY2p6YTdwMWdnMDBubTNnbzVvcHBpNHpocSJ9.RG-89XIV8LGViG-XaB5Jdg",
        "id": "mapbox.$strtipomapa"
        //streets, dark, light, outdoors, satellite
      }
    );
  }
  _get_marked_layer_options(ScanModel oScan){

    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: oScan.getLatLng(),
          builder: (context) => Container(
            //color: Colors.red, fondo del marcador
            child: Icon(
              Icons.location_on,
              size: 70.0,
              color:Theme.of(context).primaryColor
            ),
          ),//builder
        ),
      ],
    );

  }// _get_marked_layer_options

  Widget _get_float_button(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        if(strtipomapa == "streets")
          strtipomapa = "dark";
        else if (strtipomapa == "dark")
          strtipomapa = "light";
        else if (strtipomapa == "light")
          strtipomapa = "outdoors";
        else if (strtipomapa == "outdoors")
          strtipomapa = "satellite";
        else 
          strtipomapa = "streets";

        setState(() {
          
        });
      },
    );
  }//_get_float_button
  
}//class MapaPage