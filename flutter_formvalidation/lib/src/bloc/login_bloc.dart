//file:login_bloc.dart

import 'dart:async';
import 'package:flutter_formvalidation/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';

//mixin
class LoginBloc with Validators {

  //broadcast(): permite que varios objetos escuchen e interactuen con el stream
  final _emailCtrl = BehaviorSubject<String>();
  final _passCtrl = BehaviorSubject<String>();

  //escuchadores
  //recuperar los datos del stream
  //hay que definir lo que saldrá del stream: Stream<String> 
  Stream<String> get emailStream => _emailCtrl.stream.transform(validarEmail);
  Stream<String> get passStream => _passCtrl.stream.transform(validarPass);

  //(e,p) es el resultado del email y password. Si hay datos en ambos streams deseo retornar un true en caso contrario regresaria null
  Stream<bool> get formValidStream => Observable.combineLatest2(emailStream, passStream, (e,p)=>true);

  //insertar valores al stream
  //son funciones que reciben un string: Function(String)
  Function(String) get changeEmail => _emailCtrl.sink.add;
  Function(String) get changePass => _passCtrl.sink.add;  

  dispose(){
    _emailCtrl?.close();
    _passCtrl?.close();
  }

}//class LoginBloc