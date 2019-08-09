//file: basico_page.dart
import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(child: Text("img1"),),
          Container(child: Text("texto estrella"),),
          Container(child: Text("iconos telefono y share"),),
          Container(child: Text("texto amplio"),)
        ]
      ),
    );
  }// build

}// class BasicoPage