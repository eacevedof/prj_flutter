//file: provider.dart
import 'package:flutter/material.dart';

import 'package:flutter_formvalidation/src/bloc/login_bloc.dart';
export 'package:flutter_formvalidation/src/bloc/login_bloc.dart';

import 'package:flutter_formvalidation/src/bloc/productos_bloc.dart';
export 'package:flutter_formvalidation/src/bloc/productos_bloc.dart';


//El InheritedWidget es la caja de resonancia
class Provider extends InheritedWidget {

  //este también deberia ser privado, no se hace por evitar refactorizar
  final loginBloc = LoginBloc(); 
  final _productosBloc = ProductosBloc(); 

  static Provider _instancia;

  //instancia única
  factory Provider({Key key, Widget child}){
    if(_instancia == null){
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  //constructor interno que evita que se cree una instancia desde afuera
  Provider._internal({Key key, Widget child})
      : super(key:key, child:child);

  @override
  //en el 99% de los casos debe devolver true
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //la función "of" va a buscar en el DOM (context) y devolverá la instancia de este "LoginBloc"
  static LoginBloc of (BuildContext context){
    //va a buscar un Provider en el DOM y lo trate como Provider seguidamente devuelve el stream de login
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).loginBloc;
  }
  
  static ProductosBloc get_prod_bloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._productosBloc;
  }

}//class Provider

