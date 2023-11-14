import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/screens/dashboard.dart';
import 'package:creaphur/widgets/forms/project_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    Profile? currentProfile = Provider.of<Profile?>(context, listen: true);
    void handleBack() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }

    void onChange(field, value) {}

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
                onChange: onChange,
                project: Project(
                    id: 'Default',
                    name: '',
                    profileId: currentProfile?.id ?? 'None',
                    startDate: DateTime.now(),
                    endDate: DateTime.now(),
                    estCost: 0.00),
              )),
        ),
      ),
    );
  }
}
