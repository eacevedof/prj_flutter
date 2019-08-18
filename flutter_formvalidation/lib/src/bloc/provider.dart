//file: provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_formvalidation/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  //instancia única
  final loginBloc = LoginBloc();

  //constructor
  Provider({Key key, Widget child}) : super(key: key, child:child);

  @override
  //en el 99% de los casos debe devolver true
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //va a buscar en el DOM (context) y devolverá la instancia de este "LoginBloc"
  static LoginBloc of (BuildContext context){
    //va a buscar un Provider en el DOM
    return (context.ancestorInheritedElementForWidgetOfExactType(Provider) as Provider).loginBloc;
  }
  
}//class Provider

