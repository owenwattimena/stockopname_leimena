import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:stockopname_leimena/services/product_service.dart';
import 'dart:io';

import '../models/item.dart';

class ProductProvider {
  static Future<List<Item>> getProduct({String? query}) async {
    final productService = ProductService();
    return await productService.getProduct(query: query);
  }

  static Future<void> importFile(PlatformFile file) async {
    final productService = ProductService();
    final input = File(file.path!).openRead();
    final fields = await input.transform(utf8.decoder).transform(const CsvToListConverter()).toList();
    for (int i = 0; i < fields.length; i++) {
      if (i > 0) {
        int j = 1 + i;
        await productService.storeProduct(Item.fromArray(fields[i], j));
      }
    }
  }
}
