class Item{
  int? id;
  String? sku;
  String? item;
  String? barcode;
  String? uom;
  int? lastStock;

  Item({
    this.id,
    this.sku,
    this.item,
    this.barcode,
    this.uom,
    this.lastStock,
  });

  factory Item.fromMapObject(Map<String, dynamic> json)=>Item(
    id: json['id'],
    sku: json['sku'],
    item: json['product_name'],
    barcode: json['barcode'],
    uom: json['uom'],
    lastStock: json['last_stock'],
  );

  factory Item.fromArray(List array, int id) => Item(
    id: id,
    sku: array[0],
    item: array[2],
    barcode: array[1],
    uom: array[3],
    lastStock: array[4],
  );
}

List<Item> items = [
  Item(
    id: 1,
    sku: 'SKU001',
    item: 'Item 1',
    barcode: 'Barcode 1',
    uom: 'Pcs',
    lastStock: 20,
  ),
  Item(
    id: 2,
    sku: 'SKU002',
    item: 'Item 2',
    barcode: 'Barcode 2',
    uom: 'Pcs',
    lastStock: 20,
  ),
  Item(
    id: 3,
    sku: 'SKU003',
    item: 'Item 3',
    barcode: 'Barcode 3',
    uom: 'Pcs',
    lastStock: 20,
  ),
  Item(
    id: 4,
    sku: 'SKU004',
    item: 'Item 4',
    barcode: 'Barcode 4',
    uom: 'Pcs',
    lastStock: 20,
  ),
  Item(
    id: 5,
    sku: 'SKU005',
    item: 'Item 5',
    barcode: 'Barcode 5',
    uom: 'Pcs',
    lastStock: 20,
  ),
  Item(
    id: 6,
    sku: 'SKU006',
    item: 'Item 6',
    barcode: 'Barcode 6',
    uom: 'Pcs',
    lastStock: 20,
  ),
];