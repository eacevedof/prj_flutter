// @file: home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_componentes/src/pages/alert_page.dart';
import 'package:flutter_componentes/src/providers/menu_provider.dart';
import 'package:flutter_componentes/src/utils/icono_string_util.dart';

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
          children: _listaItems(snapshot.data, context),
        );
      }, // builder
    );
  } // _lista

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach( (opt) {
      final oWidget = ListTile(
        title: Text(opt["texto"]),
        leading: getIcon(opt["icon"]),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          final route = MaterialPageRoute(
            builder: (context) => AlertPage()
          );

          //context: es el build context, es el que tiene la información de la navegación
          //información global de la app
          Navigator.push(context, route);
        },

      );
      opciones..add(oWidget)
              ..add(Divider());
    });

    return opciones;
  } //_listaItems

}// HomePage
