import 'package:creaphur/models/expense_list.dart';
import 'package:creaphur/models/material_list.dart';
import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/profile_list.dart';
import 'package:creaphur/models/project_list.dart';
import 'package:creaphur/models/time_entry_list.dart';
import 'package:creaphur/screens/dashboard/main.dart';
import 'package:creaphur/screens/welcome.dart';
import 'package:creaphur/common/theme.dart';
import 'package:creaphur/services/expense_service.dart';
import 'package:creaphur/services/material_service.dart';
import 'package:creaphur/services/profile_service.dart';
import 'package:creaphur/services/project_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Profile>(
        create: (context) => Profile(id: '', name: '')),
    ChangeNotifierProvider<ExpenseList>(create: (context) => ExpenseList([])),
    ChangeNotifierProvider<MaterialList>(create: (context) => MaterialList([])),
    ChangeNotifierProvider<ProjectList>(create: (context) => ProjectList([])),
    ChangeNotifierProvider<ProfileList>(create: (context) => ProfileList([])),
    ChangeNotifierProvider<TimeEntryList>(
        create: (context) => TimeEntryList([])),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> hasProfiles() async {
      await ProfileService.getProfiles(context);

      List<Profile> profiles =
          Provider.of<ProfileList>(context, listen: false).items;

      await ProjectService.getProjects(context, profiles.first.id);

      await ProfileService.setCurrent(context, profiles.first);

      await MaterialService.getMaterials(context, profiles.first.id);

      await ExpenseService.getExpenses(context, profiles.first.id);

      bool containsProfiles = profiles.isNotEmpty;

      return containsProfiles;
    }

    return MaterialApp(
      title: 'Creaphur',
      theme: appTheme(context),
      home: FutureBuilder<bool>(
        future: hasProfiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while the Future is in progress
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Show an error message if the Future completes with an error
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.data == true) {
              return const Dashboard();
            }
            return const WelcomePage();
          }
        },
      ),
    );
  }
}
