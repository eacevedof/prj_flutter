//file:home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_preferencias_usuario/src/shared_pref/preferencias_usuario.dart';
import 'package:flutter_preferencias_usuario/src/widgets/menu_widget.dart';


class HomePage extends StatelessWidget {
  
  //propiedad estática
  static final String routeName = "home";

  @override
  Widget build(BuildContext context) {
    
    final prefs = new PreferenciasUsuario();
    //prefs.initPrefs(); //no vale porque es async

    return Scaffold(
      appBar: AppBar(
        title: Text("Preferencias de Usuario"),
      ),

      //genera el icono de hamburguesa 
      drawer: MenuWidget(),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Color secundario:"),
          Divider(),
          Text("Género: ${prefs.genero}"),
          Divider(),
          Text("Nombre de usuario:"),
          Divider(),
        ],
      ),
    );

  }//build




}//class HomePage