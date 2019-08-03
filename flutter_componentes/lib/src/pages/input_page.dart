//import 'dart:math';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {

  @override
  _InputPageState createState() => _InputPageState();
}// InputPage

class _InputPageState extends State<InputPage> {

  String _nombre = "";
  String _email = "";
  String _password = "";
  String _fecha = "";
  String _opcionSeleccionada = "volar";

  List _poderes = ["volar","rayos x","super aliento","super fuerza"];
  
  //este es un observador para el input de fecha
  TextEditingController _oFieldDateController = new TextEditingController();

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
          _crearEmail(),
          Divider(),
          _crearPassword(),
          Divider(),
          _crearFecha(context),              
          Divider(),
          _crearDropdown(),
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

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
      locale: Locale("es","ES"),
    );

    if (picked != null){
      setState(() {
        _fecha = picked.toString();
        _oFieldDateController.text = _fecha;
      });
    }

  }// _selectDate

  Widget _crearFecha(BuildContext context){
    return TextField(
      enableInteractiveSelection: false,
      controller: _oFieldDateController, //observador que permite redibujar el valor seleccionado en el input
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: "Fecha de nacimiento", //placeholder
        labelText: "Fecha de nacimiento",//label
        suffixIcon: Icon(Icons.perm_contact_calendar),//icono derecho
        icon: Icon(Icons.calendar_today)//icono izquierdo
      ),

      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        //se hace llamada asincrona para cargar el widget: showDatePicker
        _selectDate(context);
      },
    );
  }// _crearFecha

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();
    _poderes.forEach((poder){
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
        //key:
      ));
    });    
    return lista;
  } // getOpcionesDropdown

  Widget _crearDropdown(){
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0), //espacio entre icono e input
        Expanded( //expanded: hace que se ocupe todo el ancho de la pantalla
          child: DropdownButton(
            value: _opcionSeleccionada, //valor seleccionado
            items: getOpcionesDropdown(),//devuelve: List<DropdownMenuItem<String>>
            onChanged: (optselected){
              setState(() {
                _opcionSeleccionada = optselected;
              });
            },
          )
        ),
      ],
    );
  }// _crearDropdown

  Widget _crearPersona(){
    return ListTile(
      title: Text("Nombre es: $_nombre"),
      subtitle: Text("Email es: $_email, passw: $_password"),
      //leading: Text(_opcionSeleccionada),//leading: pone el texto justificado izquierdo
      trailing: Text(_opcionSeleccionada),//leading: pone el texto justificado al lado derecho
    );
  }// _crearPersona

}// _InputPageState