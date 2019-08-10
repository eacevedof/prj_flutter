//scroll_page.dart
import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: PageView(
        //esto permite hacer scroll de arriba hacia abajo
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _get_pagina1_wg(),
          _get_pagina2_wg(),
        ],
      )
    );

  }// build

  Widget _get_pagina1_wg() {
    //stack: pila de 
    return Stack(
      children: <Widget>[
        _get_color_fondo_wg(),
        _get_img_fondo_wg(),
        _get_textos_wg(),
      ],
    );
  }

  Widget _get_pagina2_wg() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(108,192,218,0.5),//0.5 semi-transparente
      child: Center(
        child: RaisedButton(
          shape: StadiumBorder(),
          color: Colors.blue,
          textColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Text("Bienvenidos", style: TextStyle(fontSize: 20.0),),
          ),
          onPressed: () {

          }
        )
      )
    );
  }// _get_pagina2_wg

  Widget _get_color_fondo_wg() {
    return Container(
      width: double.infinity, //todo el ancho posible
      height: double.infinity, //todo el alto posible
      color: Color.fromRGBO(108,192,218,0.5),//0.5 semi-transparente
    );
  }  //_get_color_fondo_wg

  Widget _get_img_fondo_wg() {
    return Container(
      width: double.infinity, //todo el ancho posible
      height: double.infinity, //todo el alto posible
      child: Image(
        image: AssetImage("assets/img/scroll-1.png"),
        //image: AssetImage("assets/scroll-1.png"),
      ),
    );
  }  //_get_img_fondo_wg

  Widget _get_textos_wg() {
    final estiloTexto = TextStyle(color: Colors.white, fontSize:50.0);
    
    return SafeArea(
      child: Column( 
        children: <Widget>[
          SizedBox(height: 20.0,),
          Text("11º",style: estiloTexto,),
          Text("Miercoles",style: estiloTexto,),
          //expanded: estira el widget al ancho o alto posible
          Expanded(
            child: Container(),
          ),
          Icon(Icons.keyboard_arrow_down, size:70.0, color: Colors.white),
        ],
      ),
    );
  }  //_get_textos_wg  

}// ScrollPage