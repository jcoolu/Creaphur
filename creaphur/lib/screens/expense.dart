import 'package:creaphur/models/expense.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/screens/dashboard/main.dart';
import 'package:creaphur/screens/project_overview/main.dart';
import 'package:creaphur/services/expense_service.dart';
import 'package:creaphur/widgets/delete_dialog.dart';
import 'package:creaphur/widgets/forms/expense_form.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ExpenseScreen extends StatefulWidget {
  final Expense expense;
  final Project project;
  const ExpenseScreen(
      {super.key, required this.expense, required this.project});

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
      if (newExpense!.materialId != 'None') {
        handleChange(
            'customCost', double.parse(newExpense!.getMaterialCost(context)));
      }
      if (newExpense!.id.isEmpty) {
        handleChange('id', const Uuid().v4());
        await ExpenseService.addExpense(context, newExpense!);
      } else {
        await ExpenseService.updateExpense(context, newExpense!);
      }

      // Store the current context
      BuildContext currentContext = context;
      // Check if the widget is still mounted before navigating
      if (!mounted) return;

      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text('Saved Expense')),
      );

      Navigator.push(
        currentContext,
        MaterialPageRoute(
            builder: (context) => ProjectOverviewScreen(
                  project: widget.project,
                  previousState: 1,
                )),
      );
    }

    void handleDelete() {
      ExpenseService.deleteExpense(context, widget.expense);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted Expense')),
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
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
                  confirmedWidgetPath: ProjectOverviewScreen(
                    project: widget.project,
                    previousState: 1,
                  ),
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
      ),
    );
  }
}
