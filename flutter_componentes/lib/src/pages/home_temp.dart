// @file: home_temp.dart

import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  
  final opciones = ["Uno","Dos","Tres","Cuatro","Cinco"];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Componentes Temp"),
      ),
      body: ListView(
        //children: _crear_items()
        children: _crearItemsCorta()
      ),
    );

  }// fn: build

  List<Widget> _crear_items(){
    List<Widget> Lista = new List<Widget>();
    for (String opt in this.opciones) {
      final oWidget = ListTile(
        title: Text(opt),
      );
      Lista..add(oWidget)..add(Divider()); 
    }
    return Lista;
  }// _crear_items

  List<Widget> _crearItemsCorta() {
    return this.opciones.map((opt) {
      return Column(
        children: <Widget>[
          ListTile(
            title: Text( opt + "!"),
            subtitle: Text("Cualquier cosa"),
            leading: Icon(Icons.account_balance_wallet),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){},
          )
        ],
      ); 
    }).toList();
  }

}// HomePageTemp 

