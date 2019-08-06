//@file: pelicula_detalle_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Pelicula oModelPelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView( //es como una lista 
        //los slivers son widgets que escuchan los eventos del scroll
        slivers: <Widget>[  //sería como los children
          _createAppbar(oModelPelicula),
        ],
      ),
    );

  }// build

  Widget _createAppbar(Pelicula oPelicula){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          oPelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          //con este me da error de carga la primera vez
          //image: NetworkImage(oPelicula.getBackgroundImg()),
          image: NetworkImage(oPelicula.getPosterImg()),
          placeholder: AssetImage("assets/img/loading.gif"),
          //fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),      
    );
  }// _createAppbar

}// PeliculaDetalle