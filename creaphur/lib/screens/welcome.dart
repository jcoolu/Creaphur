import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController _name = TextEditingController();

  void handleNext() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Hi There!\n\n',
                          style: Theme.of(context).textTheme.headlineLarge),
                      const TextSpan(
                          text:
                              "Welcome to Creaphur, an app designed in helping with documenting your progress, materials, references, and anything else you would like to note about your project(s)!\n\n"),
                      const TextSpan(text: "What's your name? ("),
                      const TextSpan(
                          text: "Note: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                      const TextSpan(
                          text:
                              "All personal data entered will only be stored locally on your device)",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                    ]),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FilledButton(
          onPressed: _name.text.trim().isEmpty ? null : handleNext,
          style: ButtonStyle(
              overlayColor: MaterialStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.secondary)),
          child: const Text(
              'Next')), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
