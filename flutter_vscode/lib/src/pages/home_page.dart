//@file: home_page.dart  
//En dart es costumbre usar el _ para nombre de ficheros

//Las páginas tambien son widgets
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {

  final TextStyle oEstilo = new TextStyle(fontSize: 25);
  final conteo = 10;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Título"),
        centerTitle: true,
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Número de clicks:", style: this.oEstilo),
            Text('$this.conteo', style: this.oEstilo),
          ],
        )
      ),
      
      floatingActionButton: FloatingActionButton(
        //child: Text("Hola"),
        child: Icon( Icons.add),
        onPressed: () {
          print("Hola Mundo");
          this.conteo = conteo++;
        },  //null desactiva el botón
      ),

      //floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

    );

  }//build


}//HomePage