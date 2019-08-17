import 'package:flutter/material.dart';
import 'package:flutter_preferencias_usuario/src/pages/home_page.dart';
import 'package:flutter_preferencias_usuario/src/pages/settings_page.dart';
import 'package:flutter_preferencias_usuario/src/shared_pref/preferencias_usuario.dart';

void main() async {
  //cargo las preferencias
  final prefs = new PreferenciasUsuario();
  //devuelve un future
  await prefs.initPrefs();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Preferencias',
      //initialRoute: "home",
      //otra forma de enrutar
      initialRoute: HomePage.routeName,
      routes: {
         HomePage.routeName     : (BuildContext context) => HomePage(),
         SettingsPage.routeName : (BuildContext context) => SettingsPage(),
      },
    );

  }//build

}//class MyApp