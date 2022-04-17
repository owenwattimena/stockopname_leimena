// import 'dart:html';
// import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../models/stockopname.dart';
import '../providers/stockopname_provider.dart';

class HomeController extends GetxController {
  Rx<List<Stockopname>> listStockopname = Rx<List<Stockopname>>([]);

  @override
  void onInit() {
    super.onInit();
    getStockopname();
  }

  void getStockopname() {
    StockopnameProvider.getStockopname().then((value) {
      listStockopname.value = value;
    });
  }

  void storeSo({String? soId, String? createdAt, String? createdBy, String? warehouse}) {
    StockopnameProvider.storeSo(Stockopname(
      soId: soId,
      createdAt: DateTime.parse(createdAt!),
      createdBy: createdBy,
      warehouse: warehouse,
    )).then((value) {
      if (value) {
        getStockopname();
      }
    });
  }

  get generateSoId {
    return DateFormat('yyyyMMddhhmmss').format(DateTime.now());
  }

  void shareExportFile(String soId) async {
    final _share = await StockopnameProvider.export(soId);
    Share.shareFiles([_share]);
  }
}
