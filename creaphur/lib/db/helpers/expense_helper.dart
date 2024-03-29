import 'package:creaphur/db/main.dart';
import 'package:creaphur/models/expense.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseHelper {
  static Future<void> addExpense(Expense expense) async {
    final db = await DatabaseHelper.getDB();

    await db.insert(
      'Expense',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateExpense(Expense expense) async {
    final db = await DatabaseHelper.getDB();

    await db.update("Expense", expense.toMap(),
        where: 'id = ?',
        whereArgs: [expense.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteExpense(Expense expense) async {
    final db = await DatabaseHelper.getDB();

    await db.delete("Expense", where: 'id = ?', whereArgs: [expense.id]);
  }

  static Future<List<Expense>> getExpenses(String project) async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps =
        await db.query("Expense", where: 'projectId = ?', whereArgs: [project]);

    return List.generate(maps.length, (index) => Expense.fromMap(maps[index]));
  }

  static Future<List<Expense>> getAllExpenses(String profile) async {
    final db = await DatabaseHelper.getDB();

    final List<Map<String, dynamic>> maps =
        await db.query("Expense", where: 'profileId = ?', whereArgs: [profile]);

    return List.generate(maps.length, (index) => Expense.fromMap(maps[index]));
  }
}
