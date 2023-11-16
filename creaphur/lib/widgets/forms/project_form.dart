import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/widgets/date_time_picker.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class ProjectForm extends StatefulWidget {
  final Function onChange;
  final Project? project;
  const ProjectForm({super.key, required this.onChange, required this.project});

  @override
  ProjectFormState createState() {
    return ProjectFormState();
  }
}

class ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void handleChangeStartDate(field, value) {
      if (field == 'date') {
        DateTime nextDate = value;
        widget.onChange(
            'startDate',
            DateTime(
              nextDate.year,
              nextDate.month,
              nextDate.day,
              widget.project!.startDate.hour,
              widget.project!.startDate.minute,
            ));
      } else {
        TimeOfDay nextTime = value;
        widget.onChange(
            'startDate',
            DateTime(
              widget.project!.startDate.year,
              widget.project!.startDate.month,
              widget.project!.startDate.day,
              nextTime.hour,
              nextTime.minute,
            ));
      }
    }

    void handleChangeEndDate(field, value) {
      if (field == 'date') {
        DateTime nextDate = value;
        widget.onChange(
            'endDate',
            DateTime(
              nextDate.year,
              nextDate.month,
              nextDate.day,
              widget.project!.startDate.hour,
              widget.project!.startDate.minute,
            ));
      } else {
        TimeOfDay nextTime = value;
        widget.onChange(
            'endDate',
            DateTime(
              widget.project!.startDate.year,
              widget.project!.startDate.month,
              widget.project!.startDate.day,
              nextTime.hour,
              nextTime.minute,
            ));
      }
    }

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
                  initialValue: widget.project?.name ?? '',
                  decoration: const InputDecoration(
                    hintText: 'Project Name',
                    labelText: 'Name *',
                  ),
                  onChanged: (value) => widget.onChange('name', value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name for your project';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: widget.project?.description ?? '',
                  decoration: const InputDecoration(
                    hintText: 'Project Description',
                    labelText: 'Description',
                  ),
                  onChanged: (value) => widget.onChange('description', value),
                ),
                DateTimePicker(
                    dateTime: widget.project?.startDate ?? DateTime.now(),
                    onChange: handleChangeStartDate,
                    buttonText: 'Projected Start'),
                DateTimePicker(
                    dateTime: widget.project?.endDate ??
                        DateTime.now().add(const Duration(days: 1)),
                    onChange: handleChangeEndDate,
                    buttonText: 'Projected End'),
                TextFormField(
                  initialValue: widget.project?.estCost.toString() ?? '0.00',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    hintText: 'Projected Cost for Project',
                    labelText: 'Projected Cost *',
                  ),
                  onChanged: (value) {
                    if (!Utils.isCurrencyValid(value)) {
                      widget.onChange('estCost', value);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a projected cost for your project';
                    }
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
