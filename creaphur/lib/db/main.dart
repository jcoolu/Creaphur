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
        version: 14,
        onCreate: (Database db, int version) async =>
            await SchemaBuilder.createTables(db),
        onUpgrade: (Database db, oldVersion, newVersion) async {
          if (oldVersion == 13) {
            await SchemaBuilder.handleUpdateForProjectv12(db);
          }
        });
  }

  static Future<void> clearData() async {
    final db = await getDB();
    await db.transaction((txn) async {
      await txn.delete('Material');
      await txn.delete('TimeEntry');
      await txn.delete('Profile');
      await txn.delete('Expense');
      await txn.delete('Project');
    });
  }
}
