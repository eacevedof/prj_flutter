//@file: home_page.dart  
//En dart es costumbre usar el _ para nombre de ficheros

//Las páginas tambien son widgets
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Título"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Hola Mundo"),
      )
    );
    
  }//build


}//HomePage