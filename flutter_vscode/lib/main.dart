/*
 * @file: main.dart
 * Este es el fichero de punto inicial
 */
//material design
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  
  //tenemos que sobreescribir el método build que es el que pinta el widget
  @override
  Widget build( context ) {
    return MaterialApp(
      home: Center(child: Text("Hola Mundo"),)
    );
  }
}