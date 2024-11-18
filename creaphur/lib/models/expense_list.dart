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

  List getDataTable(context, String projectId) {
    return items
        .where((exp) => exp.projectId == projectId)
        .map((exp) => [
              exp.getMaterialName(context) ?? exp.name,
              "${exp.quantity} ${exp.getMaterialUnit(context)}",
              exp.getMaterialCost(context),
              exp.getMaterialRetailer(context)
            ])
        .toList();
  }

  List getDataTableForPieChart(context, String projectId) {
    return items
        .where((exp) => exp.projectId == projectId)
        .map((exp) => [
              exp.getMaterialName(context) ?? exp.name,
              exp.getMaterialCost(context)
            ])
        .toList();
  }

  List getDataTableForPieChartMarterials(context, String projectId) {
    List<Expense> expensesWithMaterials = [];
    for (Expense item in items) {
      if (item.materialId != 'None') {
        expensesWithMaterials.add(item);
      }
    }
    return expensesWithMaterials
        .where((exp) => exp.projectId == projectId)
        .map((Expense exp) =>
            [exp.getMaterialName(context) ?? exp.name, exp.quantity])
        .toList();
  }

  double getTotalCost(context) {
    return items
        .map((exp) => exp.getCost(context))
        .reduce((value, element) => value + element);
  }

  double getTotalQuantityUse(context) {
    List<Expense> expensesWithMaterials = [];
    for (Expense item in items) {
      if (item.materialId != 'None') {
        expensesWithMaterials.add(item);
      }
    }
    return expensesWithMaterials
        .map((exp) => exp.quantity)
        .reduce((value, element) => value + element);
  }
}
