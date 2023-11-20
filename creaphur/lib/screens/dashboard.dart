import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/profile_list.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/screens/project.dart';
import 'package:creaphur/widgets/filled_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    List<Profile> profiles =
        Provider.of<ProfileList>(context, listen: true).items;
    Profile currentProfile = profiles.first;
    void createProject() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectScreen(
                project: Project.getBlankProject(currentProfile.id)),
          ));
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
        body: const SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text(
                  'No projects found. Please click (+) below to create a new project.'),
            ),
          ),
        ),
        floatingActionButton:
            FilledFloatingActionButton(onPressed: createProject));
  }
}
