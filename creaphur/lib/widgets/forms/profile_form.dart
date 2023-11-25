import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:creaphur/widgets/outlined_text_field.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class ProfileForm extends StatefulWidget {
  final Function setName;
  final String name;
  const ProfileForm({super.key, required this.setName, required this.name});

  @override
  ProfileFormState createState() {
    return ProfileFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class ProfileFormState extends State<ProfileForm> {
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
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedTextField(
                  initialValue: widget.name,
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
                  child: FilledActionButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Saved Profile')),
                        );
                      }
                    },
                    buttonText: 'Save',
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
