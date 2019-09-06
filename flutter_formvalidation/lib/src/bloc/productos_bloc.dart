//productos_bloc.dart
import 'dart:io';

import 'package:flutter_formvalidation/src/models/producto_model.dart';
import 'package:flutter_formvalidation/src/providers/productos_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProductosBloc {

  final _oProductsBehav = new BehaviorSubject<List<ProductoModel>>();
  final _oCargandoBehav = new BehaviorSubject<bool>();

  final _oProductProv = new ProductosProvider();
  
  Stream<List<ProductoModel>> get get_productos_stream => _oProductsBehav.stream;
  Stream<bool> get get_cargando_stream => _oCargandoBehav.stream;

  /*
   * devuelve el listado de productos
   */
  void cargar_productos_async() async {
    final productos = await _oProductProv.getasync_list();
    _oProductsBehav.sink.add(productos);
  }

  void agregar_producto_async(ProductoModel oProducto) async {
    //se estan cargando los productos
    _oCargandoBehav.sink.add(true);//esta cargando
    await _oProductProv.getasync_producto(oProducto);
    _oCargandoBehav.sink.add(false);
  }

  Future<String> subir_foto_async(File oFoto) async {
    //se estan cargando los productos
    _oCargandoBehav.sink.add(true);//esta cargando
    final fotourl = await _oProductProv.subir_imagen_async(oFoto);
    _oCargandoBehav.sink.add(false);
    return fotourl;
  }

  void editar_producto_async(ProductoModel oProducto) async {
    //se estan cargando los productos
    _oCargandoBehav.sink.add(true);//esta cargando
    await _oProductProv.getasync_productoup(oProducto);
    _oCargandoBehav.sink.add(false);
  }

  void borrar_producto_async(String id) async {
    await _oProductProv.getasync_deleted(id);
  }

  dispose(){
    _oProductsBehav?.close();
    _oCargandoBehav?.close();
  }

}//class ProductosBloc