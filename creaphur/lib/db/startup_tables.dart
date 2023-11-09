import 'package:sqflite/sqflite.dart';

Future<void> createTables(Database db) async {
  await db.execute('''
    CREATE TABLE expenses (
      id TEXT PRIMARY KEY,
      name TEXT,
      materialId TEXT,
      projectId TEXT,
      quantity DOUBLE
    )
  ''');

  await db.execute('''
    CREATE TABLE materials (
      id TEXT PRIMARY KEY,
      name TEXT,
      image BLOB,
      profileId TEXT
    )
  ''');

  await db.execute('''
    CREATE TABLE profiles (
      id TEXT PRIMARY KEY,
      name TEXT
    )
  ''');

  await db.execute('''
    CREATE TABLE projects (
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
    CREATE TABLE timeEntries (
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
