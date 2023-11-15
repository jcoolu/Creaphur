import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/screens/dashboard.dart';
import 'package:creaphur/widgets/forms/project_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectScreen extends StatefulWidget {
  final Project project;
  const ProjectScreen({super.key, required this.project});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  String name = '';
  Project? newProject;

  @override
  Widget build(BuildContext context) {
    Profile? currentProfile = Provider.of<Profile?>(context, listen: true);

    void handleBack() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }

    void handleChange(field, value) {
      if (newProject == null) {
        newProject = widget.project;
      }
      Map<String, dynamic> projectMap = newProject.toMap();
      projectMap[field] = value.toString();
      setState(() => newProject = Project.fromMap(projectMap));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: handleBack,
        ),
        title: const Text('New Project'),
        actions: const [
          IconButton(
            icon: Icon(Icons.person_2_rounded),
            onPressed: null,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: ProjectForm(
                onChange: handleChange,
                project: newProject ?? widget.project,
              )),
        ),
      ),
    );
  }
}
