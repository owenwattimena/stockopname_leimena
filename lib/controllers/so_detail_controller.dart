import 'package:get/get.dart';
import 'package:stockopname_leimena/models/item.dart';
import '../models/stockopname_detail.dart';
import '../providers/stockopname_detail_provider.dart';

class SoDetailController extends GetxController {
  RxString soId = ''.obs;
  Rx<List<StockopnameDetail>> listSoDetail = Rx<List<StockopnameDetail>>([]);

  void getSoDetail() {
    StockopnameDetailProvider.getStockopnameDetail(soId.value).then((value) {
      listSoDetail.value = value;
    });
  }

  void searchSoDetail(String query) {
    if (query.isNotEmpty) {
      StockopnameDetailProvider.searchStockopnameDetail(query, soId.value).then((value) {
        listSoDetail.value = value;
      });
    } else {
      getSoDetail();
    }
  }

  set stockDecrement(int index) {
    listSoDetail.update((val) {
      if (val![index].soStock! > 0) {
        val[index].soStock = val[index].soStock! - 1;
        StockopnameDetailProvider.setStock(val[index].soStock!, val[index].id!);
      }
    });
  }

  set stockIncrement(int index) {
    listSoDetail.update((val) {
      val![index].soStock = val[index].soStock! + 1;
      StockopnameDetailProvider.setStock(val[index].soStock!, val[index].id!);
    });
  }

  bool setListSoDetail(Item item) {
    // final stockopnameDetail = StockopnameDetail(
    //   barcode: item.barcode,
    //   id: null,
    //   item: item.item,
    //   lastStock: item.lastStock,
    //   sku: item.sku,
    //   soStock: 0,
    // );
    List<StockopnameDetail> soDetailItem = listSoDetail.value.where((element) => element.sku == item.sku).toList();
    if (soDetailItem.isEmpty) {
      StockopnameDetailProvider.addSoItem(item, soId.value).then((value) {
        listSoDetail.update((val) {
          val!.insert(0, value);
        });
      });

      return true;
    }
    return false;
  }
}
