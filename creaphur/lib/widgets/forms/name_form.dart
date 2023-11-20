import 'package:creaphur/widgets/outlined_text_field.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class NameForm extends StatefulWidget {
  final Function setName;
  const NameForm({super.key, required this.setName});

  @override
  NameFormState createState() {
    return NameFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class NameFormState extends State<NameForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Padding(
      padding: const EdgeInsets.all(12),
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
          const SizedBox(height: 40),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedTextField(
                  initialValue: '',
                  hintText: 'Your Name',
                  labelText: 'Name *',
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    widget.setName(value);
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Saved Name')),
                        );
                      }
                    },
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
