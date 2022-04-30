import 'package:sqflite/sqflite.dart';
// import 'package:flutter/services.dart';
import 'dart:convert' as convert;
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
// import 'dart:typed_data';
// import 'dart:io';

class DatabaseService {
  static const secretKey = "9110010807980001";
  static DatabaseService? _databaseService;
  static Database? _database;

  List<String> tables = ['stockopname', 'product', 'so_detail'];

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

    var db = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
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

  Future<String> generateBackup({bool isEncrypted = true}) async {
    _database ?? await initDB();
    List data = [];
    List<Map<String, dynamic>>? listMaps = [];

    for (var i = 0; i < tables.length; i++) {
      listMaps = await _database?.query(tables[i]);

      data.add(listMaps);
    }
    List backups = [tables, data];

    String json = convert.jsonEncode(backups);

    if (isEncrypted) {
      var key = encrypt.Key.fromUtf8(secretKey);
      var iv = encrypt.IV.fromLength(16);
      var encrypter = encrypt.Encrypter(encrypt.AES(key));
      var encrypted = encrypter.encrypt(json, iv: iv);

      return encrypted.base64;
    } else {
      return json;
    }
  }

  Future<bool> restoreBackup(String backup, {bool isEncrypted = true}) async {
    _database ?? await initDB();

    Batch? batch = _database?.batch();

    var key = encrypt.Key.fromUtf8(secretKey);
    var iv = encrypt.IV.fromLength(16);
    var encrypter = encrypt.Encrypter(encrypt.AES(key));

    List json = convert
        .jsonDecode(isEncrypted ? encrypter.decrypt64(backup, iv: iv) : backup);

    if (json.isNotEmpty) {
      try {
        await _database?.transaction((txn) async {
          var batch = txn.batch();
          batch.delete(tables[0]);
          batch.delete(tables[1]);
          batch.delete(tables[2]);
          await batch.commit();
        });
      } catch (error) {
        return false;
        // throw Exception('DbBase.cleanDatabase: ' + error.toString());
      }
    }

    try {
      for (var i = 0; i < json[0].length; i++) {
        for (var k = 0; k < json[1][i].length; k++) {
          batch!.insert(json[0][i], json[1][i][k]);
        }
      }

      await batch!.commit(continueOnError: false, noResult: true);
      return true;
    } catch (error) {
      return false;
      // throw Exception('DbBase.restoreBackup: ' + error.toString());
    }
  }
}
