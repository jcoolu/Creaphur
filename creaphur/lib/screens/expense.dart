import 'package:creaphur/models/expense.dart';
import 'package:creaphur/screens/dashboard/main.dart';
import 'package:creaphur/services/expense_service.dart';
import 'package:creaphur/widgets/delete_dialog.dart';
import 'package:creaphur/widgets/forms/expense_form.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ExpenseScreen extends StatefulWidget {
  final Expense expense;
  const ExpenseScreen({super.key, required this.expense});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  String name = '';
  late Expense? newExpense = widget.expense;

  @override
  Widget build(BuildContext context) {
    bool isNew = widget.expense.id.isEmpty;

    void handleBack() {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }

    void handleChange(field, value) {
      newExpense ??= widget.expense; // set newExpense to widget.expense if null
      Map<String, dynamic> expenseMap = newExpense!.toMap();
      expenseMap[field] = value;
      setState(() => newExpense = Expense.fromMap(expenseMap));
    }

    void handleSave() async {
      if (newExpense!.id.isEmpty) {
        handleChange('id', const Uuid().v4());
        await ExpenseService.addExpense(context, newExpense!);
      } else {
        await ExpenseService.updateExpense(context, newExpense!);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved Expense')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }

    void handleDelete() {
      ExpenseService.deleteExpense(context, widget.expense);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted Expense')),
      );

      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: const Color(0xff1d874b),
            height: 3.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: handleBack,
        ),
        title: const Text('New Expense'),
        backgroundColor: const Color(0xff2bca70),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        actions: <Widget>[
          if (!isNew)
            DeleteDialog(
                isDeleteDisabled: false,
                isIconButton: true,
                model: 'expense',
                onDelete: handleDelete,
                buttonText: 'Delete Expense')
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SingleChildScrollView(
            child: ExpenseForm(
              onChange: handleChange,
              onSave: handleSave,
              expense: newExpense,
            ),
          ),
        ),
      ),
    );
  }
}
