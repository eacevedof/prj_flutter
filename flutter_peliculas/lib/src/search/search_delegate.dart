//file: search_delegate.dart
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar p.e. un icono para limpiar el texto o cancelar la busqueda
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // las sugerencias cuando la persona escribe
    return null;
  }

}// class DataSearch