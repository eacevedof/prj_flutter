//@file: main.dart
import 'package:flutter/material.dart';
import 'package:flutter_componentes/src/pages/alert_page.dart';
import 'package:flutter_componentes/src/pages/avatar_page.dart';
//import 'package:flutter_componentes/src/pages/home_temp.dart';
import 'src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Componentes App',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/"     : ( BuildContext context) => HomePage(),
        "alert" : ( BuildContext context) => AlertPage(),
        "avatar": ( BuildContext context) => AvatarPage(),
      }// routes
    ); // MaterialApp
  }// build
}// MyApp