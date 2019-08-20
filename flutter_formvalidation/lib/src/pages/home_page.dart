//file:home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_formvalidation/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("email: ${bloc.email}"),
          Divider(),
          Text("password: ${bloc.password}"),
        ]
      ),
    );
  }//build

}//class HomePage