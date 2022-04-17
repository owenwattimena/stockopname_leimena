import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stockopname_leimena/models/stockopname.dart';
// import 'package:stockopname_leimena/models/stockopname.dart';
import 'package:stockopname_leimena/services/database_service.dart';

class SoService{
  late DatabaseService database;

  SoService(){
    database = DatabaseService();
  }

  Future<List<Stockopname>> getSo() async {
    Database db = await database.database;
    const sql = 'SELECT * FROM stockopname';
    final mapObject = await db.rawQuery(sql); 
    List<Stockopname> result = [];
    for (var i = 0; i < mapObject.length; i++) {
      result.add(Stockopname.fromJson(mapObject[i]));
    }
    return result;
  }

  Future<bool> storeSo(Stockopname so) async {
    Database db = await database.database;
    const sql = 'INSERT INTO stockopname(id, so_id, created_at, created_by, warehouse) VALUES(?,?,?,?,?)';
    final result = await db.rawInsert(sql, [null, so.soId, DateFormat('yyyy-MM-dd').format(so.createdAt!), so.createdBy, so.warehouse]);
    return result > 0;
  }
}