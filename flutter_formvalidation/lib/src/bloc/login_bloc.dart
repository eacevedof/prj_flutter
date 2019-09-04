//file:login_bloc.dart

import 'dart:async';
import 'package:flutter_formvalidation/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
//import 'package:rxdart/streams.dart';

//mixin
class LoginBloc with Validators {

  //broadcast(): permite que varios objetos escuchen e interactuen con el stream
  final _oBehavEmail = BehaviorSubject<String>();
  final _oBehavPassw = BehaviorSubject<String>();

  //escuchadores
  //recuperar los datos del stream
  //hay que definir lo que saldrá del stream: Stream<String> 
  Stream<String> get emailStream => _oBehavEmail.stream.transform(validarEmail);
  Stream<String> get passStream => _oBehavPassw.stream.transform(validarPass);

  //(e,p) es el resultado del email y password. Si hay datos en ambos streams deseo retornar un true en caso contrario regresaria null
  Stream<bool> get formValidStream => Observable.combineLatest2(emailStream, passStream, (e,p)=>true);

  //insertar valores al stream
  //son funciones que reciben un string: Function(String)
  Function(String) get changeEmail => _oBehavEmail.sink.add;
  Function(String) get changePass => _oBehavPassw.sink.add;  

  //obtener el último valor ingresado a los streams
  String get email => _oBehavEmail.value;
  String get password => _oBehavPassw.value;

  dispose(){
    _oBehavEmail?.close();
    _oBehavPassw?.close();
  }

}//class LoginBloc