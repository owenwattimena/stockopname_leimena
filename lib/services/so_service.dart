import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_counter/models/stockopname.dart';
// import 'package:stock_counter/models/stockopname.dart';
import 'package:stock_counter/services/database_service.dart';

import '../models/stockopname_detail.dart';

class SoService {
  late DatabaseService database;

  SoService() {
    database = DatabaseService();
  }

  Future<List<Stockopname>> getSo() async {
    Database db = await database.database;
    const sql = '''
      SELECT * FROM stockopname ORDER BY id DESC
    ''';
    final mapObject = await db.rawQuery(sql);
    List<Stockopname> result = [];
    for (var i = 0; i < mapObject.length; i++) {
      const sql = 'SELECT COUNT(*) FROM so_detail WHERE so_id=?';
      int? total = Sqflite.firstIntValue(await db.rawQuery(sql, [
        mapObject[i]['so_id']
      ]));
      result.add(Stockopname.fromJson(mapObject[i], totalItem: total));
    }
    return result;
  }

  Future<List<StockopnameDetail>> getSoWithDetail(String soId) async {
    Database db = await database.database;
    const sql = '''
      SELECT * FROM stockopname
      JOIN so_detail ON stockopname.so_id = so_detail.so_id
      JOIN product ON so_detail.product_id = product.id
      WHERE stockopname.so_id = ?
    ''';
    final mapObject = await db.rawQuery(sql, [
      soId
    ]);
    List<StockopnameDetail> result = [];
    for (var i = 0; i < mapObject.length; i++) {
      result.add(StockopnameDetail.fromMapObject(mapObject[i]));
    }
    return result;
  }

  Future<bool> storeSo(Stockopname so) async {
    Database db = await database.database;
    const sql = 'INSERT INTO stockopname(id, so_id, created_at, created_by, warehouse) VALUES(?,?,?,?,?)';
    final result = await db.rawInsert(sql, [
      null,
      so.soId,
      DateFormat('yyyy-MM-dd').format(so.createdAt!),
      so.createdBy,
      so.warehouse
    ]);
    return result > 0;
  }
}
