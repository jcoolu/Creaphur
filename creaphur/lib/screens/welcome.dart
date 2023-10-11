import 'package:creaphur/widgets/forms/name_form.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String name = '';

  void handleNext(String value) {
    setState(() => name = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NameForm(
          setName: handleNext,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
