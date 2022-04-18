import 'package:sqflite/sqflite.dart';
import 'package:stockopname_leimena/models/item.dart';
import 'package:stockopname_leimena/models/stockopname_detail.dart';

import 'database_service.dart';

class SoDetailService {
  late DatabaseService database;

  SoDetailService() {
    database = DatabaseService();
  }

  Future<bool> storeProduct(Item item, String soId) async {
    Database db = await database.database;
    const sql = 'INSERT INTO so_detail(id, so_id, product_id, so_stock) VALUES(?,?,?,?)';
    final result = await db.rawInsert(sql, [
      null,
      soId,
      item.id,
      0
    ]);
    return result > 0;
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
}
