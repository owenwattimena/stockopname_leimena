part of 'components.dart';

class ItemSo extends StatelessWidget {
  final Function() onTap;
  final Function()? onLongTap;
  final DateTime createdAt;
  final String soId;
  final int totalItemSo;
  final String warehouse;
  final String createdBy;

  const ItemSo(
      {Key? key, required this.onTap,
      required this.createdAt,
      required this.soId,
      required this.totalItemSo,
      required this.warehouse,
      required this.createdBy, this.onLongTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongTap,
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
          Text(DateFormat('E, dd-MMMM-y').format(createdAt)),
          const SizedBox(height: 3),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(soId, style: fontStyleBold16),
            Text(totalItemSo.toString() + ' item(s)'),
          ]),
          const SizedBox(height: 3),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(warehouse),
            const SizedBox(width: 30),
            Text(createdBy),
          ]),
        ]),
      ),
    );
  }
}
