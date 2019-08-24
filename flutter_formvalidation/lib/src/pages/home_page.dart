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
      body: Container(

      ),

      floatingActionButton: _get_boton_wg(context),

    );

  }//build

  FloatingActionButton _get_boton_wg(BuildContext context){
    
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, "producto"),
    );

  }//_get_boton_wg

}//class HomePage