part of 'views.dart';

class RestoreBackup extends StatelessWidget {
  const RestoreBackup({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var backupC = Get.put(BackupController());
    TextEditingController importFileController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Restore Backup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Restore'),
            Row(children: [
              const Text('File'),
              const SizedBox(width: 12),
              Expanded(
                  child: GestureDetector(
                onTap: () async {
                  await backupC.openFilePicker();
                  importFileController.text = backupC.file.value.name;
                },
                child: TextField(
                  enabled: false,
                  controller: importFileController,
                ),
              )),
              ElevatedButton(
                onPressed: () async {
                  bool result = await backupC.importFile();
                  if(result) {
                    const snackBar = SnackBar(
                        content: Text('Data berhasil di pulihkan'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    const snackBar = SnackBar(
                        content: Text('Data gagal di pulihkan'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    yellowColor,
                  ),
                ),
                child: const Text('Import File'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
