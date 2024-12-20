import 'package:creaphur/models/project.dart';
import 'package:creaphur/screens/dashboard/main.dart';
import 'package:creaphur/services/project_service.dart';
import 'package:creaphur/widgets/delete_dialog.dart';
import 'package:creaphur/widgets/forms/project_form.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProjectScreen extends StatefulWidget {
  final Project project;
  const ProjectScreen({super.key, required this.project});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  String name = '';
  late Project? newProject = widget.project;

  @override
  Widget build(BuildContext context) {
    bool isNew = widget.project.id.isEmpty;

    void handleBack() {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }

    void handleChange(field, value) {
      newProject ??= widget.project; // set newProject to widget.project if null
      Map<String, dynamic> projectMap = newProject!.toMap();
      projectMap[field] = value;
      setState(() => newProject = Project.fromMap(projectMap));
    }

    void handleSave() async {
      if (newProject!.id.isEmpty) {
        handleChange('id', const Uuid().v4());
        await ProjectService.addProject(context, newProject!);
      } else {
        await ProjectService.updateProject(context, newProject!);
      }

      // Check if the widget is still mounted before navigating
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved Project')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }

    void handleDelete() {
      ProjectService.deleteProject(context, widget.project);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted Project')),
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
          title: Text(isNew ? 'New Project' : 'Edit Project'),
          backgroundColor: const Color(0xff2bca70),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          actions: <Widget>[
            if (!isNew)
              DeleteDialog(
                  isDeleteDisabled: false,
                  isIconButton: true,
                  model: 'project',
                  onDelete: handleDelete,
                  confirmedWidgetPath: const Dashboard(),
                  buttonText: 'Delete Project')
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: SingleChildScrollView(
                child: ProjectForm(
                  onChange: handleChange,
                  onSave: handleSave,
                  project: newProject,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
