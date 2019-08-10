//db_provider.dart
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
    return;
  }

}//DbProvider