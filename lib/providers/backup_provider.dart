// import 'dart:convert';

import 'package:file_picker/file_picker.dart';

import '../services/database_service.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class BackupProvider {
  static backup({bool isEncript = true, String? fileName}) async {
    DatabaseService database = DatabaseService();
    String backup = await database.generateBackup(isEncrypted: isEncript);
    var dir = (await getExternalStorageDirectory())!.absolute.path;
    final String path = "$dir/$fileName.stockcounter";
    final file = File(path);
    await file.writeAsString(backup);
    return path;
  }

  static Future<bool> restoreBackup(PlatformFile file, {bool isEncrypted = true}) async {
    DatabaseService database = DatabaseService();
    final input = await File(file.path!).readAsString();
    bool result =  await database.restoreBackup(input, isEncrypted: isEncrypted);
    return result;
  }
}
