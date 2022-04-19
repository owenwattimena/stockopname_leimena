import 'dart:io';

import 'package:stockopname_leimena/models/stockopname_detail.dart';
import 'package:stockopname_leimena/providers/stockopname_detail_provider.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:file_picker/file_picker.dart';
import '../models/stockopname.dart';
import '../services/so_service.dart';

class StockopnameProvider {
  static getStockopname() async {
    final soService = SoService();
    return await soService.getSo();
  }

  static storeSo(Stockopname so) async {
    final soService = SoService();
    return await soService.storeSo(so);
  }

  static getStockopnameById(id) async {
    var result = stockopname.where((so) => so.soId == id).toList();
    return result;
  }

  static Future export(String soId) async {
    final soService = SoService();
    List<StockopnameDetail> data = await soService.getSoWithDetail(soId);
    List<List<dynamic>> rows = [
      [
        'SKU',
        'BARCODE',
        'PRODUCT NAME',
        'UOM',
        'LAST STOCK',
        'SO STOCK',
        'DEVIATION',
        'WAREHOUSE',
        'AUDITOR'
      ]
    ];
    for (var item in data) {
      List row = [];
      row.add(item.sku);
      row.add(item.barcode);
      row.add(item.item);
      row.add(item.uom);
      row.add(item.lastStock);
      row.add(item.soStock);
      row.add((item.soStock! - item.lastStock!));
      row.add(item.warehouse);
      row.add(item.auditor);

      rows.add(row);
    }
    String csv = const ListToCsvConverter().convert(rows);
    final String directory = (await getExternalStorageDirectory())!.absolute.path;
    final String path = "$directory/$soId.csv";
    final file = File(path);
    await file.writeAsString(csv);
    return path;
  }
}
