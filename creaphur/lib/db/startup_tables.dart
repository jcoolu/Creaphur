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
      quantity DOUBLE,
      profileId TEXT,
      customCost DOUBLE
    )
  ''');

    batch.execute('DROP TABLE IF EXISTS Material');

    batch.execute('''
    CREATE TABLE Material (
      id TEXT PRIMARY KEY,
      name TEXT,
      image TEXT,
      profileId TEXT,
      quantityType TEXT,
      costPer DOUBLE,
      retailer TEXT
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
      profileId TEXT,
      image TEXT,
      status TEXT
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
      projectId TEXT,
      profileId TEXT,
      image TEXT
    )
  ''');

    await batch.commit();
  }

  static handleUpdateForProjectv1(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE Project ADD COLUMN profileId TEXT");
    await batch.commit();
  }

  static handleUpdateForProjectv2(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE Project ADD COLUMN image TEXT");
    await batch.commit();
  }

  static handleUpdateForProjectv3(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE Material ADD COLUMN quantity DOUBLE");
    batch.execute("ALTER TABLE Material ADD COLUMN quantityType TEXT");
    batch.execute("ALTER TABLE Material ADD COLUMN costPer DOUBLE");
    batch.execute("ALTER TABLE Material ADD COLUMN singleQuantity DOUBLE");
    await batch.commit();
  }

  static handleUpdateForProjectv4(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE Expense ADD COLUMN profileId TEXT");
    await batch.commit();
  }

  static handleUpdateForProjectv5(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE TimeEntry ADD COLUMN profileId TEXT");
    await batch.commit();
  }

  static handleUpdateForProjectv6(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE Material ADD COLUMN projectId TEXT");
    await batch.commit();
  }

  static handleUpdateForProjectv7(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE Project ADD COLUMN status TEXT");
    await batch.commit();
  }

  static handleUpdateForProjectv8(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE Material DROP COLUMN projectId");
    await batch.commit();
  }

  static handleUpdateForProjectv9(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE Material ADD COLUMN retailer");
    await batch.commit();
  }

  static handleUpdateForProjectv10(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE Material DROP COLUMN singleQuantity");
    await batch.commit();
  }

  static handleUpdateForProjectv11(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE Material DROP COLUMN quantity");
    await batch.commit();
  }

  static handleUpdateForProjectv12(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE Expense ADD COLUMN customCost");
    await batch.commit();
  }

  static handleUpdateForProjectv13(Database db) async {
    Batch batch = db.batch();
    batch.execute("ALTER TABLE TimeEntry ADD COLUMN image");
    await batch.commit();
  }
}
