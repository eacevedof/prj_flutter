import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_disenos/pages/basico_page.dart';
import 'package:flutter_disenos/pages/botones_page.dart';
import 'package:flutter_disenos/pages/scroll_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //colores del statusbar: Barra con el reloj, bateria, señal wifi etc
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños',
      routes: {
        "basico" : (BuildContext context) => BasicoPage(),
        "scroll" : (BuildContext context) => ScrollPage(),
        "botones" : (BuildContext context) => BotonesPage(),
      },
      initialRoute: "botones",
    );

  }// build

}// class MyApp