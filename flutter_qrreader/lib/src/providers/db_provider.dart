//db_provider.dart
import 'dart:io';

import "package:path/path.dart";
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_qrreader/src/models/scan_model.dart';
//exporta el modelo en los archivos que usan db_provider
export 'package:flutter_qrreader/src/models/scan_model.dart';

class DbProvider{

  static Database _objDb;

  static final DbProvider oDb = DbProvider._();

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
    final res = await db.insert("scans", oScanModel.toJson());
    return res;
  }

  //obtener datos
  Future<ScanModel> getScanId(int id) async {
    final db = await database;
    final res = await db.query("scans", where: "id=?",whereArgs: [id]);
    //devuelve una lista de mapas
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;   
  }

  Future<List<ScanModel>> getScanAll() async {
    final db = await database;
    final res = await db.query("scans");
    //devuelve una lista de mapas
    List<ScanModel> list = res.isNotEmpty 
                              ? res.map((c) => ScanModel.fromJson(c)).toList()
                              : [];
    return list;
  }

  Future<List<ScanModel>> getScanTipo(String tipo) async {
    final db = await database;
    String sql = """
    SELECT * FROM scans WHERE tipo='$tipo'
    """;
    final res = await db.rawQuery(sql);
    List<ScanModel> list = res.isNotEmpty 
                              ? res.map((c) => ScanModel.fromJson(c)).toList()
                              : [];
    return list;
  }

  //actualizar registros
  Future<int> updateScan(ScanModel oScanModel) async {
    final db = await database;
    //devuelve la cantidad de registros actualizados
    final res = await db.update("scans", oScanModel.toJson(),where: "id = ?",whereArgs: [oScanModel.id]);
    return res;
  }

  //actualizar registros
  Future<int> deleteScan(int id) async {
    final db = await database;
    //devuelve la cantidad de registros actualizados
    final res = await db.delete("scans",where: "id = ?",whereArgs: [id]);
    return res;
  }

  Future<int> deleteScanAll() async {
    final db = await database;
    //devuelve la cantidad de registros actualizados
    final sql = """DELETE FROM scans""";
    final res = await db.rawDelete(sql);
    return res;
  }
}//DbProvider