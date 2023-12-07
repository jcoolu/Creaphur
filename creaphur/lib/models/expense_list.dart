import 'package:creaphur/models/default_model_list.dart';
import 'package:creaphur/models/expense.dart';

class ExpenseList extends DefaultModelList<Expense> {
  ExpenseList(List<Expense> items) : super(items);

  void addExpense(Expense expense) {
    add(expense);
  }

  void removeExpense(Expense expense) {
    remove(expense);
  }

  void updateExpense(Expense expense) {
    update(expense);
  }

  void updateAllExpenses(List<Expense> updatedExpenses) {
    updateAll(updatedExpenses);
  }

  void addAllExpenses(List<Expense> expenses) {
    addAll(expenses);
    notifyListeners();
  }
}
