//file: provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_formvalidation/src/bloc/login_bloc.dart';
export "package:flutter_formvalidation/src/bloc/login_bloc.dart";

class Provider extends InheritedWidget {

  static Provider _instancia;

  factory Provider({Key key, Widget child}){
    if(_instancia == null){
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  //constructor interno que evita que se cree una instancia desde afuera
  Provider._internal({Key key, Widget child})
      : super(key:key, child:child);
  
  //instancia única
  final loginBloc = LoginBloc();

  //constructor, no procede, ahora es singleton
  //Provider({Key key, Widget child}) : super(key: key, child:child);

  @override
  //en el 99% de los casos debe devolver true
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //la función "of" va a buscar en el DOM (context) y devolverá la instancia de este "LoginBloc"
  static LoginBloc of (BuildContext context){
    //va a buscar un Provider en el DOM
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).loginBloc;
  }
  
}//class Provider

