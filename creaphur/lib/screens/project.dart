import 'package:creaphur/screens/dashboard.dart';
import 'package:creaphur/widgets/forms/name_form.dart';
import 'package:flutter/material.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  String name = '';

  void handleNext(String value) {
    setState(() => name = value);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
        title: const Text('Create Project'),
        actions: [
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
            child: Text(
                'No projects found. Please click (+) below to create a new project.'),
          ),
        ),
      ),
    );
  }
}
