import 'package:creaphur/db/startup_tables.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> getDB() async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
    String path = await getDatabasesPath();
    String databasePath = join(path, 'creaphur_database.db');

    return await openDatabase(databasePath,
        version: 12,
        onCreate: (Database db, int version) async =>
            await SchemaBuilder.createTables(db),
        onUpgrade: (Database db, oldVersion, newVersion) async {
          if (oldVersion == 11) {
            await SchemaBuilder.handleUpdateForProjectv10(db);
          }
        });
  }
}
