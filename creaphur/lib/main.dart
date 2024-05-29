import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/expense_list.dart';
import 'package:creaphur/models/material_list.dart';
import 'package:creaphur/models/profile.dart';
import 'package:creaphur/models/profile_list.dart';
import 'package:creaphur/models/project_list.dart';
import 'package:creaphur/models/time_entry_list.dart';
import 'package:creaphur/screens/dashboard/main.dart';
import 'package:creaphur/screens/welcome.dart';
import 'package:creaphur/common/theme.dart';
import 'package:creaphur/services/profile_service.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> _hasProfilesFuture;

  @override
  void initState() {
    super.initState();
    _hasProfilesFuture = hasProfiles();
  }

  Future<bool> hasProfiles() async {
    List<Profile> profiles =
        Provider.of<ProfileList>(context, listen: false).items;

    await ProfileService.getProfiles(context);

    if (!mounted) return false;

    if (profiles.isNotEmpty) {
      await Utils.load(context, profiles.first);
    }

    return profiles.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Creaphur',
      theme: appTheme(context),
      home: FutureBuilder<bool>(
        future: _hasProfilesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while the Future is in progress
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Show an error message if the Future completes with an error
            return Center(child: Text('Error: ${snapshot.error}'));
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
