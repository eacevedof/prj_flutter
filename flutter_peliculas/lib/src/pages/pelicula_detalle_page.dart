//@file: pelicula_detalle_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Pelicula oModelPelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(child: Text(oModelPelicula.title)),
    );
  }// build

}// PeliculaDetalle