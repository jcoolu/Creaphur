import 'package:creaphur/db/helpers/expense_helper.dart';
import 'package:creaphur/models/expense.dart';
import 'package:creaphur/models/expense_list.dart';
import 'package:provider/provider.dart';

class ExpenseService {
  static Future<void> addExpense(context, Expense expense) async {
    await ExpenseHelper.addExpense(expense);
    Provider.of<ExpenseList>(context, listen: false).add(expense);
  }

  static Future<void> updateExpense(context, Expense expense) async {
    await ExpenseHelper.updateExpense(expense);
    Provider.of<ExpenseList>(context, listen: false).update(expense);
  }

  static Future<void> deleteExpense(context, Expense expense) async {
    await ExpenseHelper.deleteExpense(expense);
    Provider.of<ExpenseList>(context, listen: false).remove(expense);
  }

  static getExpenses(context, String profileId) async {
    List<Expense> expenses = await ExpenseHelper.getAllExpenses(profileId);
    Provider.of<ExpenseList>(context, listen: false).addAllExpenses(expenses);
  }
}
