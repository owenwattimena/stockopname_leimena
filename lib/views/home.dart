part of 'views.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController idSoController = TextEditingController();
    TextEditingController soDateController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController warehouseController = TextEditingController();
    var homeC = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('SO RSUP Dr.J.LEIMENA'),
        actions: [
          IconButton(
            icon: const Icon(Icons.view_module),
            onPressed: () {
              Navigator.pushNamed(context, 'product');
            },
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: homeC.listStockopname.value.length,
          itemBuilder: (context, index) {
            return ItemSo(
              createdAt: homeC.listStockopname.value[index].createdAt!,
              createdBy: homeC.listStockopname.value[index].createdBy!,
              onTap: () async {
                await Navigator.pushNamed(context, 'detail_so', arguments: homeC.listStockopname.value[index].soId);
                Get.delete<SoDetailController>();
              },
              onLongTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return IntrinsicHeight(
                        child: Column(children: [
                          ListTile(
                            leading: const Icon(Icons.share),
                            title: const Text('Bagikan'),
                            onTap: () {
                              homeC.shareExportFile(homeC.listStockopname.value[index].soId!);
                            },
                          ),
                        ]),
                      );
                    });
              },
              warehouse: homeC.listStockopname.value[index].warehouse!,
              totalItemSo: homeC.listStockopname.value[index].totalSoItem!,
              soId: homeC.listStockopname.value[index].soId!,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          idSoController.text = homeC.generateSoId;
          soDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Create SO',
                    textAlign: TextAlign.center,
                  ),
                  content: IntrinsicHeight(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: idSoController,
                          decoration: const InputDecoration(
                            enabled: false,
                            labelText: 'SO Id',
                          ),
                        ),
                        TextFormField(
                          controller: soDateController,
                          decoration: const InputDecoration(
                            enabled: false,
                            labelText: 'SO Date',
                          ),
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Auditor Name',
                          ),
                        ),
                        TextFormField(
                          controller: warehouseController,
                          decoration: const InputDecoration(
                            labelText: 'Warehouse',
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
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: ElevatedButton(
                            child: const Text('CREATE'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                primaryColor,
                              ),
                            ),
                            onPressed: () {
                              homeC.storeSo(
                                soId: idSoController.text,
                                createdBy: nameController.text,
                                warehouse: warehouseController.text,
                                createdAt: soDateController.text,
                              );
                              Navigator.pop(context);
                            },
                          ),
                        )),
                      ],
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
    );
  }
}
