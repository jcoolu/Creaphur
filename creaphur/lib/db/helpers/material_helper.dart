import 'package:creaphur/db/main.dart';
import 'package:creaphur/models/material.dart';
import 'package:sqflite/sqflite.dart';

class MaterialHelper {
  static Future<void> addMaterial(Material material) async {
    final db = await DatabaseHelper.getDB();

    await db.insert(
      'Material',
      material.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateMaterial(Material material) async {
    final db = await DatabaseHelper.getDB();

    await db.update("Material", material.toMap(),
        where: 'id = ?',
        whereArgs: [material.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteMaterial(Material material) async {
    final db = await DatabaseHelper.getDB();

    await db.delete("Material", where: 'id = ?', whereArgs: [material.id]);
  }

  static Future<List<Material>?> getMaterials(String project) async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps = await db
        .query("Material", where: 'projectId = ?', whereArgs: [project]);

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Material.fromMap(maps[index]));
  }

  static Future<List<Material>?> getAllMaterials(String profile) async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps = await db
        .query("Material", where: 'profileId = ?', whereArgs: [profile]);

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Material.fromMap(maps[index]));
  }
}
