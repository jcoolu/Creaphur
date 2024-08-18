import 'package:creaphur/models/project.dart';
import 'package:creaphur/models/project_list.dart';
import 'package:creaphur/screens/project_overview/main.dart';
import 'package:creaphur/widgets/project_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Project> projects =
        Provider.of<ProjectList>(context, listen: true).items;

    void selectProject(Project project) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectOverviewScreen(
            project: project,
          ),
        ),
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: projects.isEmpty
            ? const Center(
                child: Text(
                    'No projects found. Please click (+) below to create a new project.'),
              )
            : ListView(
                children: [
                  ...projects
                      .map(
                        (project) => ProjectSummaryCard(
                          project: project,
                          onTap: () => selectProject(project),
                        ),
                      )
                      .toList(),
                  SizedBox(height: 200),
                  Center(
                    child: Image.asset(
                        'lib/common/assets/ginger_sewing_front.gif',
                        height: 350,
                        fit: BoxFit.fill),
                  ),
                ],
              ),
      ),
    );
  }
}
