//@file contador_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ContadorPage extends StatefulWidget {

  @override
  //State<StatefulWidget> createState() {
    //return new _ContadorPageState();
  //}
  createState() => new _ContadorPageState();

}

// "_" esta es una clase privada
class _ContadorPageState extends State<ContadorPage> {

  final TextStyle _oEstilo = new TextStyle(fontSize: 25);
  int _conteo = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Stateful"),
        centerTitle: true,
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Número de taps:", style: _oEstilo),
            Text('$_conteo', style: _oEstilo), //con $this._conteo no tira
          ],
        )
      ),
      
      floatingActionButton: _crearBotones(),

    );
  }//build

  Widget _crearBotones() {
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 30),
        FloatingActionButton(child: Icon(Icons.exposure_zero), onPressed: null,),
        Expanded(child: SizedBox(width: 5.0)),
        FloatingActionButton(child: Icon(Icons.remove), onPressed: null,),
        SizedBox(width: 5.0,),
        FloatingActionButton(child: Icon(Icons.add), onPressed: null,),
      ],
    );

  }// _crearBotones

}

