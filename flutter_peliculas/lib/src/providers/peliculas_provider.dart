//@file peliculas_provider.dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter_peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {

  String _apikey = "e5ffc1203b7c1bbf876605bd54e27c20";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  int _popularesPage = 0;
  List<Pelicula> _populares = new List();

  //si no llevara broadcast solo podria escuchar uno solo el stream
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();
  //agrega al stream el listado de peliculas
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  //cada vez que se entra a la pantalla se abriria un stream por eso hay que cerrarlo
  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEnCines() async {
    print("provider.getEnCines");
    final url = Uri.https(_url,"3/movie/now_playing",{
      "api_key": _apikey, "language":_language
    });

    return await _procesarRespuesta(url);
  }// getEnCines

  Future<List<Pelicula>> getPopulares() async {
    print("provider.getPopulares");

    _popularesPage++;
    final url = Uri.https(_url,"3/movie/popular",{
      "api_key": _apikey, "language":_language, "page": _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);
    //agrego todas las peliculas en mi lista populares
    _populares.addAll(resp);
    //se coloca en el inicio del stream de datos para que puedan ser escuchados
    popularesSink(_populares);
    //devuelvo la lista de peliculas
    return resp;
    
  }// getPopulares

  Future<List<Pelicula>> _procesarRespuesta( Uri url ) async {
    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData["results"]);
    return peliculas.items;
  }// _procesarRespuesta

}// PeliculasProvider