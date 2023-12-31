import 'package:creaphur/models/expense.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/screens/dashboard/main.dart';
import 'package:creaphur/screens/expense.dart';
import 'package:creaphur/screens/project.dart';
import 'package:creaphur/screens/project_overview/expenses.dart';
import 'package:creaphur/services/project_service.dart';
import 'package:creaphur/widgets/delete_dialog.dart';
import 'package:creaphur/widgets/filled_floating_action_button.dart';
import 'package:flutter/material.dart';

class ProjectOverviewScreen extends StatefulWidget {
  final Project project;
  const ProjectOverviewScreen({super.key, required this.project});

  @override
  State<ProjectOverviewScreen> createState() => _ProjectOverviewScreenState();
}

class _ProjectOverviewScreenState extends State<ProjectOverviewScreen> {
  String name = '';
  late Project? newProject = widget.project;
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    void handleBack() {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }

    void handleEdit() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProjectScreen(project: widget.project)),
      );
    }

    void handleDelete() async {
      await ProjectService.deleteProject(context, widget.project);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted Project')),
      );

      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }

    Widget handleScreen() {
      if (screenIndex == 0) {
        return const Text('');
      }
      if (screenIndex == 1) {
        return const ExpensesScreen();
      }
      return const Text('');
    }

    void createExpense() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpenseScreen(
                expense: Expense.getBlankExpense(widget.project.id)),
          ));
    }

    void handleCreate() {
      if (screenIndex == 1) {
        return createExpense();
      }
      if (screenIndex == 2) {}
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
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: handleEdit),
          DeleteDialog(
              isIconButton: true,
              buttonText: 'Delete Project',
              model: 'project',
              onDelete: handleDelete)
        ],
        title: Text(widget.project.name),
        backgroundColor: const Color(0xff2bca70),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: SafeArea(
        child: handleScreen(),
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: screenIndex,
          onDestinationSelected: (int index) {
            setState(() {
              screenIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              label: 'Overview',
              icon: Icon(Icons.account_tree_outlined, color: Color(0xff2900cc)),
              selectedIcon: Icon(Icons.account_tree, color: Color(0xff2900cc)),
              tooltip: 'Overview',
            ),
            NavigationDestination(
              label: 'Expenses',
              icon: Icon(Icons.monetization_on_outlined,
                  color: Color(0xff2900cc)),
              selectedIcon:
                  Icon(Icons.monetization_on, color: Color(0xff2900cc)),
              tooltip: 'Expenses',
            ),
            NavigationDestination(
              label: 'Time Log',
              icon: Icon(Icons.access_time, color: Color(0xff2900cc)),
              selectedIcon:
                  Icon(Icons.access_time_filled, color: Color(0xff2900cc)),
              tooltip: 'Time Log',
            ),
          ]),
      floatingActionButton: FilledFloatingActionButton(onPressed: handleCreate),
    );
  }
}
