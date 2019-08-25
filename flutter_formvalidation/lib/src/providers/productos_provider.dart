//file: productos_provider.dart

import 'dart:convert';

import 'package:flutter_formvalidation/src/models/producto_model.dart';
import 'package:http/http.dart' as http;

class ProductosProvider{

  final String _url = "https://fir-flutter-db876.firebaseio.com";

  Future<bool> getasync_producto( ProductoModel producto) async {
    final url = "$_url/productos.json";
    final resp = await http.post(url,body:productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
  }//getasync_producto

}//class ProductosProvider