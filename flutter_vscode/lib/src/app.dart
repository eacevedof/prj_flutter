/*
 *@file: app.dart 
 */
import 'package:flutter/material.dart';
import 'package:flutter_vscode/src/pages/contador_page.dart';
//import 'package:flutter_vscode/src/pages/home_page.dart';

class MyApp extends StatelessWidget{
  
  //tenemos que sobreescribir el método build que es el que pinta el widget
  @override
  Widget build( context ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
          // child: HomePage(),
          child: new ContadorPage(),
        )
    );
  }
}