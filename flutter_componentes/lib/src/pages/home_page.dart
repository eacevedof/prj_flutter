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
      //aqui no se puede poner ListView pq si tarda mucho la respuesta pareceria que la app esta colgada
      print("_lista");
      print(opt);
    });

    return FutureBuilder(
      //future es lo que vamos a esperar
      future: oMenuProvider.cargarData(),
      //la info por defecto mientras se resuelve el future
      initialData: [],
      //el renderizador
      //tiene etapas
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
        //aqui se puede hacer loaders
        print("builder");
        print(snapshot.data);

        return ListView(
          children: _listaItems(snapshot.data),
        );
      }, // builder
    );
  } // _lista

  List<Widget> _listaItems(List<dynamic> data) {
    final List<Widget> opciones = [];

    data.forEach( (opt) {
      final oWidget = ListTile(
        title: Text(opt["texto"]),
        leading: Icon(Icons.account_circle, color: Colors.blue),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {

        },

      );
      opciones..add(oWidget)
              ..add(Divider());
    });

    return opciones;
  } //_listaItems

}// HomePage
