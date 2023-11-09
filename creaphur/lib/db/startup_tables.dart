import 'package:sqflite/sqflite.dart';

Future<void> createTables(Database db) async {
  await db.execute('''
    CREATE TABLE Expense (
      id TEXT PRIMARY KEY,
      name TEXT,
      materialId TEXT,
      projectId TEXT,
      quantity DOUBLE
    )
  ''');

  await db.execute('''
    CREATE TABLE Material (
      id TEXT PRIMARY KEY,
      name TEXT,
      image BLOB,
      profileId TEXT
    )
  ''');

  await db.execute('''
    CREATE TABLE Profile (
      id TEXT PRIMARY KEY,
      name TEXT
    )
  ''');

  await db.execute('''
    CREATE TABLE Project (
      id TEXT PRIMARY KEY,
      name TEXT,
      description LONGTEXT,
      startDate DATETIME,
      endDate DATETIME,
      estCost DOUBLE,
      ownerId TEXT
    )
  ''');

  await db.execute('''
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
}
