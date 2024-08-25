import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/screens/dashboard/about.dart';
import 'package:creaphur/screens/dashboard/home.dart';
import 'package:creaphur/screens/dashboard/materials.dart';
import 'package:creaphur/screens/dashboard/settings.dart';
import 'package:creaphur/models/material.dart' as material_model;
import 'package:creaphur/screens/material.dart';
import 'package:creaphur/screens/profile.dart';
import 'package:creaphur/screens/project.dart';
import 'package:creaphur/widgets/filled_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  final String? previousState;
  const Dashboard({super.key, this.previousState});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String selectedScreen;
  late String title;

  @override
  void initState() {
    selectedScreen = widget.previousState ?? 'home';
    if (selectedScreen == 'about') {
      title = "About Creaphur";
    } else if (selectedScreen == 'materials') {
      title = "Materials";
    } else if (selectedScreen == 'settings') {
      title = "Settings";
    } else {
      title = "Welcome";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Profile currentProfile = Provider.of<Profile>(context, listen: true);
    bool isInHome = selectedScreen == 'home';

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

    void createMaterial() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MaterialScreen(
                material: material_model.Material.getBlankMaterial(
                    currentProfile.id)),
          ));
    }

    Widget handleScreen() {
      if (selectedScreen == 'materials') {
        return const MaterialsScreen();
      }
      if (selectedScreen == 'settings') {
        return const SettingsScreen();
      }
      if (selectedScreen == 'about') {
        return const AboutScreen();
      }
      return const HomeScreen();
    }

    void handleCreate() {
      if (selectedScreen == 'materials') {
        return createMaterial();
      }
      return createProject();
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: const Color(0xff1d874b),
                height: 3.0,
              ),
            ),
            title: Text(isInHome ? '$title, ${currentProfile.name}' : title),
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
                            title = 'Welcome';
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
                            title = 'Materials';
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('Settings'),
                        selected: selectedScreen == 'settings',
                        onTap: () {
                          setState(() {
                            selectedScreen = 'settings';
                            title = 'Settings';
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
                  selected: selectedScreen == 'about',
                  title: const Text('About Creaphur'),
                  onTap: () {
                    setState(() {
                      selectedScreen = 'about';
                      title = 'About Creaphur';
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          body: SafeArea(child: handleScreen()),
          floatingActionButton:
              ['home', 'materials', ''].contains(selectedScreen)
                  ? FilledFloatingActionButton(onPressed: handleCreate)
                  : null),
    );
  }
}
