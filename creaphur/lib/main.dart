import 'package:creaphur/models/expense_list.dart';
import 'package:creaphur/models/material_list.dart';
import 'package:creaphur/models/profile_list.dart';
import 'package:creaphur/models/project_list.dart';
import 'package:creaphur/models/time_entry_list.dart';
import 'package:creaphur/screens/welcome.dart';
import 'package:creaphur/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
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
    return MaterialApp(
      title: 'Creaphur',
      theme: appTheme(context),
      home: const WelcomePage(),
    );
  }
}
