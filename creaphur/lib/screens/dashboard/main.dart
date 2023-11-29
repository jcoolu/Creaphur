import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/models/project_list.dart';
import 'package:creaphur/screens/dashboard/home.dart';
import 'package:creaphur/screens/dashboard/materials.dart';
import 'package:creaphur/screens/profile.dart';
import 'package:creaphur/screens/project.dart';
import 'package:creaphur/screens/project_overview/main.dart';
import 'package:creaphur/widgets/filled_floating_action_button.dart';
import 'package:creaphur/widgets/project_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedScreen = 'home';
  @override
  Widget build(BuildContext context) {
    List<Project> projects =
        Provider.of<ProjectList>(context, listen: true).items;
    Profile currentProfile = Provider.of<Profile>(context, listen: true);

    void goToProfile() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen(
                    profile: currentProfile,
                  )));
    }

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
          builder: (context) => ProjectOverviewScreen(
            project: project,
          ),
        ),
      );
    }

    Widget handleScreen() {
      if (selectedScreen == 'materials') {
        return MaterialsScreen();
      }
      if (selectedScreen == 'profiles') {}
      return const HomeScreen();
    }

    void handleCreate() {
      if (selectedScreen == 'materials') {}
      if (selectedScreen == 'profiles') {}
      return createProject();
    }

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: const Color(0xff1d874b),
              height: 3.0,
            ),
          ),
          title: Text('Welcome, ${currentProfile.name}'),
          backgroundColor: const Color(0xff2bca70),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.person_2_rounded,
                color: Colors.white,
              ),
              onPressed: goToProfile,
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xff89e6b1),
                      ),
                      child: Text(
                        'Creaphur',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      selected: selectedScreen == 'home',
                      onTap: () {
                        setState(() {
                          selectedScreen = 'home';
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.search),
                      title: const Text('Materials'),
                      selected: selectedScreen == 'materials',
                      onTap: () {
                        setState(() {
                          selectedScreen = 'materials';
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Profiles'),
                      selected: selectedScreen == 'profiles',
                      onTap: () {
                        setState(() {
                          selectedScreen = 'profiles';
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info),
                selected: selectedScreen == 'info',
                title: const Text('About App'),
                onTap: () {
                  setState(() {
                    selectedScreen = 'info';
                  });
                },
              ),
            ],
          ),
        ),
        body: handleScreen(),
        floatingActionButton:
            FilledFloatingActionButton(onPressed: handleCreate));
  }
}
