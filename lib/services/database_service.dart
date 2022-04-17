import 'package:sqflite/sqflite.dart';
// import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
// import 'dart:typed_data';
// import 'dart:io';

class DatabaseService {
  static DatabaseService? _databaseService;
  static Database? _database;

  DatabaseService._createInstance();

  factory DatabaseService() {
    _databaseService ??= DatabaseService._createInstance();

    return _databaseService!;
  }

  Future<Database> initDB() async {
    /// Ambil direktori aplikasi di perangkat
    var dbDir = await getApplicationDocumentsDirectory();
    var dbPath = join(dbDir.path, 'stockopname.db');

    // await deleteDatabase(dbPath);

    var db = await openDatabase(dbPath, version: 1, onCreate: (Database db, int version)async{
      await db.execute('''
      CREATE TABLE stockopname (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        so_id TEXT,
        created_at TEXT,
        created_by TEXT,
        warehouse TEXT
      )
      ''');
      await db.execute('''
      CREATE TABLE product (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sku TEXT,
        barcode TEXT,
        product_name TEXT,
        uom TEXT,
        last_stock INTEGER
      )
      ''');
      await db.execute('''
      CREATE TABLE so_detail (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        so_id TEXT,
        product_id TEXT,
        so_stock INTEGER
      )
      ''');
    });
    // return getDB();
    return db;
  }

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  // ambil data nyanyian dengan kondisi
  // Future getWhere({String search}) async {
  //   Database db = await this.database;
  //   var sql;
  //   if (search != null) {
  //     sql =
  //         "SELECT * FROM nyanyian WHERE judul LIKE '$search%' ORDER BY no ASC";
  //   } else {
  //     sql = "SELECT * FROM nyanyian ORDER BY no ASC";
  //   }

  //   var mapObject = await db.rawQuery(sql);

  //   int mapLength = mapObject.length;
  //   List<Nyanyian> listNyanyian = new List<Nyanyian>();

  //   for (int i = 0; i < mapLength; i++) {
  //     listNyanyian.add(Nyanyian.fromMapObject(mapObject[i]));
  //   }
  //   return ReturnValue(value: listNyanyian);
  // }

  // ambil data favorit
  // Future<ReturnValue> getFavorit({String search}) async {
  //   Database db = await this.database;

  //   var sql = "SELECT * FROM nyanyian WHERE favorit = 1 ORDER BY no ASC";

  //   var mapObject = await db.rawQuery(sql);

  //   int mapLength = mapObject.length;
  //   List<Nyanyian> listNyanyian = new List<Nyanyian>();

  //   for (int i = 0; i < mapLength; i++) {
  //     listNyanyian.add(Nyanyian.fromMapObject(mapObject[i]));
  //   }
  //   return ReturnValue(value: listNyanyian);
  // }

  // Future<ReturnValue> setFavorit(int id, int favorit) async {
  //   Database db = await this.database;
  //   var sql;
  //   if (favorit == 0) {
  //     sql = "UPDATE nyanyian SET favorit = 1 WHERE id = $id";
  //   } else {
  //     sql = "UPDATE nyanyian SET favorit = 0 WHERE id = $id";
  //   }
  //   int result = await db.rawUpdate(sql);
  //   if (result == 1) {
  //     return ReturnValue(value: true);
  //   }
  //   return ReturnValue(message: "error");
  // }

  // // ambil data ayat berdasarkan nyanyian
  // Future<List<Ayat>> getAyat(int idAyat) async {
  //   Database db = await this.database;
  //   var sql;

  //   sql = "SELECT * FROM ayat WHERE id_nyanyian = $idAyat ORDER BY no ASC";

  //   var mapObject = await db.rawQuery(sql);

  //   int mapLength = mapObject.length;
  //   List<Ayat> listAyat = new List<Ayat>();
  //   for (int i = 0; i < mapLength; i++) {
  //     listAyat.add(Ayat.fromMap(mapObject[i]));
  //   }
  //   return listAyat;
  // }
}