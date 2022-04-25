import '../services/database_service.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class BackupProvider {
  static backup({bool? isEncript}) async {
    DatabaseService database = DatabaseService();
    String backup = await database.generateBackup();
    var dir = await getApplicationDocumentsDirectory();
    final String path = "$dir/$backup.scd";
    final file = File(path);
    await file.writeAsString(backup);
    return path;
  }
}
