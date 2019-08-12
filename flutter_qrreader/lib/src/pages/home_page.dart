//home_page.dart
import 'package:flutter/material.dart';

import 'package:flutter_qrreader/src/bloc/scans_bloc.dart';
import 'package:flutter_qrreader/src/models/scan_model.dart';

import 'package:flutter_qrreader/src/pages/direcciones_page.dart';
import 'package:flutter_qrreader/src/utils/utils.dart' as u;
import 'mapas_page.dart';

import 'package:qrcode_reader/qrcode_reader.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //como el provider se usa en el bloc, se quita esa importación ya que no
  //deberiamos usarlo aqui
  final scansBloc = new ScansBloc();
  int iCurrPage = 0;  

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(      
      appBar: AppBar(
        title: Text("QR Scanner"),
        actions: <Widget>[
          IconButton(
            //icono papelera
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScanAll,
          )
        ],
      ),

      body: _get_page_wg(iCurrPage),
      bottomNavigationBar: _get_bottom_navbar(),

      //boton azul en el medio que ejecuta el scanner de QR
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => scan_qr(context),
        //esto se relaciona con main.dart y la propiedad theme
        backgroundColor: Theme.of(context).primaryColor,
      ),

    );

  }//build

  void scan_qr(BuildContext context) async {
    //lee el qr y lo transorma en el sitio web
    //theframework.es
    //geo:40.64717223609042,-73.96886244257814
    print("scan_qr");
    String futureString = "http://theframework.es";

    if( futureString != null){
      final oScanModel = ScanModel(valor:futureString);
      //esto funciona pero no notifica al stream que ha habido cambios y por ende
      //que se refresquen las pantallas que estan escuchando
      //DbProvider.oDb.nuevoScan(oScanModel);
      scansBloc.agregarScan(oScanModel);

      final oScanModel2 = ScanModel(valor:"geo:40.64717223609042,-73.96886244257814");
      scansBloc.agregarScan(oScanModel2);

      //solo para IOS:
      if (Platform.isIOS){
        Future.delayed(Duration(microseconds: 750),(){
          u.abrir_scan(context,oScanModel);
        });
      }
      else 
        u.abrir_scan(context,oScanModel);
    }

    // try {
    //   //con el await esperamos un string de lo contrario esperariamos un Future
    //   futureString = await new QRCodeReader().scan();
    // }catch(e){
    //   futureString = e.toString();
    // }

    // print("scan_qr.futureString: $futreString");
    // if(futureString!=null)
    //   print("Tenemos Información");

  }//scan_qr

  Widget _get_bottom_navbar(){

    return BottomNavigationBar(
      //que posicion de botón está activa (se colorea en azul)
      currentIndex: iCurrPage, 

      onTap: (index){
        setState(() {
          iCurrPage = index; 
        });
      },
      
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text("Mapas"),
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_1),
          title: Text("Direcciones"),
        ),
      ],//los botones

    );

  }//_get_bottom_navbar

  Widget _get_page_wg(int iPagActual){

    switch(iPagActual){
      case 0: return MapasPage();
      case 1: return DireccionesPage();
      default: return MapasPage();
    }

  }//_get_page_wg
  
}// HomePage