//file: search_delegate.dart
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

  String seleccion = "";

  final peliculas = [
    "Spiderman","Aquaman","Batman","Shazam!","Ironman","Capitan América","superman",
    "Ironman 1","Ironman 2","Ironman 3"
  ];

  final peliculasRecientes = [
    "Spiderman","Capitan América"
  ];

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
  //Al hacer click en el elemento encontrado se puede llamar a este metodo
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listaSugerida = (query.isEmpty)
                          ? peliculasRecientes 
                          : peliculas.where(
                              (p)=>p.toLowerCase().startsWith(query.toLowerCase())
                            ).toList();


    // las sugerencias cuando la persona escribe
    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: (){
            seleccion = listaSugerida[i];
            showResults(context);//llama a buildResults
          },
        );
      },
    );
  }

}// class DataSearch