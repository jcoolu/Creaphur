import 'package:creaphur/models/expense_list.dart';
import 'package:creaphur/models/project.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';

// Define a custom Form widget.
class ProjectForm extends StatefulWidget {
  final Function onChange;
  final Project project;
  const ProjectForm({super.key, required this.onChange, required this.project});

  @override
  ProjectFormState createState() {
    return ProjectFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<MultiSelectItem> expenses =
        Provider.of<ExpenseList>(context, listen: true)
            .items
            .where((e) => e.projectId == widget.project.id)
            .map((e) => MultiSelectItem(e, e.name))
            .toList();

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
                  initialValue: widget.project.name,
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
                  initialValue: widget.project.description,
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
                  // need to change to date time widget
                  initialValue: widget.project.startDate.toString(),
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
                  // need to change to date time widget
                  initialValue: widget.project.endDate.toString(),
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
                  initialValue: widget.project.estCost.toString(),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
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
