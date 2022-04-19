part of 'views.dart';

class DetailSo extends StatelessWidget {
  const DetailSo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var detailSoC = Get.put(SoDetailController());

    TextEditingController searchController = TextEditingController();

    final args = ModalRoute.of(context)!.settings.arguments as String;
    detailSoC.soId.value = args;
    detailSoC.getSoDetail();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(args.toString()),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    detailSoC.searchSoDetail(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Cari barcode, kode atau nama',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_view_day),
                onPressed: () {},
              ),
            ]),
            Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: detailSoC.listSoDetail.value.length,
                  itemBuilder: (context, index) {
                    return ItemCount(
                      decrement: () => detailSoC.stockDecrement = index,
                      onStockClick: () => showStockDialog(context, index, detailSoC.listSoDetail.value[index].soStock!.toString()),
                      increment: () => detailSoC.stockIncrement = index,
                      itemCode: detailSoC.listSoDetail.value[index].sku,
                      itemName: detailSoC.listSoDetail.value[index].item,
                      barcode: detailSoC.listSoDetail.value[index].barcode,
                      stock: detailSoC.listSoDetail.value[index].soStock,
                      lastStock: detailSoC.listSoDetail.value[index].lastStock,
                      uom: detailSoC.listSoDetail.value[index].uom,
                    );
                  })),
            )
          ],
        ),
        floatingActionButton: Stack(
          children: [
            FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () async {
                await Navigator.pushNamed(context, 'item_list_so');
                Get.delete<ItemController>();
              },
              child: const Icon(Icons.add),
            ),
          ],
        ));
  }

  void showStockDialog(BuildContext context, int index, String stock) {
    final detailSoC = Get.find<SoDetailController>();
    TextEditingController stockController = TextEditingController(text: stock);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Input Stock',
              textAlign: TextAlign.center,
            ),
            content: IntrinsicHeight(
              child: Column(
                children: [
                  TextFormField(
                    controller: stockController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Stock',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: ElevatedButton(
                        child: const Text('CANCEL'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            yellowColor,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: ElevatedButton(
                      child: const Text('OK'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          primaryColor,
                        ),
                      ),
                      onPressed: () {
                        detailSoC.stockSo(index, int.parse(stockController.text));
                        Navigator.pop(context);
                      },
                    ),
                  )),
                ],
              )
            ],
          );
        });
  }
}
