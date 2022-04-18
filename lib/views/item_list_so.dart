part of 'views.dart';

class ItemListSo extends StatelessWidget {
  const ItemListSo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemSoC = Get.put(ItemController());
    var soDetailC = Get.find<SoDetailController>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: TextField(
            onChanged: (value) {
              itemSoC.searchItem(value);
            },
            decoration: const InputDecoration(
              hintText: 'Cari barcode, kode atau nama',
              suffixIcon: Icon(Icons.search),
              focusColor: yellowColor,
              hoverColor: yellowColor,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.calendar_view_day),
              onPressed: () {},
            ),
          ],
        ),
        body: Obx(() => ListView.builder(
            itemCount: itemSoC.listItemSo.value.length,
            itemBuilder: (context, index) {
              return ItemProduct(
                onTap: () {
                  if (soDetailC.setListSoDetail(itemSoC.listItemSo.value[index])) {
                    Navigator.pop(context);
                  } else {
                    const snackBar = SnackBar(
                      content: Text('Item sudah di tambahkan'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                sku: itemSoC.listItemSo.value[index].sku,
                barcode: itemSoC.listItemSo.value[index].barcode,
                itemName: itemSoC.listItemSo.value[index].item,
                uom: itemSoC.listItemSo.value[index].uom,
                lastStock: itemSoC.listItemSo.value[index].lastStock,
              );
            })));
  }
}
