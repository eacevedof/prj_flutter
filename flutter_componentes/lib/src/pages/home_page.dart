// @file: home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_componentes/src/providers/menu_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("componentes"),

      ),
      
      body: _lista(),
      
    );
  }

  Widget _lista() {

    //print(oMenuProvider.opciones);
    oMenuProvider.cargarData().then((opt){
      print("_lista");
      print(opt);
    });
    return FutureBuilder(
      future: oMenuProvider.cargarData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
        print(snapshot.data);

        return ListView(
          children: _listaItems(),
        );
      },
    );


  }

  List<Widget> _listaItems() {
    return [
      ListTile(title: Text("Hola Mundo"),)
    ];
  }

}// HomePage
