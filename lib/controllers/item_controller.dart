import 'package:get/get.dart';
import 'package:stock_counter/providers/product_provider.dart';
import 'package:file_picker/file_picker.dart';
// import 'dart:io';
import '../models/item.dart';

class ItemController extends GetxController {
  Rx<List<Item>> listItemSo = Rx<List<Item>>([]);
  Rx<PlatformFile> file = Rx<PlatformFile>(PlatformFile(name: '', size: 0));

  @override
  void onInit() {
    super.onInit();
    getListItem();
  }

  void getListItem() {
    ProductProvider.getProduct().then((value) {
      listItemSo.value = value;
    });
  }

  void searchItem(String query) {
    if (query.isNotEmpty) {
      ProductProvider.getProduct(query: query).then((value) {
        listItemSo.value = value;
      });
    } else {
      getListItem();
    }
  }

  Future<void> openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // file.value = File(result.files.single.path!);
      file.value = result.files.first;

    } else {
      // User canceled the picker
    }
  }

  void importFile() {
    ProductProvider.importFile(file.value).then((_) {
        getListItem();
    });
  }
}
