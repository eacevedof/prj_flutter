//file:login_bloc.dart

import 'dart:async';
import 'package:flutter_formvalidation/src/bloc/validators.dart';

//mixin
class LoginBloc with Validators {

  //broadcast(): permite que varios objetos escuchen e interactuen con el stream
  final _emailCtrl = StreamController<String>.broadcast();
  final _passCtrl = StreamController<String>.broadcast();

  //escuchadores
  //recuperar los datos del stream
  //hay que definir lo que saldrá del stream: Stream<String> 
  Stream<String> get emailStream => _emailCtrl.stream.transform(validarEmail);
  Stream<String> get passStream => _passCtrl.stream.transform(validarPass);

  //insertar valores al stream
  //son funciones que reciben un string: Function(String)
  Function(String) get changeEmail => _emailCtrl.sink.add;
  Function(String) get changePass => _passCtrl.sink.add;  

  dispose(){
    _emailCtrl?.close();
    _passCtrl?.close();
  }

}//class LoginBloc