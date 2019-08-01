//@file peliculas_provider.dart
import 'dart:convert';

import 'package:flutter_peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {

  String _apikey = "e5ffc1203b7c1bbf876605bd54e27c20";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  Future<List<Pelicula>> getEnCines() async {
    print("provider.getEnCines");
    final url = Uri.https(_url,"3/movie/now_playing",{
      "api_key": _apikey, "language":_language
    });

    //espera la solitud
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);

    //carga en peliculas.items los resultados en forma de objetos pelicula
    final peliculas = new Peliculas.fromJsonList(decodedData["results"]);
    print(peliculas.items);
    return peliculas.items;

  }// getEnCines

  Future<List<Pelicula>> getPopulares() async {
    print("provider.getPopulares");
    final url = Uri.https(_url,"3/movie/popular",{
      "api_key": _apikey, "language":_language
    });

    //espera la solitud
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);

    //carga en peliculas.items los resultados en forma de objetos pelicula
    final peliculas = new Peliculas.fromJsonList(decodedData["results"]);
    print(peliculas.items);
    return peliculas.items;
    
  }// getPopulares

}// PeliculasProvider