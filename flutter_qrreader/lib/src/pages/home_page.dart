//home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_qrreader/src/pages/direcciones_page.dart';

import 'mapas_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int iCurrPage = 0;  

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(      
      appBar: AppBar(
        title: Text("QR Scanner"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){
              //borrara todos los regs
            },
          )
        ],
      ),

      body: _get_page_wg(iCurrPage),
      bottomNavigationBar: _get_bottom_navbar(),

      //boton azul en el medio
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: (){

        },
        //esto se relaciona con main.dart y la propiedad theme
        backgroundColor: Theme.of(context).primaryColor,
      ),

    );

  }//build

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