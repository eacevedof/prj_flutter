//validators_bloc.dart

//esto es un streamtransformer
import 'dart:async';
import 'package:flutter_qrreader/src/models/scan_model.dart';

class Validators {

  //StreamTransformer<lista de entrada (scans), lista de salida transformada (sink)>
  final validarGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    
    handleData: (scans, sink){
      final geoScans = scans.where((s)=>s.tipo == "geo").toList();
      sink.add(geoScans);
    }//handleData

  );//fromHandlers

  final validarHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
      
      handleData: (scans, sink){
        final geoScans = scans.where((s)=>s.tipo == "http").toList();
        sink.add(geoScans);
      }//handleData

    );//fromHandlers

}//class Validators