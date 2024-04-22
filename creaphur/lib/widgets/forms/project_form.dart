import 'package:creaphur/common/utils.dart';
import 'package:creaphur/models/project.dart';
import 'package:creaphur/widgets/date_time_picker.dart';
import 'package:creaphur/widgets/filled_action_button.dart';
import 'package:creaphur/widgets/outlined_file_picker.dart';
import 'package:creaphur/widgets/outlined_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Define a custom Form widget.
class ProjectForm extends StatefulWidget {
  final Function onChange;
  final Project? project;
  final Function onSave;

  const ProjectForm(
      {super.key,
      required this.onChange,
      required this.project,
      required this.onSave});

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
              widget.project!.endDate.hour,
              widget.project!.endDate.minute,
            ));
      } else {
        TimeOfDay nextTime = value;
        widget.onChange(
            'endDate',
            DateTime(
              widget.project!.endDate.year,
              widget.project!.endDate.month,
              widget.project!.endDate.day,
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
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: OutlinedTextField(
                    initialValue: widget.project?.name ?? '',
                    hintText: 'Project Name',
                    labelText: 'Name *',
                    maxLines: 1,
                    onChange: (value) => widget.onChange('name', value),
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name for your project';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OutlinedTextField(
                    initialValue: widget.project?.description ?? '',
                    hintText: 'Project Description',
                    labelText: 'Description',
                    onChange: (value) => widget.onChange('description', value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DropdownButton<String>(
                      hint: const Text('Status of Project'),
                      isExpanded: true,
                      value:
                          widget.project?.status ?? Project.getStatuses().first,
                      items: Project.getStatuses()
                          .map((status) => DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: (value) => widget.onChange('status', value)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DateTimePicker(
                      dateTime: widget.project?.startDate ?? DateTime.now(),
                      onChange: handleChangeStartDate,
                      buttonText: 'Projected Start'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DateTimePicker(
                      dateTime: widget.project?.endDate ??
                          DateTime.now().add(const Duration(days: 1)),
                      onChange: handleChangeEndDate,
                      buttonText: 'Projected End'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OutlinedTextField(
                    initialValue:
                        widget.project?.estCost.toStringAsFixed(2) ?? '0.00',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    maxLines: 1,
                    hintText: 'Projected Cost for Project',
                    labelText: 'Projected Cost *',
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a projected cost for your project';
                      }
                      if (!Utils.isCurrencyValid(value)) {
                        return 'Please enter a valid format for Projected Cost.';
                      }
                      widget.onChange('estCost', double.parse(value));
                      return null;
                    },
                  ),
                ),
                OutlinedFilePicker(
                  onChange: widget.onChange,
                  childWidget: Text(
                      (widget.project == null || widget.project!.image.isEmpty)
                          ? 'Select File'
                          : 'Image Selected'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: FilledActionButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onSave();
                        }
                      },
                      buttonText: 'Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
