import 'package:creaphur/db/main.dart';
import 'package:creaphur/models/project.dart';
import 'package:sqflite/sqflite.dart';

class ProjectHelper {
  static Future<void> addProject(Project project) async {
    final db = await DatabaseHelper.getDB();

    await db.insert(
      'Project',
      project.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateProject(Project project) async {
    final db = await DatabaseHelper.getDB();

    await db.update("Project", project.toMap(),
        where: 'id = ?',
        whereArgs: [project.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteProject(Project project) async {
    final db = await DatabaseHelper.getDB();

    await db.delete("Project", where: 'id = ?', whereArgs: [project.id]);
  }

  static Future<List<Project>> getProjects(String profile) async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps =
        await db.query("Project", where: 'profileId = ?', whereArgs: [profile]);

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (index) => Project.fromMap(maps[index]));
  }

  static Future<List<Project>> getAllProjects(String profile) async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps = await db.query("Project");

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (index) => Project.fromMap(maps[index]));
  }
}
