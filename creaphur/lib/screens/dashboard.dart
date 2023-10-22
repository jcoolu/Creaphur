import 'package:creaphur/screens/project.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    void createProject() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProjectScreen()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
        title: const Text('Welcome, {Name}'),
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
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.add),
        onPressed: createProject,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}
