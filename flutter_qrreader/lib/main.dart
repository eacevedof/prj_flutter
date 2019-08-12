import 'package:flutter/material.dart';
import 'package:flutter_qrreader/src/pages/home_page.dart';
import 'package:flutter_qrreader/src/pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: "home",
      routes: {
        "home" : (BuildContext context) => HomePage(),
        "mapa" : (BuildContext context) => MapaPage(),
      },

      //tema centralizado
      theme: ThemeData(
        primaryColor: Colors.orange
      )

    );
  }
}
