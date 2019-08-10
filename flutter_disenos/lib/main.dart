import 'package:flutter/material.dart';
import 'package:flutter_disenos/pages/basico_page.dart';
import 'package:flutter_disenos/pages/scroll_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños',
      routes: {
        "basico" : (BuildContext context) => BasicoPage(),
        "scroll" : (BuildContext context) => ScrollPage(),
      },
      initialRoute: "scroll",
    );

  }// build

}// class MyApp