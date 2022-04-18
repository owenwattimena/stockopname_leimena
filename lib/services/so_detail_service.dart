import 'package:sqflite/sqflite.dart';
import 'package:stockopname_leimena/models/item.dart';
// import 'package:stockopname_leimena/models/stockopname.dart';
import 'package:stockopname_leimena/models/stockopname_detail.dart';

import 'database_service.dart';

class SoDetailService {
  late DatabaseService database;

  SoDetailService() {
    database = DatabaseService();
  }

  Future<StockopnameDetail> storeProduct(Item item, String soId) async {
    Database db = await database.database;
    const sql = 'INSERT INTO so_detail(id, so_id, product_id, so_stock) VALUES(?,?,?,?)';
    final result = await db.rawInsert(sql, [
      null,
      soId,
      item.id,
      0
    ]);
    if (result > 0) {
      final List<Map<String, Object?>> data = await db.rawQuery("SELECT * FROM so_detail ORDER BY id DESC LIMIT 1");
      if (data.isNotEmpty) {
        final List<StockopnameDetail> list = await getSoDetailById(data[0]['so_id'].toString(), int.parse(data[0]['id'].toString()));
        return list[0];
      }
    }
    return StockopnameDetail();
  }

  Future<List<StockopnameDetail>> getSoDetailById(String soId, int id) async {
    Database db = await database.database;
    List<Map<String, Object?>> mapObject;
    const sql = '''
    SELECT 
    so_detail.id, 
    so_detail.so_id, 
    product.sku, 
    product.product_name, 
    product.barcode, 
    product.uom, 
    so_detail.so_stock, 
    product.last_stock
    FROM so_detail
    JOIN product ON so_detail.product_id = product.id
    JOIN stockopname ON so_detail.so_id = stockopname.so_id
    WHERE so_detail.so_id = ? AND so_detail.id = ?
    ''';
    mapObject = await db.rawQuery(sql, [
      soId,
      id
    ]);
    List<StockopnameDetail> result = [];
    for (var i = 0; i < mapObject.length; i++) {
      result.add(StockopnameDetail.fromMapObject(mapObject[i]));
    }
    return result;
  }

  Future<List<StockopnameDetail>> getSoDetail(String soId, {String? query}) async {
    Database db = await database.database;
    List<Map<String, Object?>> mapObject;
    if (query == null) {
      const sql = '''
    SELECT 
    so_detail.id, 
    so_detail.so_id, 
    product.sku, 
    product.product_name, 
    product.barcode, 
    product.uom, 
    so_detail.so_stock, 
    product.last_stock
    FROM so_detail
    JOIN product ON so_detail.product_id = product.id
    JOIN stockopname ON so_detail.so_id = stockopname.so_id
    WHERE so_detail.so_id = ?
    ORDER BY so_detail.id DESC
    ''';
      mapObject = await db.rawQuery(sql, [
        soId
      ]);
    } else {
      final sql = '''
    SELECT 
    so_detail.id, 
    so_detail.so_id, 
    product.sku, 
    product.product_name, 
    product.barcode, 
    product.uom, 
    so_detail.so_stock, 
    product.last_stock
    FROM so_detail
    JOIN product ON so_detail.product_id = product.id
    JOIN stockopname ON so_detail.so_id = stockopname.so_id
    WHERE so_detail.so_id = ? AND 
    (product.sku LIKE '%$query%' OR product.product_name LIKE '%$query%' OR product.barcode LIKE '%$query%')
    ORDER BY so_detail.id DESC

    ''';
      mapObject = await db.rawQuery(sql, [
        soId
      ]);
    }
    List<StockopnameDetail> result = [];
    for (var i = 0; i < mapObject.length; i++) {
      result.add(StockopnameDetail.fromMapObject(mapObject[i]));
    }
    return result;
  }

  Future<bool> setStock(int stock, int idDetailSo) async {
    Database db = await database.database;
    final sql = 'UPDATE so_detail SET so_stock = $stock WHERE id = $idDetailSo';
    final result = await db.rawUpdate(sql);
    return result > 0;
  }
}
