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
      ),
      
      bottomNavigationBar: _get_bottom_navbar(context),

      // bottomNavigationBar: BottomNavigationBar(
      //   //color iconos
      //   fixedColor: Colors.pink,

      //   items: <BottomNavigationBarItem>[
        
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.calendar_today),
      //       title: Container(),
      //     ),        

      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.pie_chart_outlined),
      //       title: Container(),
      //     ),

      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.supervised_user_circle),
      //       title: Container(),
      //     ),      

      //   ],
      // ),

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

  Widget _get_bottom_navbar(BuildContext context){
    //la única forma de customizar el BottomNavigationBar implica
    //cambiar el tema global de la app
    return Theme(
      data: Theme.of(context).copyWith(
        //fondo de la barra
        canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
        primaryColor: Colors.pink,
        textTheme: Theme.of(context).textTheme.copyWith(
          //color del icono en gris por defecto
          caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0))
        ),
      ),
      child: BottomNavigationBar(
        
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 30.0,),
            title: Container(),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart, size: 30.0),
            title: Container(),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle, size: 30.0),
            title: Container(),
          ),     
        ],
      ),
    );

  }// _get_bottom_navbar

}// class BotonesPage