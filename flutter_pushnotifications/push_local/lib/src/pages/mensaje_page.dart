import 'package:flutter/material.dart';

class MensajePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final String strarg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Text(strarg),
      ),
    );

  }

}//class MensajePage