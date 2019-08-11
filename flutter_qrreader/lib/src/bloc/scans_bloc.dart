//@file:scan_bloc.dart
import 'dart:async';
import 'package:flutter_qrreader/src/models/scan_model.dart';

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

}//class ScansBloc