//file:settings_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_preferencias_usuario/src/shared_pref/preferencias_usuario.dart';
import 'package:flutter_preferencias_usuario/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {
  
  //propiedad estática
  static final String routeName = "settings";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _colorSecundario;
  int _genero;

  TextEditingController _oTextContrl;// = new TextEditingController(text: _nombre); esto no va, se usa initState
  final prefs = new PreferenciasUsuario();

  @override
  //no podemos hacer initState como async
  void initState() {
    super.initState();
    _genero = prefs.genero;
    _colorSecundario = prefs.colorsecundario;
    _oTextContrl = new TextEditingController(text: prefs.nombre);
  }//initState

  _set_selected_radio(int iValue){
    //guarda el nuevo género
    prefs.genero = iValue;
    _genero = iValue;
    setState(() {});       
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes"),
        backgroundColor: (prefs.colorsecundario) ? Colors.teal : Colors.blue,
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
            value: _colorSecundario,
            title: Text("color secundario"),
            onChanged: (isTrue){
              setState(() {
                //si comento todo esto no se actualiza la pantalla
                _colorSecundario = isTrue;//modif en pantalla
                prefs.colorsecundario = isTrue;//modif en el storate
              });
            },
          ),

          Divider(),

          RadioListTile(
            value: 1, 
            title: Text("Masculino"),
            groupValue: _genero, //variable que agrupa los radios
            onChanged: _set_selected_radio,
          ),

          RadioListTile(
            value: 2, 
            title: Text("Femenino"),
            groupValue: _genero, //variable que agrupa los radios
            onChanged: _set_selected_radio,
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
              //cada tecla se presiona dispara este evento
              onChanged: (sChanged){
                prefs.nombre = sChanged;
              },
            ),
          ),

        ],
      )

    );

  }}//class SettingsPage