/*
 *@file: app.dart 
 */
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget{
  
  //tenemos que sobreescribir el método build que es el que pinta el widget
  @override
  Widget build( context ) {
    return MaterialApp(
      home: Center(child: Text("Hola Mundo"),)
    );
  }
}