import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {

  @override
  _InputPageState createState() => _InputPageState();
}// InputPage

class _InputPageState extends State<InputPage> {

  String _nombre = "";
  String _email = "";
  String _password = "";

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
          _crearEmail(),
          _crearPassword(),
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

  Widget _crearEmail(){
    return TextField(
      keyboardType: TextInputType.emailAddress,//ofrece un teclado con @
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        counter: Text("Letras ${_nombre.length}"),//texto debajo derecho
        hintText: "email de la persona", //placeholder
        labelText: "Email",//label
        helperText: "Solo es el email",//texto debajo
        suffixIcon: Icon(Icons.alternate_email),//icono derecho
        icon: Icon(Icons.email)//icono izquierdo
      ),

      onChanged: (valor) => setState((){
        _email = valor;
      }),
    );

  }// _crearEmail

  Widget _crearPassword(){
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        counter: Text("Letras ${_nombre.length}"),//texto debajo derecho
        hintText: "password de la persona", //placeholder
        labelText: "Password",//label
        helperText: "Solo es el password",//texto debajo
        suffixIcon: Icon(Icons.lock_open),//icono derecho
        icon: Icon(Icons.lock)//icono izquierdo
      ),

      onChanged: (valor) => setState((){
        _password = valor;
      }),
    );

  }// _crearPassword


  Widget _crearPersona(){
    return ListTile(
      title: Text("Nombre es: $_nombre"),
      subtitle: Text("Email es: $_email, passw: $_password"),

    );
  }// _crearPersona

}// _InputPageState