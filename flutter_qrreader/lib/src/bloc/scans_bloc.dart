//@file:scan_bloc.dart
import 'dart:async';
import 'package:flutter_qrreader/src/models/scan_model.dart';
import 'package:flutter_qrreader/src/providers/db_provider.dart';

class ScansBloc {

  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }//factory ScansBloc

  ScansBloc._internal(){   

  }//._internal

  final _oStrmController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _oStrmController.stream;

  dispose(){
    _oStrmController?.close();
  }

  obtenerScans() async {
    _oStrmController.sink.add(await DbProvider.oDb.getScanAll());
  }

  //puede que agregar tarde un poco más, ya que es escritura por lo tanto 
  //para asegurarnos que obtenerscans se ejecute despues de nuevoScan hay que aplicar
  //async y await
  agregarScan(ScanModel oScanModel) async {
    await DbProvider.oDb.nuevoScan(oScanModel);
    //tengo que avisarle al stream que hay un nuevo registro
    obtenerScans();
  }

  borrarScan(int id) async {
    await DbProvider.oDb.deleteScan(id);
    obtenerScans();
  }

  borrarScanAll() async {
    await DbProvider.oDb.deleteScanAll();
    //_oStrmController.sink.add([]); este seria equivalnete
    obtenerScans();
  }

}//class ScansBloc