//botones_page.dart
import 'dart:math';

import 'package:flutter/material.dart';

class BotonesPage  extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _get_fondo_wg(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _get_titulos_wg()
              ],
            ),
          ),
        ],
      )
    );

  }// build

  Widget _get_titulos_wg(){
    //salva el nodge
    return SafeArea(

      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Classify transaction", style: TextStyle(color: Colors.white,fontSize: 30.0, fontWeight:FontWeight.bold)),
            SizedBox(height: 10.0,),
            Text("Classify this transaction into a particular category", style: TextStyle(color:Colors.white,fontSize: 18.0,)),
          ],
        ),
        
      ),
    );

  }// _get_titulos_wg

  Widget _get_fondo_wg(){
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0,0.6),
          end: FractionalOffset(0.0,1.0),
          colors: [
            Color.fromRGBO(52,54, 101, 1.0),
            Color.fromRGBO(35,37, 57, 1.0),
          ]
        )
      ),
    );


    final cajaRosa = Transform.rotate(
      angle: -pi / 4.0,
      child:Container(
        height: 300.0,
        width: 300.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(230, 98, 188, 1.0),
              Color.fromRGBO(241, 142, 172, 1.0),
            ],
          ),
          
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        //es como la posicion absoluta en css
        Positioned(
          top: -100.0,
          child: cajaRosa,
        ),
      ],
    );
  }// _get_fondo_wg

}// class BotonesPage