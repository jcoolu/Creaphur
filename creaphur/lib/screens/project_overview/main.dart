import 'dart:io';

import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/expense.dart';
import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/models/time_entry.dart';
import 'package:creaphur/screens/dashboard/main.dart';
import 'package:creaphur/screens/expense.dart';
import 'package:creaphur/screens/project.dart';
import 'package:creaphur/screens/project_overview/expenses.dart';
import 'package:creaphur/screens/project_overview/overview.dart';
import 'package:creaphur/screens/project_overview/time_log.dart';
import 'package:creaphur/screens/time_entry.dart';
import 'package:creaphur/services/project_service.dart';
import 'package:creaphur/widgets/delete_dialog.dart';
import 'package:creaphur/widgets/filled_floating_action_button.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'quote_list.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'dart:ui';

class ProjectOverviewScreen extends StatefulWidget {
  final int? previousState;
  final Project project;
  const ProjectOverviewScreen(
      {super.key, required this.project, this.previousState});

  @override
  State<ProjectOverviewScreen> createState() => _ProjectOverviewScreenState();
}

class _ProjectOverviewScreenState extends State<ProjectOverviewScreen> {
  String name = '';
  late Project? newProject = widget.project;
  late int screenIndex;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  String randomText = QuoteList.getRandomText();

  @override
  void initState() {
    screenIndex = widget.previousState ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Profile currentProfile = Provider.of<Profile>(context, listen: true);

    void handleChangeMonthYear(int month, int year) {
      setState(() => selectedMonth = month);
      setState(() => selectedYear = year);
    }

    void handleBack() {
      Navigator.push(
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

    Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
      final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
      final font = await PdfGoogleFonts.nunitoExtraLight();

      pdf.addPage(
        pw.Page(
          pageFormat: format,
          build: (context) {
            return pw.Column(
              children: [
                pw.Text(widget.project.name,
                    style: const TextStyle(fontSize: 25)),
                pw.SizedBox(
                  width: double.infinity,
                  child: pw.FittedBox(
                    child: pw.Text(title, style: pw.TextStyle(font: font)),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Flexible(child: pw.FlutterLogo()),
              ],
            );
          },
        ),
      );

      return pdf.save();
    }

    void handlePDF() async {
      final directory = await getTemporaryDirectory();
      final tempFilePath = '${directory.path}/${Utils.saveDataFileName}';

      // Create and write to a temporary file
      final tempFile = File(tempFilePath);
      final data = header +
          profileData +
          materialData +
          expenseData +
          timeEntryData +
          projectData;
      await tempFile.writeAsString(data);

      // Use the share plugin to let the user choose where to save the file
      await Share.shareXFiles([XFile(tempFilePath)], text: 'Save your file');

      // Clean up the temporary file
      await tempFile.delete();
    }

    void handleDelete() async {
      await ProjectService.deleteProject(context, widget.project);

      // Store the current context
      BuildContext currentContext = context;
      // Check if the widget is still mounted before navigating
      if (!mounted) return;

      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text('Deleted Project')),
      );
    }

    Widget handleScreen() {
      if (screenIndex == 0) {
        return OverviewScreen(
          project: widget.project,
          onChange: handleChangeMonthYear,
          month: selectedMonth,
          year: selectedYear,
        );
      }
      if (screenIndex == 1) {
        return ExpensesScreen(project: widget.project);
      }

      if (screenIndex == 2) {
        return TimeEntriesScreen(project: widget.project);
      }
      return const Text('');
    }

    void createExpense() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpenseScreen(
                project: widget.project,
                expense: Expense.getBlankExpense(
                    widget.project.id, currentProfile.id)),
          ));
    }

    void createTimeEntry() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TimeEntryScreen(
                project: widget.project,
                timeEntry: TimeEntry.getBlankTimeEntry(
                    widget.project.id, currentProfile.id)),
          ));
    }

    void handleCreate() {
      if (screenIndex == 1) {
        return createExpense();
      }
      if (screenIndex == 2) {
        return createTimeEntry();
      }
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
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                onPressed: handlePDF),
            IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: handleEdit),
            DeleteDialog(
                isDeleteDisabled: false,
                isIconButton: true,
                buttonText: 'Delete Project',
                model: 'project',
                confirmedWidgetPath: const Dashboard(),
                onDelete: handleDelete)
          ],
          title: Text(widget.project.name),
          backgroundColor: const Color(0xff2bca70),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: handleScreen()), // Existing screen content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '"$randomText"',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
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
                icon:
                    Icon(Icons.account_tree_outlined, color: Color(0xff2900cc)),
                selectedIcon:
                    Icon(Icons.account_tree, color: Color(0xff2900cc)),
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
        floatingActionButton: screenIndex != 0
            ? FilledFloatingActionButton(onPressed: handleCreate)
            : null,
      ),
    );
  }
}
