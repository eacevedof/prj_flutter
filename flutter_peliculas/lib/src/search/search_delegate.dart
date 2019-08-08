//file: search_delegate.dart
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

  @override
  //debe devolver una lista de widgets
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar p.e. un icono para limpiar el texto o cancelar la busqueda
    return [
      IconButton(
        icon: Icon(Icons.clear),//La x de limpiar
        onPressed: (){
          //print("CLICK!!");
          query = ""; // con esto se limpia la caja
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation, //tiempo en el que se va animar este icono
      ),
      onPressed: (){
        close(context,null);//regresa a la pantalla anterior
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // las sugerencias cuando la persona escribe
    return Container();
  }

}// class DataSearch