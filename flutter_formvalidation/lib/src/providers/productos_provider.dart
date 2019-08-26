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

  Future<List<ProductoModel>> getasync_list() async {
    final url = "$_url/productos.json";
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if(decodedData == null ) return [];
    
    decodedData.forEach((id,prod){
      final oProd = ProductoModel.fromJson(prod);
      oProd.id = id;
      productos.add(oProd);
    });

    print(productos);
    return productos;
    
  }//getasync_list

}//class ProductosProvider