import 'package:flutter/material.dart';
import 'package:flutter_preferencias_usuario/src/pages/home_page.dart';
import 'package:flutter_preferencias_usuario/src/pages/settings_page.dart';

class MenuWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //listview permite hacer scroll
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/menu-img.jpg"),
                fit: BoxFit.cover
              )
            ),

          ), //DrawerHeader

          //opciones de menu
          ListTile(
            leading: Icon(Icons.pages, color: Colors.blue),
            title: Text("Home"),
            onTap: ()=>Navigator.pushReplacementNamed(context, HomePage.routeName),
          ),// listile:home

          ListTile(
            leading: Icon(Icons.party_mode, color: Colors.blue),
            title: Text("Party Mode"),
            onTap: (){},
          ),// listile:party mode

          ListTile(
            leading: Icon(Icons.people, color: Colors.blue),
            title: Text("People"),
            onTap: (){},
          ),// listile:people

          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue),
            title: Text("Settings"),
            onTap: (){
              //debe mover el navigator a la pantalla de settings
              //cuando sucede esto aparece la flecha de retorno en el appBar y si hacemos click
              //entonces se muestra el ListView y no debería ser así.
              //Habría que cerrar el menú
              //La idea es que la página de destino se vea como pag principal
              
              //Navigator.pop(context); //cierra el ListView
              //Navigator.pushNamed(context, SettingsPage.routeName);

              //con esta linea se consigue la nav como pag principal pero se pierde la "hamburguesa"
              Navigator.pushReplacementNamed(context, SettingsPage.routeName);
              
            },
          ),// listile:settings          

        ],

      ),
    );
    
  }//build

}//class MenuWidget