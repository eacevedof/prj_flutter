import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {

  @override
  _InputPageState createState() => _InputPageState();
}// InputPage

class _InputPageState extends State<InputPage> {

  String _nombre = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inputs de texto"),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        children: <Widget>[
          _crearInput(),//devuelve TextField()
          Divider(),
          _crearPersona(),//devuelve ListTile()
        ],
      ),
    );

  }// build

  Widget _crearInput() {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        counter: Text("Letras ${_nombre.length}"),//texto debajo derecho
        hintText: "Nombre de la persona", //placeholder
        labelText: "Nombre",//label
        helperText: "Solo es el nombre",//texto debajo
        suffixIcon: Icon(Icons.accessibility),//icono derecho
        icon: Icon(Icons.account_circle)//icono izquierdo
      ),

      onChanged: (valor){
        setState(() {
          _nombre = valor;
          print(_nombre);          
        });
      },
    );
  }// _crearInput

  Widget _crearPersonax(){


  }// _crearPersonax

  Widget _crearPersona(){
    return ListTile(
      title: Text("Nombre es: $_nombre"),
    );
  }// _crearPersona

}// _InputPageState