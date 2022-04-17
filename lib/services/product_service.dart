import 'package:sqflite/sqflite.dart';
import 'package:stockopname_leimena/models/item.dart';

import 'database_service.dart';

class ProductService {
  late DatabaseService database;

  ProductService() {
    database = DatabaseService();
  }

  Future<List<Item>> getProduct({String? query}) async {
    Database db = await database.database;
    List<Item> result = [];
    List<Map<String, Object?>> mapObject;
    if (query == null) {
      const sql = 'SELECT * FROM product';
      mapObject = await db.rawQuery(sql);
    } else {
      var sql = 'SELECT * FROM product WHERE product_name LIKE "%$query%" OR sku LIKE "%$query%" OR barcode LIKE "%$query%"';
      mapObject = await db.rawQuery(sql);
    }
    for (var i = 0; i < mapObject.length; i++) {
      result.add(Item.fromMapObject(mapObject[i]));
    }
    return result;
  }

  Future<bool> storeProduct(Item item) async {
    Database db = await database.database;
    const sql =
        'INSERT INTO product(id, sku, barcode, product_name, uom, last_stock) VALUES(?,?,?,?,?,?)';
    final result = await db.rawInsert(sql,
        [null, item.sku, item.barcode, item.item, item.uom, item.lastStock]);
    return result > 0;
  }
}
