import 'package:creaphur/models/project.dart';
import 'package:creaphur/models/time_entry.dart';
import 'package:creaphur/screens/dashboard/main.dart';
import 'package:creaphur/screens/project_overview/main.dart';
import 'package:creaphur/services/time_entry_service.dart';
import 'package:creaphur/widgets/delete_dialog.dart';
import 'package:creaphur/widgets/forms/time_entry_form.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TimeEntryScreen extends StatefulWidget {
  final TimeEntry timeEntry;
  final Project project;
  const TimeEntryScreen(
      {super.key, required this.timeEntry, required this.project});

  @override
  State<TimeEntryScreen> createState() => _TimeEntryScreenState();
}

class _TimeEntryScreenState extends State<TimeEntryScreen> {
  String name = '';
  late TimeEntry? newTimeEntry = widget.timeEntry;

  @override
  Widget build(BuildContext context) {
    bool isNew = widget.timeEntry.id.isEmpty;

    void handleBack() {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }

    void handleChange(field, value) {
      newTimeEntry ??=
          widget.timeEntry; // set newTimeEntry to widget.timeEntry if null
      Map<String, dynamic> timeEntryMap = newTimeEntry!.toMap();
      timeEntryMap[field] = value;
      setState(() => newTimeEntry = TimeEntry.fromMap(timeEntryMap));
    }

    void handleSave() async {
      if (newTimeEntry!.id.isEmpty) {
        handleChange('id', const Uuid().v4());
        await TimeEntryService.addTimeEntry(context, newTimeEntry!);
      } else {
        await TimeEntryService.updateTimeEntry(context, newTimeEntry!);
      }
      // Store the current context
      BuildContext currentContext = context;
      // Check if the widget is still mounted before navigating
      if (!mounted) return;

      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text('Saved Time Entry')),
      );

      Navigator.push(
        currentContext,
        MaterialPageRoute(
            builder: (context) => ProjectOverviewScreen(
                  project: widget.project,
                  previousState: 2,
                )),
      );
    }

    void handleDelete() {
      TimeEntryService.deleteTimeEntry(context, widget.timeEntry);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted Time Entry')),
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
          title: const Text('New Time Entry'),
          backgroundColor: const Color(0xff2bca70),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          actions: <Widget>[
            if (!isNew)
              DeleteDialog(
                  isDeleteDisabled: false,
                  isIconButton: true,
                  model: 'timeEntry',
                  onDelete: handleDelete,
                  buttonText: 'Delete Time Entry',
                  confirmedWidgetPath: ProjectOverviewScreen(
                    project: widget.project,
                    previousState: 2,
                  ))
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: SingleChildScrollView(
              child: TimeEntryForm(
                onChange: handleChange,
                onSave: handleSave,
                timeEntry: newTimeEntry,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
