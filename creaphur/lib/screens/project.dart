import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/screens/dashboard.dart';
import 'package:creaphur/services/project_service.dart';
import 'package:creaphur/widgets/forms/project_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    void handleBack() {
      Navigator.push(
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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved Project')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: handleBack,
        ),
        title: const Text('New Project'),
        backgroundColor: const Color(0xff2bca70),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
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
    );
  }
}
