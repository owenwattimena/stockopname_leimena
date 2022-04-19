part of 'components.dart';

class ItemCount extends StatelessWidget {
  final String? itemCode;
  final String? itemName;
  final String? barcode;
  final int? stock;
  final int? lastStock;
  final String? uom;
  final Function() decrement;
  final Function() onStockClick;
  final Function() increment;

  const ItemCount({
    Key? key,
    this.itemCode,
    this.itemName,
    this.barcode,
    this.stock,
    this.uom,
    this.lastStock,
    required this.increment,
    required this.decrement,
    required this.onStockClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(itemCode ?? ''),
          Row(
            children: [
              Text(uom ?? ''),
              const SizedBox(width: 10),
              Row(children: [
                GestureDetector(
                  onTap: decrement,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    color: primaryColor,
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: onStockClick,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 9.5),
                    color: Colors.white,
                    child: Text('$stock', style: fontStyleBold16),
                  ),
                ),
                GestureDetector(
                  onTap: increment,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    color: primaryColor,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ]),
            ],
          ),
        ]),
        const SizedBox(height: 3),
        Text(itemName ?? '', style: fontStyleBold16),
        const SizedBox(height: 3),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Text(barcode ?? ''),
              const SizedBox(width: 30),
              Text('Last Stock: $lastStock'),
            ],
          ),
          Text(((stock! > lastStock!) ? '+' : '') + '${(stock! - lastStock!)}', style: (stock! < lastStock!) ? fontStyle12.copyWith(color: Colors.red) : fontStyle12.copyWith(color: Colors.black))
        ]),
      ]),
    );
  }
}
