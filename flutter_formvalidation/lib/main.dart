import 'package:flutter/material.dart';
import 'package:flutter_formvalidation/src/bloc/provider.dart';
import 'package:flutter_formvalidation/src/pages/home_page.dart';
import 'package:flutter_formvalidation/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //devuelve un widget gestor de streaming de tipo: InheritedWidget
    return Provider(

      child: MaterialApp(
        //deshabilitar franja de banner
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: "login",
        routes: {
          "login" : (BuildContext context) => LoginPage(),
          "home"  : (BuildContext context) => HomePage(),
        },
        theme: ThemeData(
          //el color de los label y las lineas limite de las cajas de texto
          primaryColor: Colors.purple,
        )
      ),

    );//Provider

  }//build

}//class MyApp