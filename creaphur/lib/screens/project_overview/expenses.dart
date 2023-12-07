import 'package:creaphur/models/expense.dart';
import 'package:creaphur/models/expense_list.dart';
import 'package:creaphur/screens/expense.dart';
import 'package:creaphur/widgets/expense_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Expense> expenses =
        Provider.of<ExpenseList>(context, listen: true).items;

    void selectExpense(Expense expense) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExpenseScreen(
            expense: expense,
          ),
        ),
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: expenses.isEmpty
            ? const Center(
                child: Text(
                    'No expenses found. Please click (+) below to create a new expense.'),
              )
            : SingleChildScrollView(
                child: Column(
                  children: expenses
                      .map(
                        (expense) => ExpenseSummaryCard(
                          expense: expense,
                          onTap: () => selectExpense(expense),
                        ),
                      )
                      .toList(),
                ),
              ),
      ),
    );
  }
}
