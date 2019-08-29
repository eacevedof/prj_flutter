//file: productos_provider.dart

import 'dart:convert';
import 'dart:io';

import 'package:flutter_formvalidation/src/models/producto_model.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ProductosProvider{

  final String _url = "https://fir-flutter-db876.firebaseio.com";

  Future<bool> getasync_producto( ProductoModel producto) async {
    final url = "$_url/productos.json";
    final resp = await http.post(url,body:productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }//getasync_producto

  Future<bool> getasync_productoup( ProductoModel producto) async {
    final url = "$_url/productos/${producto.id}.json";
    final resp = await http.put(url,body:productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }//getasync_productoup

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

    //print(productos);
    return productos;
  }//getasync_list

  Future<int> getasync_deleted(String id) async {
    final url = "$_url/productos/$id.json";
    final resp = await http.delete(url);
    print(resp.body);
    return 1;
  }//getasync_deleted

  Future<String> subir_imagen_async(File oImagen) async {

    final oUri = Uri.parse("https://api.cloudinary.com/v1_1/ioedu/image/upload?upload_preset=yhzktxo0");
    final arMimeType = mime(oImagen.path).split("/");
    print(arMimeType.toString());
    final oImageUploadReq = http.MultipartRequest("POST",oUri);
    final oFile = await http.MultipartFile.fromPath(
      "file",
      oImagen.path,
      contentType: MediaType(arMimeType[0], arMimeType[1])
    );
    
    oImageUploadReq.files.add(oFile);
    final oStreamResp = await oImageUploadReq.send();
    final oResponse = await http.Response.fromStream(oStreamResp);

    if(oResponse.statusCode != 200 && oResponse.statusCode != 201){
      print("Algo salio mal");
      print(oResponse.body);
      return null;
    }

    final respData = json.decode(oResponse.body);
    print(respData);
    return respData["secure_url"];//devuelve la url https://imagen..

  }//subir_imagen_async

}//class ProductosProvider