import 'package:creaphur/services/profile_service.dart';
import 'package:uuid/uuid.dart';
import 'package:creaphur/models/profile.dart';
import 'package:creaphur/screens/dashboard/main.dart';
import 'package:creaphur/widgets/forms/name_form.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String name = '';

  void handleNext(String value) async {
    setState(() => name = value);
    Profile profile = Profile(id: const Uuid().v4(), name: value);

    await ProfileService.addProfile(context, profile);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: NameForm(
            setName: handleNext,
          ),
        ),
      ),
    );
  }
}
