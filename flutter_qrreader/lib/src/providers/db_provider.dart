//db_provider.dart
import 'dart:io';

import 'package:flutter_qrreader/src/models/scan_model.dart';
import "package:path/path.dart";
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider{

  static Database _objDb;

  static final DbProvider objDbProv = DbProvider._();

  DbProvider._();

  Future<Database> get database async {
    if(_objDb != null) return _objDb;
    _objDb = await initDB();
    return _objDb;
  }//database

  initDB() async {
    Directory pathDbFolder = await getApplicationDocumentsDirectory();
  
    final pathFile = join(pathDbFolder.path, "scandb.db");
  
    return await openDatabase(
      pathFile, version: 1, onOpen: (db){}, 
      onCreate:(Database db, int version) async {
        String sql = """
        CREATE TABLE scans (
          id INTEGER PRIMARY KEY,
          tipo TEXT, 
          valor TEXT
        )
        """;
        await db.execute(sql);
      }
    );

  }//initDB

  //crear registros
  nuevoScanRaw(ScanModel oScanModel) async {
    final db = await database;
    String sql = """
    INSERT INTO scans (id, tipo, valor)
    VALUES (${oScanModel.id},'${oScanModel.tipo}','${oScanModel.valor}')
    """;
    final res = await db.rawInsert(sql);
    return res;
  }

  nuevoScan(ScanModel oScanModel) async {
    final db = await database;
    final res = db.insert("scans", oScanModel.toJson());
    return res;
  }

}//DbProvider