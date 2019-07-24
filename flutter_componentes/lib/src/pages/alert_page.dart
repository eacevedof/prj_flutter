//@file: alert_page.dart

import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alert Page"),
      ),
      //botón de retorno
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_location),
        onPressed: (){
          //vuelve a la pantalla anterior
          Navigator.pop(context);
        },
      ),
    ); //Scaffold
  } // build
} // AlertPage