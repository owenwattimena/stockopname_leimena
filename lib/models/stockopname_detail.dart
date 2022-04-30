// import 'package:stock_counter/models/stockopname.dart';

class StockopnameDetail {
  int? id;
  String? soId;
  String? sku;
  String? item;
  String? barcode;
  String? uom;
  String? auditor;
  String? warehouse;
  int? soStock;
  int? lastStock;

  StockopnameDetail({
    this.id,
    this.soId,
    this.sku,
    this.item,
    this.barcode,
    this.uom,
    this.auditor,
    this.warehouse,
    this.soStock,
    this.lastStock,
  });

  factory StockopnameDetail.fromMapObject(Map<String, dynamic> json) => StockopnameDetail(
        id: json['id'],
        soId: json['so_id'],
        sku: json['sku'],
        item: json['product_name'],
        barcode: json['barcode'],
        uom: json['uom'],
        auditor: json['created_by'],
        warehouse: json['warehouse'],
        soStock: json['so_stock'],
        lastStock: json['last_stock'],
      );
}
// List<StockopnameDetail> soDetail = [];

List<StockopnameDetail> soDetail = [
  StockopnameDetail(
    id: 1,
    soId: "SO-001",
    sku: 'SKU001',
    item: 'Item 1',
    barcode: 'Barcode 1',
    uom: 'Pcs',
    soStock: 0,
    lastStock: 20,
  ),
  StockopnameDetail(
    id: 2,
    soId: "SO-001",
    sku: 'SKU002',
    item: 'Item 2',
    barcode: 'Barcode 2',
    uom: 'Pcs',
    soStock: 1000,
    lastStock: 20,
  ),
  StockopnameDetail(
    id: 3,
    soId: "SO-002",
    sku: 'SKU003',
    item: 'Item 3',
    barcode: 'Barcode 3',
    uom: 'Pcs',
    soStock: 1000,
    lastStock: 20,
  ),
];
