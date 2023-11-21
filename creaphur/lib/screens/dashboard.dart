import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/profile_list.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/models/project_list.dart';
import 'package:creaphur/screens/project.dart';
import 'package:creaphur/widgets/filled_floating_action_button.dart';
import 'package:creaphur/widgets/project_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    List<Project> projects =
        Provider.of<ProjectList>(context, listen: true).items;
    Profile currentProfile = Provider.of<Profile>(context, listen: true);

    void createProject() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectScreen(
                project: Project.getBlankProject(currentProfile.id)),
          ));
    }

    void selectProject(Project project) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectScreen(
            project: project,
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          leading: const IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: null,
          ),
          title: Text('Welcome, ${currentProfile.name}'),
          backgroundColor: const Color(0xff2bca70),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          actions: const [
            IconButton(
              icon: Icon(
                Icons.person_2_rounded,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: projects.isEmpty
                  ? Text(
                      'No projects found. Please click (+) below to create a new project.')
                  : SingleChildScrollView(
                      child: Column(
                        children: projects
                            .map(
                              (project) => ProjectSummaryCard(
                                project: project,
                                onTap: () => selectProject(project),
                              ),
                            )
                            .toList(),
                      ),
                    ),
            ),
          ),
        ),
        floatingActionButton:
            FilledFloatingActionButton(onPressed: createProject));
  }
}
