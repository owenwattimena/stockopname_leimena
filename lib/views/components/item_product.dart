part of 'components.dart';

class ItemProduct extends StatelessWidget {
  final Function() onTap;
  final String? sku;
  final String? barcode;
  final String? itemName;
  final String? uom;
  final int? lastStock;

  const ItemProduct({
    Key? key,
    required this.onTap,
    this.sku,
    this.barcode,
    this.itemName,
    this.uom,
    this.lastStock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: greyLightColor,
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(sku ?? ''),
          const SizedBox(height: 3),
          Text(itemName ?? '', style: fontStyleBold16),
          const SizedBox(height: 3),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(barcode ?? ''),
            Text('Last stock: $lastStock $uom'),
          ]),
        ]),
      ),
    );
  }
}
