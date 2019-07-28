
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //safearea salva el nodge (el hueco en la pantalla, pestaña negra)
      body: SafeArea(
        child: Text("Hola Mundo!!!"),
      )

    );

  }// build

}// HomePage