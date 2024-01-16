import 'package:creaphur/db/main.dart';
import 'package:creaphur/models/time_entry.dart';
import 'package:sqflite/sqflite.dart';

class TimeEntryHelper {
  static Future<void> addTimeEntry(TimeEntry timeEntry) async {
    final db = await DatabaseHelper.getDB();

    await db.insert(
      'TimeEntry',
      timeEntry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateTimeEntry(TimeEntry timeEntry) async {
    final db = await DatabaseHelper.getDB();

    await db.update("TimeEntry", timeEntry.toMap(),
        where: 'id = ?',
        whereArgs: [timeEntry.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteTimeEntry(TimeEntry timeEntry) async {
    final db = await DatabaseHelper.getDB();

    await db.delete("TimeEntry", where: 'id = ?', whereArgs: [timeEntry.id]);
  }

  static Future<List<TimeEntry>?> getTimeEntries(String project) async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps = await db
        .query("TimeEntry", where: 'projectId = ?', whereArgs: [project]);

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => TimeEntry.fromMap(maps[index]));
  }

  static Future<List<TimeEntry>> getAllTimeEntries(String profile) async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps = await db
        .query("TimeEntry", where: 'profileId = ?', whereArgs: [profile]);

    return List.generate(
        maps.length, (index) => TimeEntry.fromMap(maps[index]));
  }
}
