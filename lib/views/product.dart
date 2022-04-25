part of 'views.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productC = Get.put(ItemController());
    TextEditingController importFileController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Product'),
        ),
        body: Column(
          children: [
            IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Import'),
                  Row(
                    children: [
                      const Text('File'),
                      const SizedBox(width: 12),
                      Expanded(
                          child: GestureDetector(
                        onTap: () async {
                          await productC.openFilePicker();
                          importFileController.text = productC.file.value.name;
                        },
                        child: TextField(
                          enabled: false,
                          controller: importFileController,
                        ),
                      )),
                      ElevatedButton(
                        onPressed: () async {
                          productC.importFile();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            yellowColor,
                          ),
                        ),
                        child: const Text('Import File'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        productC.searchItem(value);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Cari barcode, kode atau nama',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: productC.listItemSo.value.length,
                  itemBuilder: (context, index) {
                    return ItemProduct(
                      onTap: () {},
                      sku: productC.listItemSo.value[index].sku,
                      barcode: productC.listItemSo.value[index].barcode,
                      itemName: productC.listItemSo.value[index].item,
                      uom: productC.listItemSo.value[index].uom,
                      lastStock: productC.listItemSo.value[index].lastStock,
                    );
                  })),
            )
          ],
        ));
  }
}
