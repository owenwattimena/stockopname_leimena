import 'package:stock_counter/models/item.dart';
import 'package:stock_counter/services/so_detail_service.dart';
// import 'package:stock_counter/views/views.dart';

import '../models/stockopname_detail.dart';

class StockopnameDetailProvider {
  static Future<List<StockopnameDetail>> getStockopnameDetail(String soId) async {
    final soDetailService = SoDetailService();
    return soDetailService.getSoDetail(soId);
  }

  static Future<StockopnameDetail> addSoItem(Item item, String soId) async {
    final soDetailService = SoDetailService();
    return soDetailService.storeProduct(item, soId);
  }

  static searchStockopnameDetail(String query, String soId) async {
    final soDetailService = SoDetailService();
    return soDetailService.getSoDetail(soId, query: query);
  }

  static Future<bool> setStock(int stock, int idDetailSo) async {
    final soDetailService = SoDetailService();
    return await soDetailService.setStock(stock, idDetailSo);
  }
}
