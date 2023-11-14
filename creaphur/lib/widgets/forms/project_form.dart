import 'package:flutter/material.dart';

// Define a custom Form widget.
class ProjectForm extends StatefulWidget {
  final Function onChange;
  const ProjectForm({super.key, required this.onChange});

  @override
  ProjectFormState createState() {
    return ProjectFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class ProjectFormState extends State<ProjectForm> {
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
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Project Name',
                    labelText: 'Name *',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name for your project';
                    }
                    widget.onChange('name', value);
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Project Description',
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    widget.onChange('description', value);
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Projected Start Date for Project',
                    labelText: 'Projected Start Date *',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a projected start date for your project';
                    }
                    widget.onChange('startDate', value);
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Projected End Date for Project',
                    labelText: 'Projected End Date *',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a projected end date for your project';
                    }
                    widget.onChange('endDate', value);
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Projected Cost for Project',
                    labelText: 'Projected Cost *',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a projected cost for your project';
                    }
                    widget.onChange('estCost', value);
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: const Text('Save'),
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
