import 'package:sqflite/sqflite.dart';

class SchemaBuilder {
  static createTables(Database db) async {
    Batch batch = db.batch();

    batch.execute('DROP TABLE IF EXISTS Expense');

    batch.execute('''
    CREATE TABLE Expense (
      id TEXT PRIMARY KEY,
      name TEXT,
      materialId TEXT,
      projectId TEXT,
      quantity DOUBLE
    )
  ''');

    batch.execute('DROP TABLE IF EXISTS Material');

    batch.execute('''
    CREATE TABLE Material (
      id TEXT PRIMARY KEY,
      name TEXT,
      image BLOB,
      profileId TEXT
    )
  ''');

    batch.execute('DROP TABLE IF EXISTS Profile');

    batch.execute('''
    CREATE TABLE Profile (
      id TEXT PRIMARY KEY,
      name TEXT
    )
  ''');

    batch.execute('DROP TABLE IF EXISTS Project');

    batch.execute('''
    CREATE TABLE Project (
      id TEXT PRIMARY KEY,
      name TEXT,
      description LONGTEXT,
      startDate DATETIME,
      endDate DATETIME,
      estCost DOUBLE,
      profileId TEXT
    )
  ''');

    batch.execute('DROP TABLE IF EXISTS TimeEntry');

    batch.execute('''
    CREATE TABLE TimeEntry (
      id TEXT PRIMARY KEY,
      name TEXT,
      startDate DATETIME,
      endDate DATETIME,
      duration INT,
      costOfServices DOUBLE,
      projectId STRING
    )
  ''');

    await batch.commit();
  }

  static handleUpdateForProjectv1(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE Project ADD COLUMN profileId TEXT");
    await batch.commit();
  }
}
