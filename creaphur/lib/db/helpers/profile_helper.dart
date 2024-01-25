import 'package:creaphur/db/main.dart';
import 'package:creaphur/models/profile.dart';
import 'package:sqflite/sqflite.dart';

class ProfileHelper {
  static Future<void> addProfile(Profile profile) async {
    final db = await DatabaseHelper.getDB();

    await db.insert(
      'Profile',
      profile.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateProfile(Profile profile) async {
    final db = await DatabaseHelper.getDB();

    await db.update("Profile", profile.toMap(),
        where: 'id = ?',
        whereArgs: [profile.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteProfile(Profile profile) async {
    final db = await DatabaseHelper.getDB();

    await db.delete("Profile", where: 'id = ?', whereArgs: [profile.id]);
  }

  static Future<List<Profile>> getProfiles() async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps = await db.query("Profile");

    return List.generate(maps.length, (index) => Profile.fromMap(maps[index]));
  }
}
