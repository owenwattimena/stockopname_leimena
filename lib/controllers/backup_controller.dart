import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import '../providers/backup_provider.dart';

class BackupController extends GetxController {
  Rx<PlatformFile> file = Rx<PlatformFile>(PlatformFile(name: '', size: 0));

  Future<void> openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // file.value = File(result.files.single.path!);
      file.value = result.files.first;
    } else {
      // User canceled the picker
    }
  }

  void importFile() {
    BackupProvider.restoreBackup(file.value);
  }
}
