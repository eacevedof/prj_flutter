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

  bool _colorSecundario;
  int _genero;
  String _nombre;

  get genero {return _prefs.getInt("genero")??1;}
  set genero (int iValue) {_prefs.setInt("genero",iValue);}

}//class PreferenciasUsuario