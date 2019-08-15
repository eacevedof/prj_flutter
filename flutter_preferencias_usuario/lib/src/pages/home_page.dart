//file:home_page.dart

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  
  //propiedad estática
  static final String routeName = "home";

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferencias de Usuario"),
      ),

      body: Column(
        children: <Widget>[
          Text("Color secundario:"),
          Divider(),
          Text("Género:"),
          Divider(),
          Text("Nombre de usuario:"),
          Divider(),
        ],
      ),
    );

  }//build

}//class HomePage