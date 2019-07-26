//@file: alert_page.dart

import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alert Page"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Mostrar Alerta"),
          color: Colors.blue,
          textColor: Colors.white,
          shape: StadiumBorder(),
          onPressed: ()=>_mostrarAlerta(context),
        ),
      ),
      //botón de retorno
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_location),
        onPressed: (){
          //vuelve a la pantalla anterior
          Navigator.pop(context);
        },
      ),
    ); //Scaffold
  } // build

  void _mostrarAlerta(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: true,//se cierra la alerta haciendo click afuera
      builder: (context){
        return AlertDialog(
          title: Text("Titulo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Contenido de la caja de la alerta"),
              FlutterLogo(size: 100.0,)
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: ()=>Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("Ok"),
              onPressed: ()=>Navigator.of(context).pop(),
            )            
          ],
        );
      }
    );
  }// _mostrarAlerta
} // AlertPage