//file:settings_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_preferencias_usuario/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {
  
  //propiedad estática
  static final String routeName = "settings";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _colorSecundario = true;
  int _genero = 1;
  String _nombre = "Pedro";

  TextEditingController _oTextContrl;// = new TextEditingController(text: _nombre); esto no va, se usa initState

  @override
  void initState() {
    super.initState();
    _oTextContrl = new TextEditingController(text: _nombre);
  }//initState

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes"),
      ),
 
      drawer: MenuWidget(),
      
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text("Settings",style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),)
          ),

          Divider(),

          //control "check horizontal"
          SwitchListTile(
            value: true,
            title: Text("color secundario"),
            onChanged: (isTrue){
              setState(() {
                _colorSecundario = isTrue;
              });
            },
          ),

          Divider(),

          RadioListTile(
            value: 1, 
            title: Text("Masculino"),
            groupValue: _genero, //variable que agrupa los radios
            onChanged: (iValue){
              setState(() {
                _genero = iValue; 
              });
            },
          ),

          RadioListTile(
            value: 2, 
            title: Text("Femenino"),
            groupValue: _genero, //variable que agrupa los radios
            onChanged: (iValue){
              setState(() {
                _genero = iValue; 
              });
            },
          ),

          Divider(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _oTextContrl,
              decoration: InputDecoration(
                labelText: "Nombre",
                helperText: "Nombre de la persona usando el teléfono"
              ),
              onChanged: (sChanged){
                setState(() {
                  _nombre = sChanged; 
                });
              },
            ),
          ),

        ],
      )

    );

  }}//class SettingsPage