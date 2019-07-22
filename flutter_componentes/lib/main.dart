import 'package:flutter/material.dart';
//import 'package:flutter_componentes/src/pages/home_temp.dart';
import 'src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Componentes App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Componentes'),
        ),
        //body: HomePageTemp(),
        body: HomePage()
      ),
    );
  }
}