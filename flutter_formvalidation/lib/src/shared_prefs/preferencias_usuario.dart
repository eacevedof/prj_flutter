//file:preferencias_usuario.dart
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  
  static final PreferenciasUsuario _oSelf = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario(){
    return _oSelf;
  }//PreferenciasUsuario

  PreferenciasUsuario._internal(){
    ;
  }

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

/*
  bool _colorSecundario;
  int _genero;
  String _nombre;
*/

  get genero {return _prefs.getInt("genero") ?? 1;}
  set genero (int iValue) {_prefs.setInt("genero",iValue);}

  get nombre {return _prefs.getString("nombre") ?? "";}
  set nombre (String sValue) {_prefs.setString("nombre",sValue);}

  get colorsecundario {return _prefs.getBool("colorsecundario") ?? false;}
  set colorsecundario (bool isSecundario) {_prefs.setBool("colorsecundario",isSecundario);}

  get ultima_pagina {return _prefs.getString("ultima_pagina") ?? "home";}
  set ultima_pagina (String sValue) {_prefs.setString("ultima_pagina",sValue);}

}//class PreferenciasUsuario