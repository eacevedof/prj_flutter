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
        SizedBox(width: 30.0),
        FloatingActionButton(child: Icon(Icons.exposure_zero), onPressed: _reset,),
        Expanded(child: SizedBox(width: 5.0)),
        FloatingActionButton(child: Icon(Icons.remove), onPressed: _sustraer,),
        SizedBox(width: 5.0,),
        FloatingActionButton(child: Icon(Icons.add), onPressed: _agregar,), // _agregar sin parentesis
      ],
    );

  }// _crearBotones

  void _agregar() {
    setState( () => _conteo++ );
  }// _agregar

  void _sustraer() {
    setState( () => _conteo-- );
  }

  void _reset() {
    setState( () => _conteo=0 );
  }

}// _ContadorPageState

